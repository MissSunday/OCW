//
//  XRDeviceInfo.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/4/11.
//

#import "XRDeviceInfo.h"
#import "NSObject+Property.h"

#include <sys/param.h>
#include <sys/mount.h>
#import <sys/sysctl.h>

//计算内存大小
#import <mach/mach.h>
#import <mach/mach_host.h>
#import <sys/utsname.h>


@implementation XRDeviceInfoConfig
- (instancetype)init{
    self = [super init];
    if (self) {
        _supportBingFa = YES;
        _backToMainThread = YES;
        _isDebug = YES;
        _isAgreePrivacy = NO;
    }
    return self;
}
@end

@interface XRDeviceInfo ()

@property(nonatomic,strong)XRDeviceInfoConfig *config;

@property(nonatomic,strong)dispatch_queue_t deviceInfoQueue;

/*  deviceInfo  */

/*设备信息大类__设备基本参数 index=0*/
///操作系统
@property (nonatomic, strong, readwrite) NSString *os;
///操作系统版本
@property (nonatomic, strong, readwrite) NSString *osVersion;
///型号
@property (nonatomic, strong, readwrite) NSString *p_model;



@end


static XRDeviceInfo *_manager = nil;
@implementation XRDeviceInfo

#pragma mark - 初始化
+(instancetype)shareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[super allocWithZone:nil] init];
        _manager.config = [[XRDeviceInfoConfig alloc]init];
        _manager.deviceInfoQueue = dispatch_queue_create("dIQueue", DISPATCH_QUEUE_SERIAL);
        
    });
    return _manager;
}
+(id)allocWithZone:(NSZone *)zone{
    return [self shareInstance];
}
-(id)copyWithZone:(NSZone *)zone{
    return [[self class] shareInstance];
}
-(id)mutableCopyWithZone:(NSZone *)zone{
    return [[self class] shareInstance];
}
- (void)registAppKey:(NSString *)key configBlock:(void (^)(XRDeviceInfoConfig * _Nonnull))configBlock{
    if (configBlock) {
        configBlock(_manager.config);
    }
}

#pragma mark - get
//操作系统
- (NSString *)os {
    return [UIDevice currentDevice].systemName;
}

//操作系统版本
- (NSString *)osVersion {
    _osVersion = [UIDevice currentDevice].systemVersion;
    return _osVersion;
}

//型号
- (NSString *)p_model {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *model = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    _p_model = model;
    return _p_model;
}
- (void)asyncGetAllDeviceInfo:(void (^)(NSDictionary * _Nullable))block{
    dispatch_async(_deviceInfoQueue, ^{
        NSArray *allProsAry = [self getProperties:[self class]];
        NSDictionary *allDic = [self getDeviceInfoWithCollectionArray:allProsAry];
        dispatch_async(dispatch_get_main_queue(), ^{
            block(allDic);
        });
    });
}
- (NSDictionary *)getAllDeviceInfo
{
    NSArray *allProsAry = [self getProperties:[self class]];
    NSDictionary *allDic = [self getDeviceInfoWithCollectionArray:allProsAry];
    return allDic;
}
/// 通过采集字段数组采集设备信息
/// @param collectionAry 所有需要采集的字段数组
- (NSDictionary *)getDeviceInfoWithCollectionArray:(NSArray *)collectionAry
{
    if (!collectionAry || collectionAry.count == 0)
    {
        return nil;
    }
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
    for (int i=0;i<collectionAry.count;i++)
    {
        NSString *key = collectionAry[i];
        NSString *value;
        @try {
            value = [self valueForKey:key];
        } @catch (NSException *exception) {
            //                NSLog(@"JDJR_Exception_%@属性不存在",key);
        } @finally {
            
        }
        //防止属性是非字符串的加入而无法json化，如semaphoreLock
        if (value && [value isKindOfClass:[NSString class]])
        {
            [mDic setValue:value forKey:key];
        }
    }
    return mDic;
}

@end
