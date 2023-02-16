//
//  XRNetRequest.m
//  OCW
//
//  Created by 朵朵 on 2021/7/26.
//

#import "XRNetRequest.h"

@implementation XRNetRequest
// !!!: post
+ (void)postWithUrl:(NSString *)url header:(NSDictionary *)headerParams body:(NSDictionary *)bodyParams success:(void (^)(id _Nullable, BOOL))success failure:(void (^)(NSError * _Nonnull, BOOL))failure{
    [self requestWay:@"post" url:url header:headerParams body:bodyParams success:^(id  _Nullable data, BOOL isCanUse) {
        success(data,isCanUse);
    } failure:^(NSError * _Nonnull error, BOOL haveNet) {
        failure(error,haveNet);
    }];
}
// !!!: get
+ (void)getWithUrl:(NSString *)url header:(NSDictionary *)headerParams success:(void (^)(id _Nullable, BOOL))success failure:(void (^)(NSError * _Nonnull, BOOL))failure{
    [self requestWay:@"get" url:url header:headerParams body:nil success:^(id  _Nullable data, BOOL isCanUse) {
        success(data,isCanUse);
    } failure:^(NSError * _Nonnull error, BOOL haveNet) {
        failure(error,haveNet);
    }];
}
// !!!: put
+ (void)putWithUrl:(NSString *)url header:(NSDictionary *)headerParams body:(NSDictionary *)bodyParams success:(void (^)(id _Nullable, BOOL))success failure:(void (^)(NSError * _Nonnull, BOOL))failure{
    [self requestWay:@"put" url:url header:headerParams body:bodyParams success:^(id  _Nullable data, BOOL isCanUse) {
        success(data,isCanUse);
    } failure:^(NSError * _Nonnull error, BOOL haveNet) {
        failure(error,haveNet);
    }];
}

/// !!!: 封装系统级网络请求
/// @param way 请求方式 post get啥的
/// @param url url
/// @param headerParams header
/// @param bodyParams body
/// @param success 成功回调  这里判断下statuscode是否是1000  不是1000的话 就说明返回的不是正常数据  需要单独解析
/// @param failure 返回错误和当前手机网络
+(void)requestWay:(NSString *)way url:(NSString *)url header:(NSDictionary *)headerParams body:(NSDictionary *)bodyParams success:(void (^)(id _Nullable data, BOOL isCanUse))success failure:(void (^)(NSError * _Nonnull error, BOOL haveNet))failure{

    //NSURLSession
    NSURL *URL = [NSURL URLWithString:url];//URL地址
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPMethod:way];//请求方式
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setTimeoutInterval:20.0];//超时时间
    
    if (bodyParams) {
        [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:bodyParams options:NSJSONWritingPrettyPrinted error:nil]];//参数内容
    }
    if (headerParams) {
        [request setAllHTTPHeaderFields:headerParams];
    }
    NSURLSession *session = [NSURLSession sharedSession];
    // 异步执行任务创建方法
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 这里放异步执行任务代码

        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    BOOL havNet = [self isConnectionAvailable];
                    failure(error,havNet);
                });
            }else{
                NSDictionary * result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];//解析结果
                //NSLog(@"%@",[result descriptionWithLocale:nil]);
                dispatch_async(dispatch_get_main_queue(), ^{
                    BOOL isCanUse = [self checkCanUse:result];
                    success(result,isCanUse);
                });
            }
        }];//封装请求
        [task resume];//开始请求
    });
}
// !!!: 判断是否是可用数据
+ (BOOL)checkCanUse:(id)responseObject{
    
    return YES;
}

+(BOOL)isConnectionAvailable{
 
    BOOL haveNet = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            haveNet = NO;
            //NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            haveNet = YES;
            //NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            haveNet = YES;
            //NSLog(@"3G");
            break;
    }
    return haveNet;
}
@end
