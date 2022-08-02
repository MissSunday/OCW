//
//  XRPerson.m
//  XRSDK
//
//  Created by ext.wangxiaoran3 on 2022/7/21.
//

#import "XRPerson.h"

@implementation XRPerson


- (instancetype)init
{
    self = [super init];
    if (self) {
        _name = @"小明";
        _sex = YES;
    }
    return self;
}

@end

@interface TYPerson ()
{
    BOOL _isAgree;
}

@property(nonatomic,strong)dispatch_queue_t tyqueue;
@property(nonatomic,strong)dispatch_queue_t tyqueue2;

@end

static TYPerson *_manager = nil;
@implementation TYPerson

+ (instancetype)manager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[TYPerson alloc]init];
        _manager.tyqueue = dispatch_queue_create("tyqueue", DISPATCH_QUEUE_SERIAL);
        _manager.tyqueue2 = dispatch_queue_create("tyqueue", DISPATCH_QUEUE_SERIAL);
    });
    return _manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _name = @"小红";
        _sex = NO;
        _isAgree = NO;
    }
    return self;
}
- (void)updateName:(NSString *)neName{
    _name = neName;
}
- (void)updateSEX:(BOOL)neSEX{
    _sex = neSEX;
}
-(void)updateAgree:(BOOL)is{
    dispatch_async(self.tyqueue, ^{
        self->_isAgree = is;
    });
}
- (BOOL)isAgree{
    __block BOOL isAgree = NO;
    dispatch_sync(self.tyqueue, ^{
        isAgree = _isAgree;
    });
    return isAgree;

}

@end
