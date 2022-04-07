//
//  UIFont+XRScale.h
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/4/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (XRScale)
+(UIFont *)ScaleFontOfSize:(CGFloat)fontSize;
+(UIFont *)ScaleFontOfSize:(CGFloat)fontSize weight:(UIFontWeight)weight;
+(UIFont *)ScaleBoldFontOfSize:(CGFloat)fontSize;
@end

NS_ASSUME_NONNULL_END
