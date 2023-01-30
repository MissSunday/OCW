//
//  XRRoute.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/11/8.
//

#import "XRRoute.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
@implementation XRRoute
/// 路由单利
+ (instancetype)router{
    static XRRoute *router;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        router = [[XRRoute alloc] init];
    });
    return router;
}
- (Class)routerClassName:(NSString*)className{
    
    Class  class = nil;
    if (className!=nil) {
        class = NSClassFromString(className);
        if (class == nil) {
            NSLog(@"本项目未检测到类名为%@的类",className);
        }
    }
    return class;
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
//输出实例方法名
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
@end
@implementation NSObject (XRRouteClass)
/// kvo设置属性或者变量的值
/// @param propertyParameter 属性参数key-value
- (ReturnStruct)setPropertyParameter:(NSDictionary*)propertyParameter{
    
    for (int indexkey = 0; indexkey<propertyParameter.allKeys.count; indexkey++) {
        NSString *key = propertyParameter.allKeys[indexkey];
        if (![key isKindOfClass:[NSString class]]) {
            NSLog(@"%@属性异常,key:%@为非NSString类型",self,key);
            continue;
        }
        [self setValue:[propertyParameter valueForKey:key] forKey:key];
    }
    
    ReturnStruct  returnInfoStrut;
    returnInfoStrut.instanceObject = self;
    returnInfoStrut.returnValue = nil;
    return returnInfoStrut;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}
/// 路由实例方法转发
/// @param selectorName 方法名
/// @param methodParaments 参数
- (ReturnStruct)performSelectorInstanceMethod:(NSString *)selectorName parameter:(void *)methodParaments, ...
{
    
    NSMutableArray *Parameters = [NSMutableArray array];
    va_list argumentList;
    void   *eachParameter;
    if (methodParaments)
    {
        void *address = &methodParaments;
        [Parameters addObject:[NSValue  value:address withObjCType:@encode(void*)]];
        va_start(argumentList, methodParaments);
        while((eachParameter = va_arg(argumentList, void*)))
        {
            [Parameters addObject: [NSValue  value:&eachParameter withObjCType:@encode(void*)]];
        }
        va_end(argumentList);
    }

    return [self transferRouterObject:self  methodSelect:selectorName parameter:Parameters];
    
    
}

/// 路由类方法转发
/// @param selectorName 方法名
/// @param methodParaments 参数
+ (ReturnStruct)performSelectorClassMethod:(NSString *)selectorName parameter:(void *)methodParaments, ...
{
    NSMutableArray *Parameters = [NSMutableArray array];
    va_list argumentList;
    void   *eachParameter;
    if (methodParaments)
    {
        void *address = &methodParaments;
        [Parameters addObject:[NSValue  value:address withObjCType:@encode(void*)]];
        va_start(argumentList, methodParaments);
        while((eachParameter = va_arg(argumentList, void*)))
        {
            [Parameters addObject: [NSValue  value:&eachParameter withObjCType:@encode(void*)]];
        }
        va_end(argumentList);
    }

    
  return   [self transferRouterObject:NSStringFromClass([self class]) methodSelect:selectorName parameter:Parameters];
    
}



/// 核心方法 路由核心实现  对类方法 实例方法进行兼容 并做消息转发。
/// @param object 类或者实例对象
/// @param selectString f方法名
/// @param Parameters 指针参数
- (ReturnStruct)transferRouterObject:(id)object  methodSelect:(NSString*)selectString parameter:(NSArray*)Parameters
{
    NSString  *className = nil;
    if ([object isKindOfClass:[NSString class]]) {
        className = [NSString stringWithFormat:@"%@",object];
        Class  class = NSClassFromString(className);
        if (class==nil) {
            NSLog(@"类%@使用路由组件JDCN_Router的方法,然而检测到项目中类%@不存在",className,className);
            ReturnStruct  returnInfoStrut;
            returnInfoStrut.instanceObject = nil;
            returnInfoStrut.returnValue = nil;
            return returnInfoStrut;
        }
        //默认obj的 描述方法  下面重新赋值
        NSString  *methodpString = nil;
        if (selectString!=nil) {
            methodpString = selectString;
        }else{
            NSLog(@"类%@调用classMethodSelect:parameter:方法,入参方法名为空，请检查",className);
            ReturnStruct  returnInfoStrut;
            returnInfoStrut.instanceObject = nil;
            returnInfoStrut.returnValue = nil;
            return returnInfoStrut;
        }
        SEL methodSelect = NSSelectorFromString(methodpString);
        //设置指针参数释放位
        __block void *releaseBuffer =  nil;
        if ([class  respondsToSelector:methodSelect]) {
            NSMethodSignature *singnature = [class methodSignatureForSelector:methodSelect];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:singnature];
            invocation.target = class;
            invocation.selector = methodSelect;
            [Parameters enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSUInteger bufferSize = 0;
                NSGetSizeAndAlignment([obj objCType], &bufferSize, NULL);
                void *buffer = malloc(bufferSize);
                releaseBuffer = buffer;
                [obj getValue:&buffer];
                [invocation setArgument:buffer atIndex:(2+idx)];
                free(releaseBuffer);
                releaseBuffer = NULL;
            }];
            [invocation retainArguments];
            [invocation invoke];
            
          
            return [self  getreturnResultDependSingnature:singnature dependInvocation:invocation  withInstance:nil];
        }else{
            
            NSLog(@"类%@调用%@方法，然而改类并没有本方法，请检查",className,methodpString);
            ReturnStruct  returnInfoStrut;
            returnInfoStrut.instanceObject = nil;
            returnInfoStrut.returnValue = nil;
            return returnInfoStrut;
        }
        
    }else{
        
        className = NSStringFromClass([object class]);
        Class  class = NSClassFromString(className);
        if (class==nil) {
            NSLog(@"类%@调用路由组件JDCN_Router的方法,然而检测到项目中类%@不存在",className,className);
            ReturnStruct  returnInfoStrut;
            returnInfoStrut.instanceObject = nil;
            returnInfoStrut.returnValue = nil;
            return returnInfoStrut;
        }
        //实例方法
        id  instanceCtrl = object;
        NSString  *methodpString = nil;
        if (selectString!=nil) {
            methodpString = selectString;
        }else{
            NSLog(@"类%@调用instanceMethodSelect:parameter:方法,入参方法名为空，请检查",className);
            ReturnStruct  returnInfoStrut;
            returnInfoStrut.instanceObject = nil;
            returnInfoStrut.returnValue = nil;
            return returnInfoStrut;
        }
        SEL methodSelect = NSSelectorFromString(methodpString);
        //设置指针参数释放位
        __block void *releaseBuffer=nil;
        if ([instanceCtrl respondsToSelector:methodSelect]) {
            NSMethodSignature *singnature = [instanceCtrl  methodSignatureForSelector:methodSelect];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:singnature];
            invocation.target = instanceCtrl;
            invocation.selector = methodSelect;
            [Parameters enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSUInteger bufferSize = 0;
                NSGetSizeAndAlignment([obj objCType], &bufferSize, NULL);
                void *buffer = malloc(bufferSize);
                releaseBuffer = buffer;
                [obj getValue:&buffer];
                [invocation setArgument:buffer atIndex:(2+idx)];
                free(releaseBuffer);
                releaseBuffer = NULL;
            }];
            
            [invocation retainArguments];
            [invocation invoke];
            return [self  getreturnResultDependSingnature:singnature dependInvocation:invocation withInstance:instanceCtrl];
            
        }else{
            NSLog(@"类%@对象调用%@方法，然而改类并没有本方法，请检查",className,methodpString);
            ReturnStruct  returnInfoStrut;
            returnInfoStrut.instanceObject = nil;
            returnInfoStrut.returnValue = nil;
            return returnInfoStrut;
        }
    }
}

