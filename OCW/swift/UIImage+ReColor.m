//
//  UIImage+ReColor.m
//  OCW
//
//  Created by 王晓冉 on 2021/11/24.
//

#import "UIImage+ReColor.h"
#import <ImageIO/ImageIO.h>
#import <Accelerate/Accelerate.h>
#import <objc/runtime.h>
@implementation UIImage (ReColor)
- (UIImage *)reColor:(UIColor *)color size:(CGSize)size{
    @autoreleasepool {
        

        UIGraphicsBeginImageContextWithOptions(size, false, self.scale);
        [color setFill];
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextTranslateCTM(context, 0, size.height);
        CGContextScaleCTM(context, 1, -1);
        CGContextSetBlendMode(context, kCGBlendModeNormal);
        
        CGImageRef cgimage = self.CGImage;
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        CGContextClipToMask(context, rect, cgimage);
        CGContextFillRect(context, rect);
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();

        return image;
    }
}
@end
