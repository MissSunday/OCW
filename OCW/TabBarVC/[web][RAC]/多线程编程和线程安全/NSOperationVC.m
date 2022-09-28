//
//  NSOperationVC.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/9/23.
//

#import "NSOperationVC.h"

@interface NSOperationVC ()
@property(nonatomic,strong)NSOperationQueue *queue;

@property(nonatomic,strong)NSLock *lock;

@property(nonatomic,strong)dispatch_semaphore_t sem;

@property(nonatomic,assign)int ticketSurplusCount;

@end

@implementation NSOperationVC
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.lock = [[NSLock alloc] init];  // 初始化 NSLock 对象
        self.sem = dispatch_semaphore_create(1);
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.queue = [[NSOperationQueue alloc]init];
    self.queue.maxConcurrentOperationCount = 1;
    
    NSBlockOperation *bop1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1 --- %@",[NSThread currentThread]);
    }];
    NSBlockOperation *bop2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"2 --- %@",[NSThread currentThread]);
    }];
    [[NSOperationQueue mainQueue]addOperation:bop1];
    [[NSOperationQueue mainQueue]addOperation:bop2];
    [self initTicketStatusSave];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 3; i ++) {
            [self addDependency];
        }
    });
}
- (void)addDependency {

   
    // 1.创建队列
    //NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    // 2.创建操作
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        
        dispatch_semaphore_t sem = dispatch_semaphore_create(0);
        
        NSLog(@"11----11");
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [NSThread sleepForTimeInterval:2]; // 模拟耗时操作
            NSLog(@"1---%@", [NSThread currentThread]); // 打印当前线程
            dispatch_semaphore_signal(sem);
        });
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
        
        
        //NSLog(@"1111111");
    }];
    [op1 addExecutionBlock:^{
        NSLog(@"1追加-%@",[NSThread currentThread]);
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        for (int i = 0; i < 2; i++) {
            [NSThread sleepForTimeInterval:1]; // 模拟耗时操作
            NSLog(@"2---%@", [NSThread currentThread]); // 打印当前线程
        }
    }];
    [op2 addExecutionBlock:^{
        NSLog(@"2追加-%@",[NSThread currentThread]);
    }];

    // 3.添加依赖
    [op2 addDependency:op1]; // 让op2 依赖于 op1，则先执行op1，在执行op2

    // 4.添加操作到队列中
    [self.queue addOperation:op1];
    [self.queue addOperation:op2];
}




/**
 * 线程安全：使用 NSLock 加锁
 * 初始化火车票数量、卖票窗口(线程安全)、并开始卖票
 */

- (void)initTicketStatusSave {
    NSLog(@"currentThread---%@",[NSThread currentThread]); // 打印当前线程

    self.ticketSurplusCount = 50;

//    // 1.创建 queue1,queue1 代表北京火车票售卖窗口
//    NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
//    queue1.maxConcurrentOperationCount = 1;
//
//    // 2.创建 queue2,queue2 代表上海火车票售卖窗口
//    NSOperationQueue *queue2 = [[NSOperationQueue alloc] init];
//    queue2.maxConcurrentOperationCount = 1;
//
//    // 3.创建卖票操作 op1
//    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
//        [self saleTicketSafe];
//    }];
//
//    // 4.创建卖票操作 op2
//    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
//        [self saleTicketSafe];
//    }];
//    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
//        [self saleTicketSafe];
//    }];
//
//    // 5.添加操作，开始卖票
//    [queue1 addOperation:op1];
//    [queue2 addOperation:op2];
//    [queue2 addOperation:op3];
    
    dispatch_queue_t q = dispatch_queue_create("bgq", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 3; i++) {
        dispatch_async(q, ^{
            [self saleTicketSafe];
        });
    }
    
    
    
}

/**
 * 售卖火车票(线程安全)
 */
- (void)saleTicketSafe {
    while (1) {

        // 加锁
        //[self.lock lock];
        //dispatch_semaphore_wait(self.sem, DISPATCH_TIME_FOREVER);

        @synchronized (self) {
            if (self.ticketSurplusCount > 0) {
                //如果还有票，继续售卖
                self.ticketSurplusCount--;
                NSLog(@"%@", [NSString stringWithFormat:@"剩余票数:%d 窗口:%@", self.ticketSurplusCount, [NSThread currentThread]]);
                [NSThread sleepForTimeInterval:0.2];
            }

            // 解锁
            //[self.lock unlock];
            //dispatch_semaphore_signal(self.sem);
            if (self.ticketSurplusCount <= 0) {
                NSLog(@"所有火车票均已售完");
                break;
            }
        }
        
       
    }
}







@end
