//
//  UIFont+XRScale.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/4/7.
//

#import "UIFont+XRScale.h"

@implementation UIFont (XRScale)
+(UIFont *)ScaleFontOfSize:(CGFloat)fontSize{
    return [self ScaleFontOfSize:fontSize weight:(UIFontWeightRegular)];
}
+(UIFont *)ScaleFontOfSize:(CGFloat)fontSize weight:(UIFontWeight)weight{
    return [self systemFontOfSize:XR_Scale(fontSize) weight:weight];
}
+(UIFont *)ScaleBoldFontOfSize:(CGFloat)fontSize{
    return [self boldSystemFontOfSize:XR_Scale(fontSize)];
}
@end
