//
//  UIColor+someColor.h
//  carEasy
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 MissSunday. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (someColor)
/**
 常用颜色定义
 @author 王晓冉
 @date 2020/04/03
 */
//注：不要轻易修改这里边，这是全局的

/** 主色调*/
+(UIColor *)mainColor;
/** vc的背景颜色*/
+(UIColor *)vcBackgroundColor;
/** 默认文字颜色（差不多是黑色）*/
+(UIColor *)color63;
/** 20%黑*/
+(UIColor *)color62;
/** 浅灰文字颜色*/
+(UIColor *)color69;
/** 浅黑色*/
+ (UIColor *)color66;
/** 分割线颜色*/
+ (UIColor *)color6E;
/** 分割线深色*/
+ (UIColor *)colorE6;
/** F5灰色*/
+ (UIColor *)colorF5;
/** 随机颜色*/
+ (UIColor *)randomColor;

@end

NS_ASSUME_NONNULL_END
