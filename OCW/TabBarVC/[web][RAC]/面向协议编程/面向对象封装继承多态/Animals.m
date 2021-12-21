//
//  Animals.m
//  OCW
//
//  Created by 朵朵 on 2021/12/21.
//

#import "Animals.h"

@interface Animals ()


@property(nonatomic,copy)NSString *time;

@end

@implementation Animals
- (instancetype)init
{
    self = [super init];
    if (self) {
        _name = @"动物";
        _time = @"2022";
    }
    return self;
}
- (void)run{
    
    NSLog(@"执行超类方法 %s",__func__);
    
}
- (void)eat{
    NSLog(@"执行超类方法 %s",__func__);
}

@end
