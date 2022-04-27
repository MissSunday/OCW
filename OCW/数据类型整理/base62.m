//
//  base62.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/4/14.
//

#import "base62.h"
static  Byte INVERTED[] = { //
        '0', '1', '2', '3', '4', '5', '6', '7', //
        '8', '9', 'a', 'b', 'c', 'd', 'e', 'f', //
        'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', //
        'o', 'p', 'q', 'r', 's', 't', 'u', 'v', //
        'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', //
        'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', //
        'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', //
        'U', 'V', 'W', 'X', 'Y', 'Z' //
};
 static Byte GMP[] = { //
        '0', '1', '2', '3', '4', '5', '6', '7', //
        '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', //
        'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', //
        'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', //
        'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', //
        'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', //
        'm', 'n', 'o', 'p', 'q', 'r', 's', 't', //
        'u', 'v', 'w', 'x', 'y', 'z' //
};

static int STANDARD_BASE = 256;
static int TARGET_BASE = 62;

@interface Base62Decoder ()
{
    Byte lookupTable['z'+ 1];
}
@end

@implementation Base62Decoder
+ (instancetype)decoder{
    return [[Base62Decoder alloc]init];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        for (int i = 0; i < 62; i++) {
            lookupTable[GMP[i]] = (Byte) i;
        }
    }
    return self;
}

- (NSString *)decodeWithString:(NSString *)encodeStr key:(long)key{
    
    if (!encodeStr) {
        return @"";
    }
    if (![encodeStr isKindOfClass:[NSString class]]) {
        return @"";
    }
    if (!key) {
        return @"";
    }
    NSData *oridata = [encodeStr dataUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [self decodeWithData:oridata];
    if (!data) {
        return @"";
    }
    Byte *oriByte = (Byte*)[data bytes];
    Byte reByte[data.length];
    for (int i = 0; i < data.length; i++) {
        
        Byte b = oriByte[i];
        
        int c = key % 255;
        
        Byte d = b ^ c;
        
        reByte[i] = d;
    }
    NSData *dat = [NSData dataWithBytes:reByte length:data.length];
    NSString *string = [[NSString alloc]initWithData:dat encoding:NSUTF8StringEncoding];
    return string ? string : @"";
}

- (NSData *)decodeWithData:(NSData *)data{
    
    if (data.length == 0) {
        return nil;
    }
    
    Byte *dataByte = (Byte *)[data bytes];

    Byte translation[data.length];

    for (int i = 0; i < data.length; i++) {
        translation[i] = lookupTable[dataByte[i]];
    }
    int estimatedLength = estimateOutputLength((int)data.length, TARGET_BASE, STANDARD_BASE);
    //下边开始用translation
    NSMutableArray *outs = [NSMutableArray arrayWithCapacity:estimatedLength];
    NSMutableArray *sourceArray = [NSMutableArray array];
    for (int i = 0; i < data.length; i++){
        Byte b = translation[i];
        NSNumber *num = [NSNumber numberWithUnsignedChar:b];
        [sourceArray addObject:num];
    }
    
    while (sourceArray.count > 0) {
        NSMutableArray *quotient = [NSMutableArray array];
        int remainder = 0;
        for (int i = 0; i < sourceArray.count; i++) {
            
            NSNumber *so = sourceArray[i];
            Byte b = so.unsignedCharValue;
            
            int accumulator = ((b & 0xFF) + remainder * TARGET_BASE);
            int digit = (accumulator - (accumulator % STANDARD_BASE)) / STANDARD_BASE;
            remainder = accumulator % STANDARD_BASE;
            if (quotient.count > 0 || digit > 0) {
                [quotient addObject:[NSNumber numberWithChar:(char)digit]];
            }
        }
        [outs addObject:[NSNumber numberWithChar:(char)remainder]];
        sourceArray = [quotient mutableCopy];
    }
    //补了个0 测试了几次没有执行 也不知道有啥用
    for (int i = 0; i< data.length - 1 && translation[i] == 0 ; i++) {
        [outs addObject:[NSNumber numberWithChar:(char)0]];
    }
    //反转
    outs = (NSMutableArray *)[[outs reverseObjectEnumerator] allObjects];
    
    Byte reByte[outs.count];
    
    for (int i = 0; i < outs.count; i++) {
        
        NSNumber *xo = outs[i];
        Byte b = xo.unsignedCharValue;
        reByte[i] = b;
    }
    
    NSData *resultData = [NSData dataWithBytes:reByte length:outs.count];
    
    return resultData;
}

static int estimateOutputLength(int inputLength, int sourceBase, int targetBase) {
    return (int) ceil((log(sourceBase) / log(targetBase)) * inputLength);
}


@end



@implementation base62






@end
