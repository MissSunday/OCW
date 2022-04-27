//
//  DataTypeVC.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/3/30.
//

#import "DataTypeVC.h"
#import "XRDeviceInfo.h"
#import "Modifier.h"
#import "base62.h"
@interface DataTypeVC ()

@property(nonatomic,strong)UIImageView *imageV;

@end


@implementation DataTypeVC
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    NSString *m = [UIDevice currentDevice].model;
    NSLog(@"---- %d",IS_IPHONEX);
    Modifier *model = [[Modifier alloc]init];
    [model objectCopyOrMutableCopyTest];
    [model containerTest];
   
    for (int i = 0; i < 10; i++) {
        
        
        
        static NSString *a = @"1xOBZk6w2UChi3muwwfkBwMYOSNiXHJyiswm7OPR5YdeGtDfEhzdoZc3m2UjzqNyQlUiKB0qpXsDbz5VRple2aFkcPUAcG9gcM7581f6QykSWbG6UF1vEmIBpQTbeS8pxvNRaIsiG42pLWJ";
        
        NSString *b = [[Base62Decoder decoder]decodeWithString:a key:1650245101441];
        
        NSLog(@"- %@",b);
        
    }
    
    BOOL abc = [Modifier token:nil];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSStringFromClass(self.class);
    [self.view addSubview:self.imageV];
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(self.imageV.mas_width).multipliedBy(0.8);
    }];
    
    
    [self dataType];
    
    [self enumFunc];
    
    //NSDictionary *dic = [[XRDeviceInfo shareInstance]getAllDeviceInfo];
    
    [[XRDeviceInfo shareInstance]registAppKey:@"" configBlock:nil];
    [[XRDeviceInfo shareInstance]asyncGetAllDeviceInfo:^(NSDictionary * _Nullable dic) {
        NSLog(@"手机信息 - \n%@",dic);
    }];
    
    //NSLog(@"手机信息 - \n%@",dic);
    
    char abc = 0;
    
    char c = 'rqweqwe';

    char d[10] = "qweqweq";
    //u_char *b
    
    Byte e[10] = {'a','f'};
    
    
    YYDispatchQueuePool *pool = [[YYDispatchQueuePool alloc]initWithName:@"xrQueuePool" queueCount:4 qos:NSQualityOfServiceDefault];
    //YYDispatchQueueGetForQOS(NSQualityOfServiceUtility);
    
    dispatch_semaphore_t semap = dispatch_semaphore_create(1);
    for (int i = 0; i < 3; i++) {
        dispatch_queue_t bfq = dispatch_queue_create("bfq", DISPATCH_QUEUE_CONCURRENT);
        dispatch_async(bfq, ^{
            
            for (int i = 0; i < 3; i++) {
                dispatch_async([pool queue], ^{
                    dispatch_semaphore_wait(semap, DISPATCH_TIME_FOREVER);
                    NSLog(@"- %@",[NSThread currentThread]);
                    [NSThread sleepForTimeInterval:1];
                    dispatch_semaphore_signal(semap);
                    NSLog(@"6666");
                });
            }
        });
    }
    
    
    
   
  
    
    
    
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
    
    dispatch_semaphore_t sem = dispatch_semaphore_create(1);
    
    __block NSMutableArray *ar = @[].mutableCopy;
    for (int i = 0; i < 100; i++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
            
            [ar addObject:@"tr"];
            dispatch_semaphore_signal(sem);
//            @synchronized (self) {
//                //ar = [[NSMutableArray alloc] init];
//                [ar addObject:@"tr"];
//            }
            
            
        });
    }
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
