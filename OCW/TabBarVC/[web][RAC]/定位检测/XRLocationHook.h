//
//  XRLocationHook.h
//  OCW
//
//  Created by ext.wangxiaoran3 on 2023/2/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface XRLocationHook : NSObject
// !!!: 定位api hook相关检测项
// !!!: 可能无法检测黑产利用fishhook修改系统API的情况
// !!!: 可以检测越狱和重签名注入

//返回相关api的信息，未检测到hook则返回空数组
+ (NSString *)locationApiHookInfo;

/// - Description 检测CLLocationManager部分API是否被hook，返回数组内有信息有hook相关信息
+ (NSArray *)checkCLLocationManagerDetectApis;

/// - Description 检测CLLocation部分API是否被hook，返回数组内有信息有hook相关信息
+ (NSArray *)checkCLLocationDetectApis;

/// - Description 检测CLLocationSourceInformation部分API是否被hook，返回数组内有信息有hook相关信息  iOS 15.0以上 调用
+ (NSArray *)checkCLLocationSourceInformationDetectApis API_AVAILABLE(ios(15.0));

@end

NS_ASSUME_NONNULL_END
