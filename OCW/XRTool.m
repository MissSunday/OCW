//
//  XRTool.m
//  XRToolSDK
//
//  Created by 朵朵 on 2021/8/30.
//

#import "XRTool.h"

@implementation XRTool
// !!!: 判断是否是数组
+(BOOL)isArray:(NSArray *)array{
    
    if (array == nil) {
        return NO;
    }
    if ([array isKindOfClass:[NSNull class]]) {
        return NO;
    }
    if (![array isKindOfClass:[NSArray class]]){
        return NO;
    }
    return YES;
}
// !!!: 判断是否是字典
+(BOOL)isDictionary:(NSDictionary *)dic{
    
    if (dic == nil) {
        return NO;
    }
    if ([dic isKindOfClass:[NSNull class]]) {
        return NO;
    }
    if (![dic isKindOfClass:[NSDictionary class]]){
        return NO;
    }
    return YES;
}
// !!!: 判断是否是字符串
+(BOOL)isString:(NSString *)string{
    
    if (string == nil) {
        return NO;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return NO;
    }
    if (![string isKindOfClass:[NSString class]]){
        return NO;
    }
    if ([string isEqualToString:@"null"]) {
        return NO;
    }
    if ([string isEqualToString:@"<null>"]) {
        return NO;
    }
    return YES;
}
+(void)logPropertyOfClass:(Class)cls{
    
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList(cls, &count);
    
    for (int i = 0; i < count; i++) {
        const char *property = property_getName(properties[i]);
        NSString *propertyString = [NSString stringWithCString:property encoding:[NSString defaultCStringEncoding]];
        NSLog(@"- %@",propertyString);
    }
    
    free(properties);
}
+ (void)logMethodNamesOfClass:(Class)cls{
    
    unsigned int count;
    // 获得方法数组
    Method *methodList = class_copyMethodList(cls, &count);
    // 遍历所有的方法
    for (int i = 0; i < count; i++) {
        // 获得方法
        Method method = methodList[i];
        // 获得方法名
        NSString *methodName = NSStringFromSelector(method_getName(method));
        NSLog(@" %@ %s", methodName,method_getTypeEncoding(method));
    }
    // 释放
    free(methodList);
}
@end
