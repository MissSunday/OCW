//
//  KNPhotoBrowser.h
//  KNPhotoBrowser
//
//  Created by LuKane on 16/8/18.
//  Copyright © 2016年 LuKane. All rights reserved.
//

/**
 *  如果 bug ,希望各位在 github 上通过'邮箱' 或者直接 issue 指出, 谢谢
 *  github地址 : https://github.com/LuKane/KNPhotoBrowser
 *  项目会越来越丰富,也希望大家一起来增加功能 , 欢迎 Star
 */

#ifndef ScreenWidth
    #define ScreenWidth [UIScreen mainScreen].bounds.size.width
#endif

#ifndef ScreenHeight
    #define ScreenHeight [UIScreen mainScreen].bounds.size.height
#endif

/// iPhoneX
#ifndef iPhoneX
    #define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : false)
#endif

/// iPhoneXR
#ifndef iPhoneXR
    #define iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828 , 1792), [[UIScreen mainScreen] currentMode].size) : false)
#endif

/// iPhoneXs_max
#ifndef iPhoneXs_Max
    #define iPhoneXs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242 , 2688), [[UIScreen mainScreen] currentMode].size) : false)
#endif

/// iPhone12
#ifndef iPhone12
    #define iPhone12 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1170 , 2532), [[UIScreen mainScreen] currentMode].size) : false)
#endif

/// iPhone12_pro_max
#ifndef iPhone12_Pro_Max
    #define iPhone12_Pro_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1284 , 2778), [[UIScreen mainScreen] currentMode].size) : false)
#endif

/// Portrait
#ifndef isPortrait
    #define isPortrait ([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait || [[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortraitUpsideDown)
#endif


#define PhotoBrowserAnimateTime 0.3

// define SDWebImagePrefetcher max number
#define PhotoBrowserPrefetchNum     8


