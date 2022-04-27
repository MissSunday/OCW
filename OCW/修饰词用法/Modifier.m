//
//  Modifier.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/4/12.
//

#import "Modifier.h"
#import "Person.h"

@interface Modifier ()
/*

关键字      ARC或MRC    修饰对象说明
atomic       both    原子，线程安全，效率低，多线程操作时才使用
nonatomic    both    非原子，线程不安全，效率高，经常使用
retain       mrc     修饰对象 ，强引用
strong       arc     修饰对象，强引用
weak         arc     修饰代理delegate，修饰对象弱引用
assign       both    修饰基本数据类型(int,float,boolean)
copy         both    修饰字符串，block等

*/

@property(nonatomic,strong)NSArray        *array1;
@property(nonatomic,copy)NSArray          *array2;



//两种修饰的字符串
@property(nonatomic,copy)NSString         *cp_str;
@property(nonatomic,strong)NSString       *strong_str;

@end
//extern初始化
NSInteger const ArrayIndex = 100;

CGFloat const numOfPeople = 10;

NSString *const kNotificationSomeName = @"kNotificationSomeName";

/*
 static 静态，修饰变量只初始化一次，一份内存，节省内存
 可修饰 局部静态变量  全局静态变量  静态函数
*/
static int c = 10;

static int myFunc(int a,int b){
    return a+b;
}
//使用静态函数的好处是，不用担心与其他文件的同名函数产生干扰，另外也是对函数本身的一种保护机制。

/* const
const用来修饰右边的基本变量或指针变量
被修饰的变量只读，不能被修改
*/
//结合使用 静态常量
static const void * const AuthenticationChallengeErrorKey = &AuthenticationChallengeErrorKey;

const int a = 5;/*a的值一直为5，不能被改变*/

const int b; /* b = 10; b的值被赋值为10后，不能被改变*/ //等价于 int const b;

const int *ptr; /* ptr为指向整型常量的指针，ptr的值可以修改，但不能修改其所指向的值*/

int *const ptrr;/* ptrr为指向整型的常量指针，ptrr的值不能修改，但可以修改其所指向的值*/

const int *const pt = &a;/* pt为指向整型常量的常量指针，pt及其指向的值都不能修改*/

NSString *getName(NSString *x,NSString *m){
    return [NSString stringWithFormat:@"%@%@",x,m];
}

@implementation Modifier
+ (BOOL)token:(NSString *)token{
    if (token && [token isKindOfClass:[NSString class]] && [token isEqualToString:@"666"]) {
        return YES;
    }else{
        return NO;
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"- %s -",__func__); NSLog(@"-- %p",pt);
    }
    return self;
}
-(void)propertyCopyOrStrongTest{
    
    // !!!: copy修饰和strong修饰的区别
    
    // 对于修饰NSString和NSArray 结论是一样的
    // 1.如果来源是不可变的，那么copy和strong修饰没有区别，都是浅拷贝。
    NSString *ttt = @"ttt";
    self.strong_str = ttt;
    self.cp_str = ttt;
    
    NSArray *arr = @[ttt];  //0x00007b0400009500
    self.array1 = arr;      //0x00007b0400009500
    self.array2 = arr;      //0x00007b0400009500
    
    
    NSLog(@"- %p - %p - %p",self.strong_str,self.cp_str,ttt);
    
    // 2.如果来源是可变的，copy修饰的会进行深拷贝，strong修饰的是浅拷贝
    // 如果来源变化，copy修饰的不会跟随变化，strong修饰的会跟随变化
   
    NSMutableString *muts = [[NSMutableString alloc]initWithString:@"asdf"];
    self.strong_str = muts;
    self.cp_str = muts;
    
    NSLog(@"- %p - %p - %p",self.strong_str,self.cp_str,muts);
    NSLog(@"- %@ - %@ - %@",self.strong_str,self.cp_str,muts);
    
    [muts appendString:@"uip"];
    
    NSLog(@"- %p - %p - %p",self.strong_str,self.cp_str,muts);
    NSLog(@"- %@ - %@ - %@",self.strong_str,self.cp_str,muts);
    
    
    NSMutableArray *muarr = [[NSMutableArray alloc]initWithObjects:@"gtr", nil];//0x00007b0c0008f1c0
    self.array1 = muarr;//0x00007b0c0008f1c0
    self.array2 = muarr;//0x00007b04000091f0
    [muarr addObject:@"ppt"];
    
    NSLog(@"- %@ - %@",self.array1,self.array2);
}

- (void)objectCopyOrMutableCopyTest{

    // !!!: copy 和 mutableCopy 的结果
    
    //不可变字符串
    NSString *imutableString = @"这是一个不可变字符串";
    id imutableString_copy = [imutableString copy];
    id imutableString_mutableCopy = [imutableString mutableCopy];
    
    NSLog(@"- %p - %p - %p",imutableString,imutableString_copy,imutableString_mutableCopy);
    
    
    //可变字符串
    NSMutableString *mutableStr = [[NSMutableString alloc] initWithString:@"这是一个可变字符串"];
    id mutableStr_copy = [mutableStr copy];
    id mutableStr_mutableCopy = [mutableStr mutableCopy];
    
    NSLog(@"- %p - %p - %p",mutableStr,mutableStr_copy,mutableStr_mutableCopy);
    
    //结论
    //1.如果来源是不可变的，那么copy是浅拷贝，mutableCopy是深拷贝
    //2.如果来源是可变的，那么copy和mutableCopy都是深拷贝
    
    
    
 }
//容器类测试
-(void)containerTest{
    
    // 对于容器本身的测试
    
    Person *p1 = [[Person alloc]init];
    p1.title = @"p1";
    Person *p2 = [[Person alloc]init];
    p2.title = @"p2";
    
    
    
    NSArray *oriArray = @[p1,p2];//0x7b080006ed80
    
    NSArray *cpA1 = [oriArray copy];//0x7b080006ed80
    
    NSMutableArray *mcpA1 = [oriArray mutableCopy];//0x7b0c00090210
    
    
    NSMutableArray *oriMuArray = [[NSMutableArray alloc]initWithObjects:p1,p2, nil];//0x7b0c000860d0
    
    NSArray *cpA2 = [oriMuArray copy];//0x7b08000609c0
    
    NSMutableArray *mcpA2 = [oriMuArray mutableCopy];//0x7b0c00086340
    
    Person *p3 = cpA1[0];
    p3.title = @"p3";
    
    NSMutableString *muts = [[NSMutableString alloc]initWithString:@"asdf"];
    Person *p4 = mcpA2[1];
    p4.title = muts;
    
    [muts appendString:@"666"];
    
    NSLog(@"内存地址 %p %p %p %p %p %p",oriMuArray,oriArray,cpA1,cpA2,mcpA1,mcpA2);
    // 结论
    //    如果来源是不可变数组 copy是浅拷贝 mutableCopy是深拷贝
    //    如果来源是可变数组   copy和mutableCopy 都是深拷贝
    
    
    
    
    // !!!: 对于容器内容的测试
    
    // 不管数组如何copy  自定义对象类型 在容器中是浅拷贝的，自定义对象的属性变化，所有容器中存有的这个对象发生变化
    
    // 如果不想这样  那么可以重写自定义类的
    // -(id)copyWithZone:(NSZone *)zone 和 -(id)mutableCopyWithZone:(NSZone *)zone方法
    
    
    
}
@end


