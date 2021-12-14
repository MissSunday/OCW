//
//  XRRequestProtocol.h
//  OCW
//
//  Created by 王晓冉 on 2021/12/13.
//

#import <Foundation/Foundation.h>
#import "XRRequestParamProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@protocol XRRequestProtocol <NSObject>


-(void)requestWithParam:(id<XRRequestParamProtocol>)param
               complete:(void (^)(NSDictionary * response))complete
                 failed:(void (^)(NSDictionary * error))failed;


@end

NS_ASSUME_NONNULL_END
