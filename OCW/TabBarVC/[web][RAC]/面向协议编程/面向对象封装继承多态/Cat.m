//
//  Cat.m
//  OCW
//
//  Created by 朵朵 on 2021/12/21.
//

#import "Cat.h"

@interface Cat ()

@end

@implementation Cat

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"猫";
        
    }
    return self;
}

- (void)run{
    
    NSLog(@"%@ 重写父类方法 未调用super方法 %s",[self name],__func__);
}

@end
