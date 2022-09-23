//
//  SDK_API_VC.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/2/24.
//

#import "SDK_API_VC.h"
#import "XXSDK.h"

@interface SDK_API_VC ()
@property(nonatomic,strong)dispatch_semaphore_t semap;

@property(nonatomic,strong)NSString *str;

@end

@implementation SDK_API_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.str = @"str";
    self.semap = dispatch_semaphore_create(1);
    self.navigationItem.title = NSStringFromClass(self.class);
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //初始化 写在AppDelegate里
    [[XXSDK sdk]registAppKey:@"" configBlock:^(XXSDKConfig *config) {
        config.supportBingFa = YES;
        config.backToMainThread = NO;
        config.isDebug = YES;
        config.needLog = NO;
        NSLog(@"参数设置完毕");
    }];
//
//
//
//
    //同步  在当前队列返回
    id aaa = [[XXSDK sdk]getTokenSync];
    NSLog(@"aaa = %@",aaa);
//
    NSLog(@"1234");
//    //异步
//    [[XXSDK sdk]getTokenAsync:^(id  _Nonnull object) {
//
//        NSLog(@"getTokenReturn - %@ %@",object,[NSThread currentThread]);
//    }];
//    NSLog(@"5678");
//    for (int i = 0; i< 50; i++) {
//        [self lockTest:i];
//    }
    
//    for (int i = 0; i< 50; i++) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self lockTest:i];
//        });
//    }
//    for (int i = 50; i< 100; i++) {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//            [self lockTest:i];
//        });
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
//            [self lockTest:i];
//        });
//    }
    
   // [self testSemaphore];
}


-(void)lockTest:(int)i{
    static int a = 0;
    dispatch_semaphore_wait(self.semap, DISPATCH_TIME_FOREVER);
    //[NSThread sleepForTimeInterval:0.5];
    a += 1;
    self.str = [NSString stringWithFormat:@"asd%d",a];
    NSLog(@"i = %d 调用次数 = %@ \n%@",i,self.str,[NSThread currentThread]);
    dispatch_semaphore_signal(self.semap);
}


-  (BOOL)testSemaphore {
    __block BOOL resultValue = NO;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    NSLog(@"创建信号量");
    [self semaphoreBlock:^{
        resultValue = YES;
        NSLog(@"开始释放信号量,%@", [NSThread currentThread]);
        dispatch_semaphore_signal(semaphore);
    }];
    NSLog(@"等待信号量,%@", [NSThread currentThread]);
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"执行returen操作啦");
    return resultValue;
}


- (void)semaphoreBlock:(void(^)(void))block {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"进来block了,%@", [NSThread currentThread]);
        block();
    });
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
