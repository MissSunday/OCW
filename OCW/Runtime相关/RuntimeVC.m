//
//  RuntimeVC.m
//  OCW
//
//  Created by 朵朵 on 2021/7/14.
//

#import "RuntimeVC.h"
#import <objc/runtime.h>
@interface RuntimeVC ()

@end

@implementation RuntimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSObject *person = [[NSClassFromString(@"Person") alloc]init];
    Ivar num = class_getInstanceVariable([person class], "_num");
    object_setIvar(person, num, @100);
    
    [XRTool logPropertyOfClass:[UIButton class]];
}



@end
