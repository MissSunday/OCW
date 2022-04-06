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
+(BOOL)isArray:(NSArray *)array;
// !!!: 判断是否是字典
+(BOOL)isDictionary:(NSDictionary *)dic;
// !!!: 判断是否是字符串
+(BOOL)isString:(NSString *)string;

+(void)logPropertyOfClass:(Class)cls;
+(void)logMethodNamesOfClass:(Class)cls;

//runtime模糊调用方法传2个以上参数
+ (id)performSelectorWithClassName:(NSString *)className
                      selectorName:(NSString *)selectorName
                           objects:(NSArray *)objects;





@end

NS_ASSUME_NONNULL_END
