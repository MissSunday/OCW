//
//  XXSDK.h
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/2/24.
//

#import <Foundation/Foundation.h>
#import "XXSDKConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface XXSDK : NSObject

@property(nonatomic,strong)XXSDKConfig *config;

+(instancetype)sdk;


-(void)registAppKey:(NSString *)key configBlock:(void(^)(XXSDKConfig *config))configBlock;

-(void)getToken:(void(^)(id object))success;


@end

NS_ASSUME_NONNULL_END
