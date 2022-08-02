//
//  XXSDKConfig.h
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/2/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XXSDKConfig : NSObject

+(instancetype)config;

/** 是否支持并发调用  默认yes */
@property(nonatomic,assign)BOOL supportBingFa;
/** 返回主线程 默认NO*/
@property(nonatomic,assign)BOOL backToMainThread;

@property(nonatomic,assign)BOOL isDebug;
//是否输出日志，默认NO
@property(nonatomic,assign)BOOL needLog;

@end

NS_ASSUME_NONNULL_END
