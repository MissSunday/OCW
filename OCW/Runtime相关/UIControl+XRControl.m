//
//  UIControl+XRControl.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2023/3/8.
//

#import "UIControl+XRControl.h"



static const void * const XRControlIgnoreKey = &XRControlIgnoreKey;
static const void * const XRControlDelayIntervalKey = &XRControlDelayIntervalKey;

@implementation UIControl (XRControl)

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = [self class];
        SEL originalSEL = @selector(sendAction:to:forEvent:);
        SEL swizzledSEL = @selector(xr_sendAction:to:forEvent:);
        Method m1 = class_getInstanceMethod(class, originalSEL);
        Method m2 = class_getInstanceMethod(class, swizzledSEL);
        method_exchangeImplementations(m1, m2);
    });
    
}

- (void)setIgnore:(BOOL)ignore{
    objc_setAssociatedObject(self, XRControlIgnoreKey, @(ignore), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)ignore{
    return [objc_getAssociatedObject(self, XRControlIgnoreKey) boolValue];
}
- (void)setDelayInterval:(NSTimeInterval)delayInterval{
    if(delayInterval < 0){
        delayInterval = 0;
    }
    objc_setAssociatedObject(self, XRControlDelayIntervalKey, @(delayInterval), OBJC_ASSOCIATION_ASSIGN);
}
- (NSTimeInterval)delayInterval{
    return [objc_getAssociatedObject(self, XRControlDelayIntervalKey) doubleValue];
}

- (void)xr_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    
    //这个写法暂未考虑多线程并发多情况，理论上此方法只在实例中调用，不存在并发隐患
    
    //测试发现此方案效果并不咋样
    
    if (self.ignore) return;
    
    if (self.delayInterval > 0) {
        //添加了延迟，ignoreEvent就设置为YES，让上面来拦截。
        self.ignore = YES;
        // 延迟delayInterval秒后，让ignoreEvent为NO,可以继续响应
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.delayInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.ignore = NO;
        });
    }
    //调用系统方法，已替换
    [self xr_sendAction:action to:target forEvent:event];
}


@end
