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

@property(nonatomic,strong)dispatch_semaphore_t semaphore;
@property(nonatomic,strong)XXSDKConfig *config;

@end

static XXSDK *_sdk = nil;
@implementation XXSDK


+(instancetype)sdk{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sdk = [[super allocWithZone:nil] init];
        _sdk.config = [XXSDKConfig new];
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
- (void)getToken:(void (^)(id _Nonnull))success{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (!self.config.supportBingFa) {
            dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
        }
        //创建参数可以加锁 保证并发不会出现问题
        XRRequestParam *param = [XRRequestParam postWithParam:@{@"token":@"gk"} url:@"666"];
        [[XRRequest shareManager]requestWithParam:param complete:^(NSDictionary * _Nonnull response) {
            
                dispatch_async(self.config.backToMainThread ? dispatch_get_main_queue() : dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSLog(@"请求返回 - %@",[NSThread currentThread]);
                    success(response);
                    if (!self.config.supportBingFa) {
                        dispatch_semaphore_signal(self.semaphore);
                    }
                });
        } failed:^(NSDictionary * _Nonnull error) {
        
        }];
        
    });
    
}




@end
