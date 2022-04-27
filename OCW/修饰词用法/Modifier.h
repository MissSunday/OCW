//
//  Modifier.h
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/4/12.
//

#import <Foundation/Foundation.h>

// iOS9的几个新关键字（nonnull、nullable、null_resettable、__null_unspecified）


// !!!: 在 NS_ASSUME_NONNULL_BEGIN 和 NS_ASSUME_NONNULL_END 中间定义的所有属性和方法默认都是nonnull

NS_ASSUME_NONNULL_BEGIN

@interface Modifier : NSObject

/*
 
 现在有这3种不同的可空性注释：
 nonnull，nullable，null_unspecified
 _Nonnull，_Nullable，_Null_unspecified
 __nonnull，__nullable，__null_unspecified

 在Xcode 6.3中发布，关键字为__nullable和__nonnull。
 由于可能与第三方库发生冲突，
 我们在 Xcode 7 中将它们更改为 _Nullable 和 _Nonnull。
 
*/

//以下声明是等价的，并且是正确的：

- (nullable NSNumber *)result;
- (NSNumber * __nullable)result;
- (NSNumber * _Nullable)result;

//对于参数：
- (void)doSomethingWithString:(nullable NSString *)str;
- (void)doSomethingWithString:(NSString * _Nullable)str;
- (void)doSomethingWithString:(NSString * __nullable)str;

//对于属性：
@property(nullable) NSNumber *status1;
@property NSNumber *__nullable status2;
@property NSNumber * _Nullable status3;

//当涉及返回与空无关的双指针或block时，不允许非下划线指针或块：
- (void)compute:(NSError *  _Nullable * _Nullable)error;
- (void)compute:(NSError *  __nullable * _Null_unspecified)error;

// 下面写法 代表可以传入空的block函数
- (void)executeWithCompletion:(nullable void (^)())handler;
- (void)executeWithCompletion:(void (^ _Nullable)())handler;
- (void)executeWithCompletion:(void (^ __nullable)())handler;


//如果block具有返回值，那么将被迫进入下划线版本之一：
- (void)convertObject:(nullable id __nonnull (^)())handler;
- (void)convertObject:(id __nonnull (^ _Nullable)())handler;
- (void)convertObject:(id _Nonnull (^ __nullable)())handler;
// the method accepts a nullable block that returns a nonnull value
// there are some more combinations here, you get the idea

// !!!: 结论：任何地方都可以使用下划线版本




-(void)propertyCopyOrStrongTest;
-(void)objectCopyOrMutableCopyTest;
-(void)containerTest;

+(BOOL)token:(NSString *)token;

FOUNDATION_EXTERN NSString *getName(NSString *x,NSString *m);

//对外可见的静态常量

UIKIT_EXTERN  NSInteger const ArrayIndex;

UIKIT_EXTERN  CGFloat const numOfPeople;

FOUNDATION_EXTERN  NSString *const kNotificationSomeName;
/*
 
 这两个的作用基本一致 声明外部全局变量 不同的是两者的定义位置不同 FOUNDATION_EXTERN貌似是为了兼容C++定义的
 
 FOUNDATION_EXTERN 是在Foundation框架里面 NSObjCRuntime.h 中定义的。
 NSString是在Foundation框架里面 NSString.h 中定义的。
 所以用FOUNDATION_EXTERN 修饰 NSString。

 UIKIT_EXTERN是在UIKit框架里面UIKitDefines.h中定义的。
 CGFloat在CoreGraphics框架里面CGBase.h中定义的。
 用UIKIT_EXTERN修饰CGFloat。

 NSInteger是在usr/include框架里面NSObjCRuntime.h中定义的。
 用UIKIT_EXTERN修饰NSInteger。
 
 但是大部分开发者基本上全用UIKIT_EXTERN，如果两个库都引入的情况下，我觉得对于OC来说，用哪个都无所谓
*/
@end

NS_ASSUME_NONNULL_END
