//
//  XXSDK.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/2/24.
//

#import "XXSDK.h"
#import "XRRequest.h"
#import "XRRequestParam.h"


@interface XXSDK ()
@property(nonatomic,strong)dispatch_queue_t apiQueue;
@property(nonatomic,strong)dispatch_semaphore_t semaphore;
@property(nonatomic,strong)XXSDKConfig *config;

typedef XXSDK *_Nonnull(^XXSDK_LogBlock)(id _Nullable obj);

-(void)log:(id)description;
//另一种用法
-(XXSDK_LogBlock)log;
@end

static XXSDK *_sdk = nil;
@implementation XXSDK


+(instancetype)sdk{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sdk = [[super allocWithZone:nil] init];
        _sdk.config = [XXSDKConfig config];
        _sdk.apiQueue = dispatch_queue_create("api.concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
        _sdk.semaphore = dispatch_semaphore_create(1);
    });
    return _sdk;
}

+(id)allocWithZone:(NSZone *)zone{
    return [self sdk];
}
-(id)copyWithZone:(NSZone *)zone{
    return [[self class] sdk];
}
-(id)mutableCopyWithZone:(NSZone *)zone{
    return [[self class] sdk];
}
- (void)registAppKey:(NSString *)key configBlock:(void (^)(XXSDKConfig * _Nonnull))configBlock{
    
    //注册key
    //返回配置项
    
    configBlock(_sdk.config);
    
    
}
- (void)getTokenSync:(void (^)(id _Nonnull))success{
    dispatch_sync(self.apiQueue, ^{
        sleep(1);
        success(@77777);
    });
}
- (void)getTokenAsync:(void (^)(id _Nonnull))success{
    dispatch_async(self.apiQueue, ^{
        if (!self.config.supportBingFa) {
            dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
        }
        //创建参数可以加锁 保证并发不会出现问题
        XRRequestParam *param = [XRRequestParam postWithParam:@{@"token":@"gk"} url:@"666"];
        [[XRRequest shareManager]requestWithParam:param complete:^(NSDictionary * _Nonnull response) {
            self.log(@"请求成功");
            [self back:response blcok:success];
        } failed:^(NSDictionary * _Nonnull error) {
            [self back:error blcok:success];
        }];
    });
    
}
-(void)back:(id)info blcok:(void(^)(id))blcok{
    dispatch_async(self.config.backToMainThread ? dispatch_get_main_queue() : self.apiQueue, ^{
        self.log(@"请求返回");
        blcok(info);
        if (!self.config.supportBingFa) {
            dispatch_semaphore_signal(self.semaphore);
        }
    });

}




#pragma mark - 输出
// !!!: 仅供debug测试输出 上线前一定要关闭log，否则可能审核不过或影响性能
- (void)log:(id)description{
    @try {
        if (self.config.needLog) {
            NSLog(@"%@ %@",description,[NSThread currentThread]);
        }
    } @catch (NSException *exception) {} @finally {}
}
- (XXSDK_LogBlock)log{
    return ^(id obj){
        [self log:obj];
        return self;
    };
}

@end
