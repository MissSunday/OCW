//
//  XRRequest.m
//  OCW
//
//  Created by 王晓冉 on 2021/12/13.
//

#import "XRRequest.h"
static XRRequest *_instance = nil;

@implementation XRRequest


+ (instancetype)shareManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:nil] init];
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
    
    NSLog(@"- %@ -%@ -%ld",param.param,param.url,param.requestType);
    
    complete(@{@"key":@"成功"});
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        failed(@{@"error":@"超时了"});
    });
    
    
}
@end
