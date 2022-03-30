//
//  DefineHeader.h
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/3/29.
//

#ifndef DefineHeader_h
#define DefineHeader_h


// “#”：字符串化操作符，作用是：将宏定义中的传入参数名转换成用一对双引号括起来参数名字符串。
// 使用条件：只能用于有传入参数的宏定义中，且必须置于宏定义体中的参数名前

#define example1(instr) #instr
/*
        string str=example1(abc);
将会展成：string str="abc";
 
注意：对空格的处理
a、忽略传入参数名前面和后面的空格。
如:           str=example1(   abc );
将会被扩展成    str="abc";
 
b、当传入参数名间存在空格时，编译器将会自动连接各个子字符串，用每个子字符串中只以一个空格连接，忽略其中多余一个的空格。
如:          str=exapme1( abc    def);
将会被扩展成   str="abc def"；
*/



// “##”: 符号连接操作符,作用：将宏定义的多个形参名连接成一个实际参数名
// 使用条件：只能用于有传入参数的宏定义中，且必须置于宏定义体中的参数名前
#define exampleNum(n) num##n
/*
int num=exampleNum(9); 将会扩展成 int num=num9;
注意：
1、当用##连接形参时，##前后的空格可有可无。
如：#define exampleNum(n) num ## n 相当于 #define exampleNum(n) num##n
2、连接后的实际参数名，必须为实际存在的参数名或是编译器已知的宏定义
*/



// @#：名称：字符化操作符 作用：将传入的单字符参数名转换成字符，以一对单引用括起来。
// 使用条件：只能用于有传入参数的宏定义中，且必须置于宏定义体中的参数名前。
#define makechar(x) @#X
/*
 a = makechar(b); 展开后变成了：a= 'b';
 */


/*
 \ : 行继续操作符 作用：当定义的宏不能用一行表达完整时，可以用”\”表示下一行继续此宏的定义。
  注意：换行不能切断单词，只能在空格的地方进行。
 */

/** 添加一个函数声明 */
#define _DEFINE_DATA_FUNC_INTERNAL(name, dataType)  \
                             -(void)set##name:(dataType)value; \
                             -(dataType)get##name; \
                             +(NSString *)key##name; \
                             -(BOOL)has##name;

/** 添加一个函数定义 */
#define _IMPLEMENT_DATA_FUNC_INTERNAL(name, dataType, funForType, strKey) \
                -(void)set##name:(dataType)value { \
                [self set##funForType:value forKey:strKey]; \
                 } \
                -(dataType)get##name { \
                  return [self get##funForType:strKey]; \
                 } \
                +(NSString *)key##name { \
                  return strKey; \
                 }\
                -(BOOL)has##name {\
                  return [self hasKey:strKey]; \
                 }

#define GTMOBJECT_SINGLETON_BOILERPLATE(_object_name_, _shared_obj_name_)                                            \
__strong static _object_name_ *z##_shared_obj_name_ = nil;   \
+ (_object_name_ *)_shared_obj_name_ {                       \
    static dispatch_once_t pred = 0;                        \
    dispatch_once(&pred, ^{                                  \
        z##_shared_obj_name_ = [[self alloc] init];          \
    });                                                      \
    return z##_shared_obj_name_;                             \
}                                                            \
+ (id)allocWithZone:(NSZone *)zone {                         \
    @synchronized(self) {                                    \
        if (z##_shared_obj_name_ == nil) {                   \
            z##_shared_obj_name_ = [super allocWithZone:zone];\
        }                                                    \
    }                                                        \
    return z##_shared_obj_name_;                             \
}                                                            \
- (id)copyWithZone:(NSZone *)zone {                          \
    return self;                                             \
}                                                            \
+ (void)destroy##_object_name_ {                             \
}



#define MIN(A,B)   ({ __typeof__(A) __a = (A); __typeof__(B) __b = (B); __a < __b ? __a : __b; })



#define NSLogRect(rect) NSLog(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define NSLogSize(size) NSLog(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
#define NSLogPoint(point) NSLog(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)










#endif /* DefineHeader_h */
