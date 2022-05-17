//
//  XRTool.m
//  XRToolSDK
//
//  Created by 朵朵 on 2021/8/30.
//

#import "XRTool.h"

@interface XRTool ()

@property(nonatomic,readwrite,assign)BOOL isIPad;
@property(nonatomic,readwrite,assign)BOOL isIPhoneX;
@end

static XRTool *_tool = nil;

@implementation XRTool

+(instancetype)tool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tool = [[super allocWithZone:nil] init];
        _tool.isIPad = [self isIPAD];
        _tool.isIPhoneX = [self isIPHONEX:_tool.isIPad];
    });
    return _tool;
}
+(id)allocWithZone:(NSZone *)zone{
    return [self tool];
}
-(id)copyWithZone:(NSZone *)zone{
    return [[self class] tool];
}
-(id)mutableCopyWithZone:(NSZone *)zone{
    return [[self class] tool];
}
+(BOOL)isIPHONEX:(BOOL)isIPad{
    if (isIPad) {
        return NO;
    }else{
        if (kStatuBarHeight > 20) {
            return YES;
        }
    }
    return NO;
}
+(BOOL)isIPAD{
    
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if([deviceType isEqualToString:@"iPhone"]) {
        //iPhone
        return NO;
    }
    else if([deviceType isEqualToString:@"iPod touch"]) {
        //iPod Touch
        return NO;
    }
    else if([deviceType isEqualToString:@"iPad"]) {
        //iPad
        return YES;
    }
    return NO;
}

#pragma mark -
// !!!: 判断是否是数组
BOOL isArray(id array){
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
BOOL isDictionary(id dic){
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
BOOL isString(id string){
    
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
    
    NSLog(@"%@ Property count %d",cls,count);
    
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
    
    NSLog(@"%@ Method count %d",cls,count);
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

+ (id)performSelectorWithClassName:(NSString *)className selectorName:(NSString *)selectorName objects:(NSArray *)objects{
    
    
    Class cls = NSClassFromString(className);
    SEL sel = NSSelectorFromString(selectorName);
    if (!cls || ![cls respondsToSelector:sel]) {
        return nil;
    }
    
    // 方法签名(方法的描述)
    NSMethodSignature *signature = [cls methodSignatureForSelector:sel];
   if (signature == nil) { //可以抛出异常也可以不操作。
       NSLog(@"没找到方法");
       return nil;
   }
    // NSInvocation : 利用一个NSInvocation对象包装一次方法调用（方法调用者、方法名、方法参数、方法返回值）
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    invocation.target = cls;
    invocation.selector = sel; // 设置参数
    NSInteger paramsCount = signature.numberOfArguments - 2; // 除self、_cmd以外的参数个数
    paramsCount = MIN(paramsCount, objects.count);
   for (NSInteger i = 0; i < paramsCount; i++) {
        id object = objects[i];
        if ([object isKindOfClass:[NSNull class]]) continue;
        [invocation setArgument:&object atIndex:i + 2];
    } // 调用方法
    [invocation invoke]; // 获取返回值
    id returnValue = nil;
    if (signature.methodReturnLength) { // 有返回值类型，才去获得返回值
        [invocation getReturnValue:&returnValue];
    } return returnValue;
}

@end
