//
//  XRPCH.h
//  XROCSupport
//
//  Created by ext.wangxiaoran3 on 2023/1/31.
//

#ifndef XRPCH_h
#define XRPCH_h



#import "XRTool.h"

//宏定义
#define kStatuBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
#define IS_IPHONEX [XRTool tool].isIPhoneX
#define kS_H [UIScreen mainScreen].bounds.size.height
#define kS_W [UIScreen mainScreen].bounds.size.width
#define kNavHeight (IS_IPHONEX ? (kStatuBarHeight + 44) : 64)
#define kTabbarHeight  (IS_IPHONEX ? 83 : 49)
#define kBottomHeight (IS_IPHONEX ? 34 : 0)
#define kBottomLittleHeiget (IS_IPHONEX ? 14 : 0)
/** 屏幕适配比率 */
static inline CGFloat XR_Scale(CGFloat a){
    return (kS_W/375)*(a);
}





#endif /* XRPCH_h */
