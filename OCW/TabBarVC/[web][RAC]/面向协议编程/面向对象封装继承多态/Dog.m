//
//  Dog.m
//  OCW
//
//  Created by 朵朵 on 2021/12/21.
//

#import "Dog.h"

@implementation Dog

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"狗";
    }
    return self;
}

- (void)run{
    [super run];
    NSLog(@"%@ 重写父类方法 先调用super方法 %s",[self class],__func__);
}
- (void)eat{
    
    NSLog(@"%@ 重写父类方法 后调用super方法 %s",self.name,__func__);
    [super run];
}
@end
