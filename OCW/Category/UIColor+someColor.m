//
//  UIColor+someColor.m
//  carEasy
//
//  Created by mac on 2019/4/18.
//  Copyright © 2019 MissSunday. All rights reserved.
//

#import "UIColor+someColor.h"

@implementation UIColor (someColor)

+ (UIColor *)mainColor{
    return [UIColor colorWithHexString:@"#8BB2FF"];
}
+ (UIColor *)vcBackgroundColor{
    return [UIColor colorWithHexString:@"#F8F8F8"];
}
+(UIColor *)color62{
    return [UIColor colorWithHexString:@"#222222"];
}
+ (UIColor *)color63{
    return [UIColor colorWithHexString:@"#333333"];
}
+ (UIColor *)color69{
     return [UIColor colorWithHexString:@"#999999"];
}
+ (UIColor *)color66{
    return [UIColor colorWithHexString:@"#666666"];
}
+ (UIColor *)color6E{
    return [UIColor colorWithHexString:@"#eeeeee"];
}
+(UIColor *)colorE6{
    return [UIColor colorWithHexString:@"#E6E6E6"];
}
+ (UIColor *)colorF5{
    return [UIColor colorWithHexString:@"#F5F5F5"];
}
+ (UIColor *)randomColor{
    return [UIColor colorWithRed:(arc4random() % 256)/255.0 green:(arc4random() % 256)/255.0 blue:(arc4random() % 256)/255.0 alpha:1];
}
@end
