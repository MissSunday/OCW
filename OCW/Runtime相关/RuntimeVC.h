//
//  RuntimeVC.h
//  OCW
//
//  Created by 朵朵 on 2021/7/14.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RuntimeVC : BaseViewController

/*
 !!!: objc相关😜
 objc_getClass               获取Class对象
 objc_allocateClassPair      动态创建一个类
 objc_registerClassPair      注册一个类
 objc_disposeClassPair       销毁一个类
 objc_setAssociatedObject    为实例对象关联对象
 objc_getAssociatedObject    获取实例对象的关联对象
 
 !!!: class相关😝
 class_getSuperclass             获取父类
 class_addIvar                   动态添加成员变量
 class_addProperty               动态添加属性方法
 class_addMethod                 动态添加方法
 class_replaceMethod             动态替换方法
 class_getInstanceVariable       获取实例变量
 class_getClassVariable          获取类变量
 class_getInstanceMethod         获取实例方法
 class_getClassMethod            获取类方法
 class_getMethodImplementation   获取父类方法实现
 class_getInstanceSize           获取实例大小
 class_copyMethodList            获取类的方法数组

 !!!: object相关😊
 object_getClassName    获取对象的类名
 object_getClass        获取对象的类
 object_getIvar         获取对象成员变量的值
 object_setIvar         设置对象成员变量的值

 !!!: method相关😎
 method_getName                 获取方法名
 method_getImplementation       获取方法的实现
 method_getTypeEncoding         获取方法的类型编码
 method_setImplementation       设置方法的实现
 method_exchangeImplementations 替换方法的实现

 !!!: property相关😍
 property_getName           获取属性名
 property_getAttributes     获取属性的特性列表
 
 !!!: ivar相关😂
 ivar_getName           获取成员变量名称
 ivar_getOffset         获取偏移量
 ivar_getTypeEncoding   获取类型编码

 !!!: protocol相关🤪
 protocol_getName               获取协议名称
 protocol_addProperty           协议添加属性
 protocol_getProperty           获取协议属性
 protocol_copyPropertyList      拷贝协议的属性列表名
 
 */


@end

NS_ASSUME_NONNULL_END
