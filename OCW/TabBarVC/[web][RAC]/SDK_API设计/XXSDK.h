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

//耗时操作 异步回调
-(void)getToken:(void(^)(id object))success;


@end

NS_ASSUME_NONNULL_END

