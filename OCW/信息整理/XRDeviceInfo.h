//
//  XRDeviceInfo.h
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/4/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XRDeviceInfoConfig : NSObject
/** 是否支持并发调用  默认yes*/
@property(nonatomic,assign)BOOL supportBingFa;
/** 返回主线程 默认yes*/
@property(nonatomic,assign)BOOL backToMainThread;

@property(nonatomic,assign)BOOL isDebug;
/** 是否同意用户隐私协议 默认NO*/
@property(nonatomic,assign)BOOL isAgreePrivacy;

@end


@interface XRDeviceInfo : NSObject

+(instancetype)shareInstance;

-(void)registAppKey:(NSString *)key configBlock:(void(^_Nullable)(XRDeviceInfoConfig *config))configBlock;


/*  deviceInfo  */

/*设备信息大类__设备基本参数 index=0*/
///操作系统
@property (nonatomic, strong, readonly) NSString *os;
///操作系统版本
@property (nonatomic, strong, readonly) NSString *osVersion;
///型号
@property (nonatomic, strong, readonly) NSString *p_model;




-(NSDictionary *)getAllDeviceInfo;
-(void)asyncGetAllDeviceInfo:(void(^)(NSDictionary * _Nullable dic))block;

@end

NS_ASSUME_NONNULL_END
