//
//  XRRoute.h
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/11/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 instanceObject  默认为调用方法对象自身，无关紧要。为解决特别的需求，需要二次获取对象，为省事做了返回值多一个包装对象。
 returnValue     实际方法的返回结果，就是调用的方法实际的返回参数。
               1.iOS所有object和block对象均作为id返回，可隐式直接用实际对象接收转换。
               2.所有基本数据或ios定义基本数据，如bool，int，float，CGFloat，NSInteger，char等用NSNNumber返回对应id处理，直接用NSNNumber转换即可（NSNumber其实是NSValue的拓展）
               3.所有结构体类如CGSize，CGRect，UIEdgeInsets，CGPonit等特殊或者自己封装的结构体等用NSValue返回id处理，用NSValue接收，在用NSValue的getValue方法获取实际返回对象
  
 */
typedef struct ReturnStruct{
    id        instanceObject;
    id        returnValue;
}ReturnStruct;
@interface XRRoute : NSObject

+ (instancetype)router;

- (Class)routerClassName:(NSString*)className;
//输出属性
+(void)logPropertyOfClass:(Class)cls;
//输出实例方法名
+(void)logMethodNamesOfClass:(Class)cls;
@end


@interface NSObject (XRRouteClass)

/**
 实例子对象 给属性 赋值
 @param propertyParameter 属性字典组合。  key为属性的字符串。 value为属性需要赋予的值
 @return 返回
 */
- (ReturnStruct)setPropertyParameter:(NSDictionary*)propertyParameter;


/**
 执行实例子方法

 @param selectorName 方法名
 @param methodParaments 方法参数
 @return 返回值
 */
- (ReturnStruct)performSelectorInstanceMethod:(NSString*)selectorName parameter:(void *_Nullable)methodParaments, ... NS_REQUIRES_NIL_TERMINATION;

/**
 执行类方法

 @param selectorName 方法名
 @param methodParaments 方法参数
 @return 返回值
 */
+ (ReturnStruct)performSelectorClassMethod:(NSString*)selectorName parameter:(void *_Nullable)methodParaments, ... NS_REQUIRES_NIL_TERMINATION;
@end

NS_ASSUME_NONNULL_END
