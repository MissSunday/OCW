//
//  XRRequestParamProtocol.h
//  OCW
//
//  Created by 王晓冉 on 2021/12/13.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, XRRequestType) {
    Get = 1,
    Post
};

@protocol XRRequestParamProtocol <NSObject>

@required

@property(nonatomic,assign)XRRequestType requestType;

@property(nonatomic,strong)NSString *url;

@property(nonatomic,strong)NSString *baseUrl;

@optional

@property(nonatomic,strong)NSDictionary *param;

@end

NS_ASSUME_NONNULL_END
