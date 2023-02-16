//
//  XRAFNRequest.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2023/2/7.
//

#import "XRAFNRequest.h"



@implementation XRAFNRequest



-(void)req{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10.f;
    
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //随机的串行队列
    manager.completionQueue = dispatch_queue_create("XR_RandomQueue", DISPATCH_QUEUE_SERIAL);

    
    
    [manager GET:@"https://www.baidu.com" parameters:@{} headers:@{} progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"1---- %@",[NSThread currentThread]);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"2---- %@",[NSThread currentThread]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"3---- %@",[NSThread currentThread]);
    }];
    
    
    
}









@end
