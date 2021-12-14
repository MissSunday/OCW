//
//  XRRequestParam.h
//  OCW
//
//  Created by 王晓冉 on 2021/12/13.
//

#import <Foundation/Foundation.h>
#import "XRRequestParamProtocol.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XRRequestParam : NSObject<XRRequestParamProtocol>

/** 获取请求参数 */
//+ (instancetype)getRequestParam;

+ (instancetype)postWithParam:(NSDictionary *)param url:(NSString *)url;

+ (instancetype)getWithUrl:(NSString *)url;


@end

NS_ASSUME_NONNULL_END
