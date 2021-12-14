//
//  XRRequest.m
//  OCW
//
//  Created by 王晓冉 on 2021/12/13.
//

#import "XRRequest.h"
static XRRequest *_instance = nil;

@implementation XRRequest
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    });
    return _instance;
}

+ (instancetype)shareManager {
    return [[self alloc] init];
}
- (void)requestWithParam:(id<XRRequestParamProtocol>)param complete:(void (^)(NSDictionary * _Nonnull))complete failed:(void (^)(NSDictionary * _Nonnull))failed{
    
    NSLog(@"- %@ -%@ -%ld",param.param,param.url,param.requestType);
    
    complete(@{@"key":@"成功"});
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        failed(@{@"error":@"超时了"});
    });
    
    
}
@end
