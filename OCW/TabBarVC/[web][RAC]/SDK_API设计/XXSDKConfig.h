//
//  XXSDKConfig.h
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/2/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XXSDKConfig : NSObject
/** 是否支持并发调用  默认yes*/
@property(nonatomic,assign)BOOL supportBingFa;
/** 返回主线程 默认yes*/
@property(nonatomic,assign)BOOL backToMainThread;

@property(nonatomic,assign)BOOL isDebug;

@end

NS_ASSUME_NONNULL_END
