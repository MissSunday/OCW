//
//  XRLocationHook.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2023/2/22.
//

#import "XRLocationHook.h"
#import <dlfcn.h>
#import <objc/runtime.h>
#import <CoreLocation/CoreLocation.h>


static NSString *const xr_method_notFind = @"jdjr_method_notFind";
static NSString *const xr_libobjc_path = @"/usr/lib/libobjc.A.dylib";



@implementation XRLocationHook
+(NSString *)xr_logMethodInfo:(Class)cls sel:(NSString *)sel{
    
    Dl_info info;
    IMP imp = class_getMethodImplementation(cls,
               NSSelectorFromString(sel));
    if(dladdr(imp,&info)) {
        //NSLog(@"method %@ %@:", NSStringFromClass(cls), sel);
        //NSLog(@"dli_fname:%s",info.dli_fname);
        //NSLog(@"dli_sname:%s",info.dli_sname);
        //NSLog(@"dli_fbase:%p",info.dli_fbase);
        //NSLog(@"dli_saddr:%p",info.dli_saddr);
        NSString *ret = [NSString stringWithUTF8String:info.dli_fname];
        //NSLog(@"----%@",ret);
        return ret;
    } else {
        //NSLog(@"error: can't find that symbol.");
        return xr_method_notFind;
    }
}
//返回相关api的信息，未检测到hook则返回空数组
+ (NSString *)locationApiHookInfo{
    
    NSMutableArray *info = [[NSMutableArray alloc]init];
    NSArray * a = [self checkCLLocationDetectApis];
    [info addObjectsFromArray:a];
    NSArray * b = [self checkCLLocationManagerDetectApis];
    [info addObjectsFromArray:b];
    if (@available(iOS 15.0, *)) {
        NSArray * c = [self checkCLLocationSourceInformationDetectApis];
        [info addObjectsFromArray:c];
    }
    return [info jsonStringEncoded];
}
+(NSArray *)checkCLLocationManagerDetectApis{
    return [self checkAPI:[self CLLocationManagerDetectApis] withClass:[CLLocationManager class]];
}
+(NSArray *)checkCLLocationDetectApis{
    return [self checkAPI:[self CLLocationDetectApis] withClass:[CLLocation class]];
}
+(NSArray *)checkCLLocationSourceInformationDetectApis{
    if (@available(iOS 15.0, *)) {
         return [self checkAPI:[self CLLocationSourceInformationDetectApis] withClass:[CLLocationSourceInformation class]];
    } else {
        return @[];
    }
}
+(NSArray *)checkAPI:(NSArray *)checkApis withClass:(Class)cls{
    NSMutableArray *hookApi = [[NSMutableArray alloc]init];
    for (NSDictionary *temp in checkApis) {
        NSString *selStr = temp[@"selectorName"];
        NSString *dli_fname = [self xr_logMethodInfo:cls sel:selStr];
        NSString *name = temp[@"dli_fname"];
        if([dli_fname isEqualToString:xr_method_notFind] || [dli_fname containsString:xr_libobjc_path]){
            continue;
        }
        if(![name containsString:dli_fname]){
            NSDictionary *hookInfo = @{@"hookApiName":selStr,@"dli_fname":dli_fname};
            [hookApi addObject:hookInfo];
        }
    }
    return hookApi;
}
//检测项
+(NSArray *)CLLocationManagerDetectApis{
    return @[
        @{
            @"selectorName":@"delegate",
            @"dli_fname":@"/System/Library/Frameworks/CoreLocation.framework/CoreLocation"
        },
        @{
            @"selectorName":@"setDelegate:",
            @"dli_fname":@"/System/Library/Frameworks/CoreLocation.framework/CoreLocation"
        },
        @{
            @"selectorName":@"startUpdatingLocation",
            @"dli_fname":@"/System/Library/Frameworks/CoreLocation.framework/CoreLocation"
        },
        @{
            @"selectorName":@"stopUpdatingLocation",
            @"dli_fname":@"/System/Library/Frameworks/CoreLocation.framework/CoreLocation"
        },
        @{
            @"selectorName":@"startUpdatingHeading",
            @"dli_fname":@"/System/Library/Frameworks/CoreLocation.framework/CoreLocation"
        },
        @{
            @"selectorName":@"stopUpdatingHeading",
            @"dli_fname":@"/System/Library/Frameworks/CoreLocation.framework/CoreLocation"
        },
        @{
            @"selectorName":@"requestLocation",
            @"dli_fname":@"/System/Library/Frameworks/CoreLocation.framework/CoreLocation"
        },
        //以下4个测试路径是@"/usr/lib/libobjc.A.dylib",但是由于设置了白名单，所以加入了库的判断
        @{
            @"selectorName":@"locationManager:didUpdateLocations:",
            @"dli_fname":@"/System/Library/Frameworks/CoreLocation.framework/CoreLocation"
        },
        @{
            @"selectorName":@"locationManager:didUpdateHeading:",
            @"dli_fname":@"/System/Library/Frameworks/CoreLocation.framework/CoreLocation"
        },
        @{
            @"selectorName":@"locationManager:didFailWithError:",
            @"dli_fname":@"/System/Library/Frameworks/CoreLocation.framework/CoreLocation"
        },
        @{
            @"selectorName":@"locationManager:didChangeAuthorizationStatus:",
            @"dli_fname":@"/System/Library/Frameworks/CoreLocation.framework/CoreLocation"
        },
        
    ];
    
}
+(NSArray *)CLLocationDetectApis{
    return @[
        
        @{
            @"selectorName":@"coordinate",
            @"dli_fname":@"/System/Library/Frameworks/CoreLocation.framework/CoreLocation"
        },
        @{
            @"selectorName":@"altitude",
            @"dli_fname":@"/System/Library/Frameworks/CoreLocation.framework/CoreLocation"
        },
        @{
            @"selectorName":@"verticalAccuracy",
            @"dli_fname":@"/System/Library/Frameworks/CoreLocation.framework/CoreLocation"
        },
        @{
            @"selectorName":@"horizontalAccuracy",
            @"dli_fname":@"/System/Library/Frameworks/CoreLocation.framework/CoreLocation"
        },
        @{
            @"selectorName":@"course",
            @"dli_fname":@"/System/Library/Frameworks/CoreLocation.framework/CoreLocation"
        },
        @{
            @"selectorName":@"speed",
            @"dli_fname":@"/System/Library/Frameworks/CoreLocation.framework/CoreLocation"
        },

    ];
}
+(NSArray *)CLLocationSourceInformationDetectApis{
    return @[
        
        @{
            @"selectorName":@"isSimulatedBySoftware",
            @"dli_fname":@"/System/Library/Frameworks/CoreLocation.framework/CoreLocation"
        },
        @{
            @"selectorName":@"isProducedByAccessory",
            @"dli_fname":@"/System/Library/Frameworks/CoreLocation.framework/CoreLocation"
        },
    ];
}



@end
