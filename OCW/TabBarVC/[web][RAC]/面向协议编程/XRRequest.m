//
//  XRRequest.m
//  OCW
//
//  Created by 王晓冉 on 2021/12/13.
//

#import "XRRequest.h"
static XRRequest *_instance = nil;

@interface XRRequest ()

@property(nonatomic,strong)dispatch_queue_t queue;

@end

@implementation XRRequest


+ (instancetype)shareManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:nil] init];
        _instance.queue = dispatch_queue_create("requestQueue", DISPATCH_QUEUE_CONCURRENT);
    });
    return _instance;
}
+(id)allocWithZone:(NSZone *)zone{
    return [self shareManager];
}
-(id)copyWithZone:(NSZone *)zone{
    return [[self class] shareManager];
}
-(id)mutableCopyWithZone:(NSZone *)zone{
    return [[self class] shareManager];
}

- (void)requestWithParam:(id<XRRequestParamProtocol>)param complete:(void (^)(NSDictionary * _Nonnull))complete failed:(void (^)(NSDictionary * _Nonnull))failed{
    
    NSLog(@"=== %@",param);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"请求内部 - %@",[NSThread currentThread]);
        
        [NSThread sleepForTimeInterval:1];
        
        complete(@{@"key":@"successed"});
       
    });
    
   
    
    
}
@end