/// 函数路由调用函数的返回值！本路由列出如下的指定的类型返回值 常见的都涵盖了。f不常见的直接返回，外部接收可强制类型接受。也可在本方法下面类型作补充拓展
/// @param singnature 方法签名
/// @param invocation 方法
/// @param instanceObj 方法tag-self
- (ReturnStruct)getreturnResultDependSingnature:(NSMethodSignature*)singnature dependInvocation:(NSInvocation*)invocation withInstance:(NSObject*)instanceObj{
    ReturnStruct  returnInfoStrut;
    returnInfoStrut.instanceObject = instanceObj;
    const char* retType = [singnature methodReturnType];
    if (strcmp(retType, @encode(void)) == 0){
        returnInfoStrut.returnValue = nil;
    }else if (strcmp(retType, @encode(id)) == 0
              ||strcmp(retType, @encode(void(^)(void))) == 0){
        id __autoreleasing resultback = nil;
        [invocation getReturnValue:&resultback];
        returnInfoStrut.returnValue = resultback;
    }else if (strcmp(retType, @encode(BOOL)) == 0){
        BOOL resultback = 0;
        [invocation getReturnValue:&resultback];
        returnInfoStrut.returnValue = [NSNumber numberWithBool:resultback];
    }else if (strcmp(retType, @encode(NSInteger)) == 0){
        NSInteger resultback = 0;
        [invocation getReturnValue:&resultback];
        returnInfoStrut.returnValue = [NSNumber numberWithInteger:resultback];
    }else if (strcmp(retType, @encode(NSUInteger)) == 0){
        NSUInteger resultback = 0;
        [invocation getReturnValue:&resultback];
        returnInfoStrut.returnValue = [NSNumber numberWithUnsignedInteger:resultback];
    }else if (strcmp(retType, @encode(int)) == 0){
        int resultback = 0;
        [invocation getReturnValue:&resultback];
        returnInfoStrut.returnValue = [NSNumber numberWithInt:resultback];
    }else if (strcmp(retType, @encode(CGFloat)) == 0){
        CGFloat resultback = 0.0;
        [invocation getReturnValue:&resultback];
        returnInfoStrut.returnValue = [NSNumber numberWithFloat:resultback];
    }else if (strcmp(retType, @encode(double)) == 0
              ||strcmp(retType, @encode(float)) == 0
              ||strcmp(retType, @encode(long)) == 0
              ||strcmp(retType, @encode(long long)) == 0
              ||strcmp(retType, @encode(unsigned int)) == 0
              ||strcmp(retType, @encode(unsigned long)) == 0
              ||strcmp(retType, @encode(unsigned short)) == 0
              ||(strcmp(retType, @encode(char)) == 0)
              ){
        //返回值长度
        NSUInteger length = [singnature methodReturnLength];
        //根据长度申请内存
        void *buffer = (void *)malloc(length);
        //为变量赋值
        [invocation getReturnValue:buffer];
        NSValue  *resultback = [NSNumber valueWithBytes:buffer objCType:retType];
        returnInfoStrut.returnValue = resultback;
        free(buffer);
        buffer = NULL;
        
    }else if (strcmp(retType, @encode(CGPoint)) == 0
              ||strcmp(retType, @encode(CGSize)) == 0
              ||strcmp(retType, @encode(CGRect)) == 0
              ||strcmp(retType, @encode(CGVector)) == 0
              ||strcmp(retType, @encode(CGAffineTransform)) == 0
              ||strcmp(retType, @encode(UIEdgeInsets)) == 0
              ||strcmp(retType, @encode(UIOffset)) == 0){

        //返回值长度
        NSUInteger length = [singnature methodReturnLength];
        //根据长度申请内存
        void *buffer = (void *)malloc(length);
        //为变量赋值
        [invocation getReturnValue:buffer];
        NSValue  *resultback = [NSValue valueWithBytes:buffer objCType:retType];
        returnInfoStrut.returnValue = resultback;
        free(buffer);
        buffer = NULL;
        
    }else{
        //返回值长度
        NSUInteger length = [singnature methodReturnLength];
        //根据长度申请内存
        void *buffer = (void *)malloc(length);
        //为变量赋值
        [invocation getReturnValue:buffer];
        NSValue __autoreleasing  *resultback = [NSValue valueWithBytes:buffer objCType:retType];
        returnInfoStrut.returnValue = resultback ;
        free(buffer);
        buffer = NULL;
    }
    return returnInfoStrut;
}
@end
