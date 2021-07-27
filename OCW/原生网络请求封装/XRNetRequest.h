//
//  XRNetRequest.h
//  OCW
//
//  Created by 朵朵 on 2021/7/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XRNetRequest : NSObject
/**
 系统原生
 post
 @author 王晓冉
 @date 2020/05/05
 */
+(void)postWithUrl:(NSString *)url
            header:(NSDictionary * _Nullable)headerParams
            body:(NSDictionary * _Nullable)bodyParams
            success:(void (^)(id _Nullable data,BOOL isCanUse))success
            failure:(void (^)(NSError * _Nonnull error,BOOL haveNet))failure;
/**
 系统原生
 get
 @author 王晓冉
 @date 2020/05/07
 */
+(void)getWithUrl:(NSString *)url
            header:(NSDictionary * _Nullable)headerParams
            success:(void (^)(id _Nullable data,BOOL isCanUse))success
            failure:(void (^)(NSError * _Nonnull error,BOOL haveNet))failure;

/**
 系统原生
 put
 @author 王晓冉
 @date 2020/05/19
 */
+(void)putWithUrl:(NSString *)url
            header:(NSDictionary * _Nullable)headerParams
            body:(NSDictionary * _Nullable)bodyParams
            success:(void (^)(id _Nullable data,BOOL isCanUse))success
            failure:(void (^)(NSError * _Nonnull error,BOOL haveNet))failure;
@end

NS_ASSUME_NONNULL_END
