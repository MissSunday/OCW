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
        _money = 0;
    }
    return self;
}
- (Person *)run{
    NSLog(@"起飞");
    return self;
}
- (Person *)jump{
    NSLog(@"跳");
    return self;
}
- (blockName)reduce{
    return ^(int a){
        self->_money -= abs(a);
        return self;
    };
}

- (Person * _Nonnull (^)(CGFloat))fgz{
    return ^(CGFloat a){
        self->_money +=a;
        return self;
    };
}
- (Person * _Nonnull (^)(CGFloat))jfz{
    return ^(CGFloat a){
        self->_money -= fabs(a);
        return self;
    };
}
- (Person * (^)(int))eat{
    return ^(int a){
        self->_money -= abs(a);
        return self;
    };
}
@end
