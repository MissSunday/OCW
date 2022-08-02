//
//  XXSDKConfig.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/2/24.
//

#import "XXSDKConfig.h"

@interface XXSDKConfig ()
@property(nonatomic,strong)dispatch_semaphore_t configSemaphore;
@end


static XXSDKConfig *_config = nil;
@implementation XXSDKConfig
+ (instancetype)config{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _config = [[XXSDKConfig alloc]init];
        _config.configSemaphore = dispatch_semaphore_create(1);
    });
    return _config;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _supportBingFa = YES;
        _backToMainThread = NO;
        _isDebug = YES;
        _needLog = NO;
    }
    return self;
}

@end
