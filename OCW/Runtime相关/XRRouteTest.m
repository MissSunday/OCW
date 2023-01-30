//
//  XRRouteTest.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/11/8.
//

#import "XRRouteTest.h"

static XRRouteTest *_test = nil;
@implementation XRRouteTest

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _test = [[XRRouteTest alloc]init];
    });
    return _test;
}
//类方法

// !!!: 无参数 有返回值
+(NSString*)abc{
    return @"ABCD";
}
+(int)ccc{
    return 3;
}
// !!!: 无参数 无返回值
+(void)ddd{
    NSLog(@"(|-.-|) %s",__func__);
}
// !!!: 有参数 有返回值
+(CGRect)eee:(NSString *)eee fff:(int)fff ggg:(CGRect)rect{
    return rect;
}
+(NSString *)str:(NSString *)aaa num:(float)bbb block:(void(^)(NSString *))block{
    NSString *a = [NSString stringWithFormat:@"%@-%f",aaa,bbb];
    block(a);
    return a;
}
// !!!: 有参数 无返回值
+(void)fff:(NSString *)fff ggg:(int)ggg hhh:(NSString *)hhh{
    NSLog(@"(|-.-|) %s",__func__);
}





//实例方法
// !!!: 无参数 有返回值
-(NSString*)abc{
    return @"abcd";
}
-(int)ccc{
    return 2;
}
// !!!: 无参数 无返回值
-(void)doSomething{
    NSLog(@"(|-.-|) %s",__func__);
}
// !!!: 有参数 有返回值
-(id)doSomethingWithNum:(double)num str:(NSString *)str cstr:(char)s{
    
    NSLog(@"(|-.-|) %f--%@--%c",num,str,s);
    
    return _test;
}

// !!!: 有参数 无返回值
-(void)doSomethingWithNum:(double)num str:(NSString *)str cstr:(char)s block:(void(^)(NSString *,double,char))block{
    
    block(str,num,s);
    
}









@end
