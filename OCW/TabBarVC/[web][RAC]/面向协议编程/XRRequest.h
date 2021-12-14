//
//  XRRequest.h
//  OCW
//
//  Created by 王晓冉 on 2021/12/13.
//

#import <Foundation/Foundation.h>
#import "XRRequestProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface XRRequest : NSObject<XRRequestProtocol>

+ (instancetype)shareManager;

@end

NS_ASSUME_NONNULL_END
