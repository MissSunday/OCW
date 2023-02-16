


#import "NSBundle+XRBundle.h"
#import "XRResourcesIndex.h"

@implementation NSBundle (XRBundle)
+ (instancetype)xr_supportBundle
{
    static NSBundle *XRBundle = nil;
    if (XRBundle == nil) {
#ifdef SWIFT_PACKAGE
        //暂时还不会支持swift
        NSBundle *containnerBundle = nil;
#else
        NSBundle *containnerBundle = [NSBundle bundleForClass:[XRResourcesIndex class]];
#endif
        XRBundle = [NSBundle bundleWithPath:[containnerBundle pathForResource:@"XROCSupport" ofType:@"bundle"]];
    }
    return XRBundle;
}
+ (UIImage *)xr_navBackImage{
    static UIImage *arrowImage = nil;
    if (arrowImage == nil) {
        NSString *name = [UIScreen mainScreen].scale > 2 ? @"navbackimg@2x" : @"navbackimg@3x";
        arrowImage = [[UIImage imageWithContentsOfFile:[[self xr_supportBundle] pathForResource:name ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return arrowImage;
}



@end

