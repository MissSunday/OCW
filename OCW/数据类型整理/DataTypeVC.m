//
//  DataTypeVC.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/3/30.
//

#import "DataTypeVC.h"

@interface DataTypeVC ()

@property(nonatomic,strong)UIImageView *imageV;

@end

static const void * const AuthenticationChallengeErrorKey = &AuthenticationChallengeErrorKey;

const int a = 5;/*a的值一直为5，不能被改变*/

const int b; /* b = 10; b的值被赋值为10后，不能被改变*/

const int *ptr; /* ptr为指向整型常量的指针，ptr的值可以修改，但不能修改其所指向的值*/

int *const ptrr;/* ptrr为指向整型的常量指针，ptrr的值不能修改，但可以修改其所指向的值*/

const int *const pt = &a;/* pt为指向整型常量的常量指针，pt及其指向的值都不能修改*/

@implementation DataTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSStringFromClass(self.class);
    [self.view addSubview:self.imageV];
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(self.imageV.mas_width).multipliedBy(0.8);
    }];
    NSLog(@"- %s -",__func__); NSLog(@"-- %p",pt);
    
    [self dataType];
    
    [self enumFunc];
    
    
    
    char abc = 0;
    
    char c = 'rqweqwe';

    char d[10] = "qweqweq";
    //u_char *b 
}
// !!!: 数据类型
-(void)dataType{
        
    // !!!: C语言基本数据类型
    printf("char  存储最大字节数 : %lu \n", sizeof(char));
    printf("short 存储最大字节数 : %lu \n", sizeof(short));
    printf("int   存储最大字节数 : %lu \n", sizeof(int));
    printf("float 存储最大字节数 : %lu \n", sizeof(float));
    printf("long  存储最大字节数 : %lu \n", sizeof(long));
    printf("double 存储最大字节数 : %lu \n", sizeof(double));
    printf("longlong   存储最大字节数 : %lu \n", sizeof(long long));
    printf("longdouble   存储最大字节数 : %lu \n\n", sizeof(long double));
    //unsigned 无符号修饰 取值范围和signed不一样
    
    
    printf("id     存储最大字节数 : %lu \n", sizeof(id));
    printf("void   存储最大字节数 : %lu \n", sizeof(void));
    printf("void*  存储最大字节数 : %lu \n", sizeof(void*));
    printf("char*  存储最大字节数 : %lu \n", sizeof(char*));
    printf("nil    存储最大字节数 : %lu \n", sizeof(nil));
    printf("SEL    存储最大字节数 : %lu \n", sizeof(SEL));
    printf("IMP    存储最大字节数 : %lu \n", sizeof(IMP));
    printf("bool   存储最大字节数 : %lu \n", sizeof(bool));
    printf("BOOL   存储最大字节数 : %lu \n\n", sizeof(BOOL));
    

    printf("Class  存储最大字节数 : %lu \n", sizeof(Class));
    printf("Ivar   存储最大字节数 : %lu \n", sizeof(Ivar));
    printf("Method 存储最大字节数 : %lu \n", sizeof(Method));
    printf("block  存储最大字节数 : %lu \n", sizeof(os_block_t));
    printf("*func  存储最大字节数 : %lu \n\n", sizeof(os_function_t));
    
    // oc里的类型别名 只简单举例
    printf("NSInteger 存储最大字节数 : %lu \n", sizeof(NSInteger));
    printf("CGFloat   存储最大字节数 : %lu \n", sizeof(CGFloat));
    printf("NSUInteger 存储最大字节数 : %lu \n", sizeof(NSUInteger));
    
    
    // !!!: OC中基本数据类型、对象类型、id类型
    NSString *str = @"";
    NSNumber *num = @100;
    NSValue *value = nil;
    
    
    CGPoint point = CGPointMake(1, 1);
    
    value = [NSValue valueWithCGPoint:point];
    
    NSLog(@"value = %@",value);
    
    
    
    
}



// !!!: 枚举类型
-(void)enumFunc{
    
    
    self.enumType = enumTypeC;
    
    self.myOption = MyOption1 | MyOption2;
    
    if (self.myOption & MyOption2) {
        NSLog(@"包含 2 类型");
    }
    
    //增加选项
    self.myOption = _myOption | MyOption4;//0011 | 1000 = 1011, 11
    
    //self.myOption |= MyOption4;
    
    //减少选项
    self.myOption = _myOption & (~MyOption4);//1011 & (~1000) = 1011 & 0111 = 0011, 3
    
    //self.myOption &= ~MyOption4;
    
    
    
    
    
    
    
    
    
}
- (UIImageView *)imageV{
    if (!_imageV) {
        _imageV = [UIImageView new];
        _imageV.image = [UIImage imageNamed:@"32-64.jpg"];
    }
    return _imageV;
}
@end
