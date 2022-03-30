//
//  RuntimeVC.m
//  OCW
//
//  Created by 朵朵 on 2021/7/14.
//

#import "RuntimeVC.h"
#import <objc/runtime.h>
#import "Person.h"
@interface RuntimeVC ()

@end

@implementation RuntimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = NSStringFromClass(self.class);
    
    NSObject *person = [[NSClassFromString(@"Person") alloc]init];
    
    [person addObserver:self forKeyPath:@"num" options:NSKeyValueObservingOptionNew context:nil];
    
    
    Ivar num = class_getInstanceVariable([person class], "_num");
    if (num) {
        object_setIvar(person, num, @100);
    }else{
        NSLog(@"没找到num属性");
    }
    
    
   // [XRTool logPropertyOfClass:[UIButton class]];
    

    CFRunLoopRef runloop = CFRunLoopGetCurrent();

    
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    NSLog(@"123");
    
}


@end
