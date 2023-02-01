//
//  XRTool.h
//  XRToolSDK
//
//  Created by 朵朵 on 2021/8/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XRTool : NSObject

//记录一些工具属性 为了防止多次调用 用单利获取后记录  方法执行次数尽量控制在一次
@property(nonatomic,readonly,assign)BOOL isIPad;
@property(nonatomic,readonly,assign)BOOL isIPhoneX; //是否是刘海屏

//单利
+(instancetype)tool;

// !!!: 判断是否是数组
FOUNDATION_EXTERN BOOL isArray(id array);
// !!!: 判断是否是字典
FOUNDATION_EXTERN BOOL isDictionary(id dic);
// !!!: 判断是否是字符串
FOUNDATION_EXTERN BOOL isString(id string);

@end

NS_ASSUME_NONNULL_END
