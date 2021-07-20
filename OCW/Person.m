//
//  Person.m
//  OCW
//
//  Created by 朵朵 on 2021/5/25.
//

#import "Person.h"

@interface Person ()



@end


@implementation Person
- (instancetype)init
{
    self = [super init];
    if (self) {
        _num = 0;
    }
    return self;
}
- (void)run{
    NSLog(@"起飞");
}
- (Person * _Nonnull (^)(int))add{
    return ^(int a){
        self->_num += a;
        return self;
    };
}
- (blockName)reduce{
    return ^(int a){

        return [NSObject new];
    };
}
- (Person * _Nonnull (^)(int, int))chi{
    
    return ^(int a,int b){
        
        self->_num = a+b;
        return self;
    };
    
}
@end
