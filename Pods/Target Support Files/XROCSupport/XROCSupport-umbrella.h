#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "XROCSupport.h"
#import "XRPCH.h"
#import "XRTool.h"
#import "XRBaseNavigationController.h"
#import "XRBaseViewController.h"
#import "NSBundle+XRBundle.h"
#import "NSObject+Property.h"
#import "NSString+STRegex.h"
#import "UIFont+XRScale.h"
#import "UIImage+ReColor.h"
#import "XRResourcesIndex.h"

FOUNDATION_EXPORT double XROCSupportVersionNumber;
FOUNDATION_EXPORT const unsigned char XROCSupportVersionString[];

