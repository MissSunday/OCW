//
//  XRTool.m
//  XRToolSDK
//
//  Created by 朵朵 on 2021/8/30.
//

#import "XRTool.h"

#import "XRPCH.h"

@interface XRTool ()

@property(nonatomic,readwrite,assign)BOOL isIPad;
@property(nonatomic,readwrite,assign)BOOL isIPhoneX;
@end

static XRTool *_tool = nil;

@implementation XRTool

+(instancetype)tool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tool = [[super allocWithZone:nil] init];
        _tool.isIPad = [self isIPAD];
        _tool.isIPhoneX = [self isIPHONEX:_tool.isIPad];
    });
    return _tool;
}
+(id)allocWithZone:(NSZone *)zone{
    return [self tool];
}
-(id)copyWithZone:(NSZone *)zone{
    return [[self class] tool];
}
-(id)mutableCopyWithZone:(NSZone *)zone{
    return [[self class] tool];
}
+(BOOL)isIPHONEX:(BOOL)isIPad{
    if (isIPad) {
        return NO;
    }else{
        if (kStatuBarHeight > 20) {
            return YES;
        }
    }
    return NO;
}
+(BOOL)isIPAD{
    
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if([deviceType isEqualToString:@"iPhone"]) {
        //iPhone
        return NO;
    }
    else if([deviceType isEqualToString:@"iPod touch"]) {
        //iPod Touch
        return NO;
    }
    else if([deviceType isEqualToString:@"iPad"]) {
        //iPad
        return YES;
    }
    return NO;
}

#pragma mark -
// !!!: 判断是否是数组
BOOL isArray(id array){
    if (array == nil) {
        return NO;
    }
    if ([array isKindOfClass:[NSNull class]]) {
        return NO;
    }
    if (![array isKindOfClass:[NSArray class]]){
        return NO;
    }
    return YES; 
}
// !!!: 判断是否是字典
BOOL isDictionary(id dic){
    if (dic == nil) {
        return NO;
    }
    if ([dic isKindOfClass:[NSNull class]]) {
        return NO;
    }
    if (![dic isKindOfClass:[NSDictionary class]]){
        return NO;
    }
    return YES;
}
// !!!: 判断是否是字符串
BOOL isString(id string){
    
    if (string == nil) {
        return NO;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return NO;
    }
    if (![string isKindOfClass:[NSString class]]){
        return NO;
    }
    if ([string isEqualToString:@"null"]) {
        return NO;
    }
    if ([string isEqualToString:@"(null)"]) {
        return NO;
    }
    if ([string isEqualToString:@"（null）"]) {
        return NO;
    }
    if ([string isEqualToString:@"<null>"]) {
        return NO;
    }
    return YES;
}



@end
