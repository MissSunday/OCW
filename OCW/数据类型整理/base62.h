//
//  base62.h
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/4/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface Base62Decoder : NSObject

+(instancetype)decoder;

//解密 - 通用
-(NSData *)decodeWithData:(NSData *)data;

//给sam用的 逻辑增加key%255 异或操作
-(NSString *)decodeWithString:(NSString *)encodeStr key:(long)key;

@end
@interface base62 : NSObject

@end

NS_ASSUME_NONNULL_END
