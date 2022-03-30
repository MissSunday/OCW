//
//  Person.h
//  OCW
//
//  Created by 朵朵 on 2021/5/25.
//


/*
 // !!!: 链式编程
 将多个操作通过点号链接在一起成为一句代码 是代码可读性好 实例对象 .a(1).b(2)
 特点: 方法的返回值是block，block必须有返回值(调用者本身对象),block参数( 需要操作的值)
 代表作: masonry框架
 
 // !!!: 响应式编程RP
 不需要考虑调用顺序，只需要考虑结果，
 在网上流传一个非常经典的解释｀响应式编程的概念｀
 在程序开发中：
 a ＝ b ＋ c
 赋值之后 b 或者 c 的值变化后，a 的值不会跟着变化
 响应式编程，目标就是，如果 b 或者 c 的数值发生变化，a 的数值会同时发生变化；
 代表: KVO
 
 // !!!: 函数式编程FP
 是把操作尽量写成一系列的嵌套函数或者方法调用
 函数式编程本质: 就是往方法中传入block ， 方法中嵌套block调用
 
 如果想再去调用别的方法，那么就需要返回一个对象；
 如果想用()去执行，那么需要返回一个block；
 如果想让返回的block再调用对象的方法，那么这个block就需要返回一个对象（即返回值为一个对象的block）。
 Reactive Cocoa就是一个函数响应式结合编程(FRP)的经典作品！
 */



#import <Foundation/Foundation.h>
@class Person;
NS_ASSUME_NONNULL_BEGIN

typedef Person *_Nullable(^blockName)(int a);

@interface Person : NSObject

@property(nonatomic,strong)NSString *title;

@property(nonatomic,assign)CGFloat money;

@property(nonatomic,strong)NSNumber *num;

-(Person *)run;

//实例方法
-(Person *)jump;

//类方法
+(void)tttt;

//发工资
-(Person *(^)(CGFloat a))fgz;

//交房租
-(Person *(^)(CGFloat a))jfz;

//吃饭
-(Person *(^)(int a))eat;

-(blockName)reduce;




@end

NS_ASSUME_NONNULL_END
