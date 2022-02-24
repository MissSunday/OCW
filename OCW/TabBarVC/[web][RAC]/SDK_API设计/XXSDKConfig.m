//
//  XXSDKConfig.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/2/24.
//

#import "XXSDKConfig.h"

@implementation XXSDKConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        _supportBingFa = YES;
        _backToMainThread = YES;
    }
    return self;
}
@end
