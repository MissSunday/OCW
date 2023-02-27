//
//  XRRunTime.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2023/2/23.
//

#import "XRRunTime.h"
#import <objc/message.h>
@implementation XRRunTime







+(void)logMethodWithClass:(Class)cls{
    
    unsigned int count;
    ///获取方法列表
    Method *methodList = class_copyMethodList(cls, &count);
    for(unsigned int i = 0; i < count; i++){
        Method method = methodList[i];
        SEL _Nonnull aSelector = method_getName(method);
        NSString *methodName = NSStringFromSelector(aSelector);
        NSLog(@"方法名称：%@",methodName);
    }
    free(methodList);
    
}




@end
