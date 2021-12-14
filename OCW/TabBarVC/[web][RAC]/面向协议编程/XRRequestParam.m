//
//  XRRequestParam.m
//  OCW
//
//  Created by 王晓冉 on 2021/12/13.
//

#import "XRRequestParam.h"

@implementation XRRequestParam
/** 获取请求参数 */
+ (instancetype)getRequestParam{
    XRRequestParam *param = [[XRRequestParam alloc]init];
    
    return param;
}
+ (instancetype)postWithParam:(NSDictionary *)param url:(NSString *)url{
    XRRequestParam *p = [[XRRequestParam alloc]init];
    p.requestType = Post;
    p.param = param;
    p.url = [NSString stringWithFormat:@"%@%@",p.baseUrl,url];
    return p;
}
+ (instancetype)getWithUrl:(NSString *)url{
    
    XRRequestParam *p = [[XRRequestParam alloc]init];
    p.requestType = Get;
    p.param = @{};
    p.url = [NSString stringWithFormat:@"%@%@",p.baseUrl,url];
    return p;
}
- (NSString *)baseUrl{
    return @"https://www.baidu.com/";
}
@synthesize baseUrl;

@synthesize url;

@synthesize requestType;

@synthesize param;
@end
