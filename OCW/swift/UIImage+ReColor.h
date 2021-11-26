//
//  UIImage+ReColor.h
//  OCW
//
//  Created by 王晓冉 on 2021/11/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ReColor)

/// 重绘图片 可以把mask更换颜色
/// @param color 颜色
/// @param size 大小
-(UIImage *)reColor:(UIColor *)color size:(CGSize)size;



@end

NS_ASSUME_NONNULL_END
