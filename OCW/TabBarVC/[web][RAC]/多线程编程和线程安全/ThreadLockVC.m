//
//  ThreadLockVC.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/2/17.
//

#import "ThreadLockVC.h"

@interface ThreadLockVC ()

@property(nonatomic,strong)NSLock *lock1;
@property(nonatomic,strong)NSLock *lock2;
@property(nonatomic,strong)NSLock *lock3;
@property(nonatomic,strong)dispatch_semaphore_t sem;
@property(nonatomic,strong)dispatch_semaphore_t sem0;

@property(nonatomic,strong)dispatch_queue_t bfqueue;
@property(nonatomic,strong)dispatch_queue_t bfq;



@end

@implementation ThreadLockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lock1 = [[NSLock alloc]init];
    self.lock2 = [[NSLock alloc]init];
    self.lock3 = [[NSLock alloc]init];
    self.bfqueue = dispatch_queue_create("bfqueue", DISPATCH_QUEUE_SERIAL);
    self.bfq = dispatch_queue_create("bf", DISPATCH_QUEUE_CONCURRENT);
    self.sem = dispatch_semaphore_create(1);
    self.sem0 = dispatch_semaphore_create(0);
    
   
    [self nav];
}
-(void)nav{
    @weakify(self);
    self.navigationItem.rightBarButtonItem = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"sem0" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:(UIControlStateHighlighted)];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            
            for (int i = 0; i < 5; i ++) {
                
            }
        }];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
        item;
    });
}


-(void)lock{
    dispatch_semaphore_wait(self.sem, DISPATCH_TIME_FOREVER);
}
-(void)unlock{
    dispatch_semaphore_signal(self.sem);
}
//测试3个方法 有依赖情况下 多线程并发  顺序调用
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    __weak  typeof(self) weakS = self;
       void (^block1)(void) = ^{
           NSLog(@" -- %@ --",weakS);
           //__strong typeof(weakS) strongS = weakS;
           //BVC * vc = weakS; 这种形式和__strong typeof(weakS)相同
           //strongS其实只是个局部变量的强指针，它在作用域内不会被释放
     
           //这里模拟一个dispatch_async,dispatch_after其实就是异步的
           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
               NSLog(@" == %@ ==",self);
           });
       };
       //_v.block1 = block1;
    block1();
}


-(void)func1{
    
    
    
    dispatch_async(self.bfq, ^{
       
        [self.lock1 lock];
        
        dispatch_async(self.bfqueue, ^{

            NSLog(@"1 开始 - %@",[NSThread currentThread]);
            [NSThread sleepForTimeInterval:0.5];
            
            
            
            [self func2:^(BOOL a) {
                
                [NSThread sleepForTimeInterval:0.5];
                NSLog(@"5 返回 - %@",[NSThread currentThread]);
                
            }];
           
            NSLog(@"隔断 1 - ----- %@",[NSThread currentThread]);
            
            [self func3:^(BOOL a) {
                [NSThread sleepForTimeInterval:0.5];
                NSLog(@"3 返回 - %@",[NSThread currentThread]);
            }];
            
            NSLog(@"隔断 2 - - - -- - %@",[NSThread currentThread]);
            
            [self.lock1 unlock];
        });
        
    });
    
    
    
    
}
-(void)func2:(void(^)(BOOL a))success{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{

        NSLog(@"2 开始 - %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:0.5];
        
        success(YES);
        
    });
    
   
}
-(void)func3:(void(^)(BOOL a))success{
    
    dispatch_async(self.bfqueue, ^{
        if (![NSThread currentThread].isMainThread) {
            //[self.lock3 lock];
        }
        NSLog(@"3 开始- %@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:0.5];
        success(YES);
    });
    
   
}

@end
