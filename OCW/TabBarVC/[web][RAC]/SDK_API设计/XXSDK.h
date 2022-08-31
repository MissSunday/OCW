//
//  XXSDK.h
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/2/24.
//

#import <Foundation/Foundation.h>
#import "XXSDKConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface XXSDK : NSObject


+(instancetype)sdk;

//必须且只能设置一次  如果多次调用此方法，会导致数据错误（其实是线程锁死，无法解锁）
-(void)registAppKey:(NSString *)key configBlock:(void(^)(XXSDKConfig *config))configBlock;

//异步回调 在新的线程执行任务，默认在子线程返回数据，如果配置设置backToMainThread = YES，将会在主线程返回
-(void)getTokenAsync:(void(^)(id object))success;

//同步 在当前队列执行 在当前队列返回 不会开辟新的线程
-(id)getTokenSync;
@end

NS_ASSUME_NONNULL_END

