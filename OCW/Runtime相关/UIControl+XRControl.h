//
//  UIControl+XRControl.h
//  OCW
//
//  Created by ext.wangxiaoran3 on 2023/3/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (XRControl)

//防止暴力点击的方案

// 是否忽略事件
@property(nonatomic,assign)BOOL ignore;

// 延迟多少秒可继续执行
@property (nonatomic,assign)NSTimeInterval delayInterval;

@end

NS_ASSUME_NONNULL_END
