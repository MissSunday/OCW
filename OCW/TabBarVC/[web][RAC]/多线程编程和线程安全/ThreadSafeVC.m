//
//  ThreadSafeVC.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/1/21.
//

#import "ThreadSafeVC.h"
#import "ThreadLockVC.h"
#import "NSOperationVC.h"
@interface ThreadSafeVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,assign)NSInteger ticketNumber;

@property(nonatomic,strong)NSLock *lock;

@property(nonatomic,strong)dispatch_queue_t readWriteQueue;

@property(nonatomic,assign)int num;

@property(nonatomic,strong)NSMutableDictionary *dict;

@property(nonatomic,strong)dispatch_semaphore_t semap;

@property(nonatomic,assign)BOOL isSafe;

@end



@implementation ThreadSafeVC

static dispatch_queue_t url_session_manager_processing_queue() {
    static dispatch_queue_t af_url_session_manager_processing_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        af_url_session_manager_processing_queue = dispatch_queue_create("com.alamofire.networking.session.manager.processing", DISPATCH_QUEUE_CONCURRENT);
    });

    return af_url_session_manager_processing_queue;
}
static dispatch_queue_t seq_queue() {
    static dispatch_queue_t seq_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        seq_queue = dispatch_queue_create("com.alamofire.networking.session.manager.get", DISPATCH_QUEUE_SERIAL);
    });

    return seq_queue;
}
static dispatch_group_t url_session_manager_completion_group() {
    static dispatch_group_t af_url_session_manager_completion_group;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        af_url_session_manager_completion_group = dispatch_group_create();
    });

    return af_url_session_manager_completion_group;
}
@synthesize ticketNumber = _ticketNumber;

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@"串行",
                       @"并行",
                       @"串行",
                       @"线程安全",
                       @"NSOperationQueue",
                       @"读写锁",
                       @"死锁"].mutableCopy;
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSStringFromClass(self.class);
    self.readWriteQueue = dispatch_queue_create("readWriteQueue", DISPATCH_QUEUE_SERIAL);
    self.semap = dispatch_semaphore_create(1);
    self.ticketNumber = 100;
    self.num = 10;
    self.isSafe = YES;
    self.dict = @{}.mutableCopy;
    self.lock = [[NSLock alloc]init];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self nav];
    
//
//    dispatch_async(url_session_manager_processing_queue(), ^{
//
//        NSLog(@"12345 -> [%@]",[NSThread currentThread]);
//
//
//        dispatch_group_async(url_session_manager_completion_group(), dispatch_get_main_queue(), ^{
//
//            NSLog(@"AAAAAAA -> [%@]",[NSThread currentThread]);
//
//            dispatch_async(dispatch_get_main_queue(), ^{
//
//                NSLog(@"BBBBB -> [%@]",[NSThread currentThread]);
//
//            });
//        });
//
//
//
//    });
   
//    RACSignal *s1 = [self netNumber:1];
//    RACSignal *s2 = [s1 then:^RACSignal * _Nonnull{
//        return [self netNumber:2];
//    }];
//    RACSignal *s3 = [s2 then:^RACSignal * _Nonnull{
//        return [self netNumber:3];
//    }];
//    [s1 subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
//    [s2 subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
//    [s3 subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
//
//    RACCommand *com = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
//        return [self netNumber:[input[@"key"]intValue]];
//    }];
//    [[com execute:@{@"key":@10}]subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];

    
   
    for (int i = 0; i < 10; i++) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            dispatch_async(seq_queue(), ^{
                //NSCondition *condition =[[NSCondition alloc] init];
                //NSConditionLock *conditionLock = [[NSConditionLock alloc] initWithCondition:3];
                dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
                ///!!!: 在当前作用域内顺序执行的3种方案
                NSLog(@"开始 %d %@",i,[NSThread currentThread]);
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    //模拟异步耗时操作
                    [NSThread sleepForTimeInterval:0.2];
                    NSLog(@"结束 %d",i);
                    //[condition signal];
                    //[condition unlock];
                    //[conditionLock unlockWithCondition:1];
                    dispatch_semaphore_signal(semaphore);
                   
                });
                //[condition wait];
                dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
                //[conditionLock lockWhenCondition:1];//条件不满足，等待
                //[conditionLock unlock];
                //要求这里等待异步操作执行完毕后再执行
                NSLog(@"最后 %d",i);
            });
        });
    }

      
    
    
   
}

-(void)test:(void(^)(int a))block{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:0.3];
        block(1);
    });
}



-(RACSignal *)netNumber:(int)i{
    RACSignal * signal1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        dispatch_async(self.readWriteQueue, ^{
            NSString *str = @"http://www.jianshu.com/p/6930f335adba";
            NSURL *url = [NSURL URLWithString:str];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            NSURLSession *session = [NSURLSession sharedSession];
            
            
            NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                [NSThread sleepForTimeInterval:2];
                [subscriber sendNext:[NSString stringWithFormat:@"网络完成 %d",i]];
                [subscriber sendCompleted];
            }];
            
            [task resume];

            
        });
        return nil;
    }];
    return signal1;
}
-(void)nav{
    @weakify(self);
    self.navigationItem.rightBarButtonItem = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"测试锁" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:(UIControlStateHighlighted)];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [self.navigationController pushViewController:ThreadLockVC.new animated:YES];
        }];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
        item;
    });
}
//串行队列
-(void)gcd_cxQueue{
    
    //这个只是队列 不是线程  线程会根据执行方式的不同，走不同的线程
    dispatch_queue_t cxQueue = dispatch_queue_create("chuanxing", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t ccQueue = dispatch_queue_create("chuanxing", DISPATCH_QUEUE_SERIAL);
   
    //同步串行
    //这里决定了使用哪个线程搞事
    dispatch_sync(cxQueue, ^{
        NSLog(@"这里决定了使用哪个线程搞事");
        NSLog(@"当前线程-%@ \n同步串行不会开启新线程只能在当前线程",[NSThread currentThread]);
    });
    //异步串行
    dispatch_async(cxQueue, ^{
        NSLog(@"当前线程-%@ \n串行队列追加异步任务",[NSThread currentThread]);
    });
   
    dispatch_async(ccQueue, ^{
        //作用域内是开辟了一个新的线程，作用域外是主线程，这两个线程内任务的执行先后无关
        
        NSLog(@"1 模拟网络请求耗时");
        [NSThread sleepForTimeInterval:1];
        NSLog(@"1 串行执行任务");
        NSLog(@"当前线程-%@ \n异步串行会开启1个新线程",[NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSLog(@"1 回到主线程 - %@",[NSThread currentThread]);
            
        });
        
    });
    //ccQueue队列追加任务
    dispatch_async(ccQueue, ^{
        //作用域内是开辟了一个新的线程，作用于外是主线程，这两个线程内任务的执行先后无关
        
        NSLog(@"2 模拟网络请求耗时");
        [NSThread sleepForTimeInterval:1];
        NSLog(@"2 串行执行任务");
        NSLog(@"当前线程-%@ \n异步串行会开启1个新线程",[NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSLog(@"2 回到主线程 - %@",[NSThread currentThread]);
            
        });
        
    });
    
}
//并发队列
-(void)gcd_bfQueue{
    
    dispatch_queue_t bfQueue = dispatch_queue_create("并发1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t glQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t cx = dispatch_queue_create("串行2", DISPATCH_QUEUE_SERIAL);
    
    //同步并行
    dispatch_sync(bfQueue, ^{
        
        NSLog(@"当前线程-%@ \n同步并行不会开启新线程只能在当前线程，任务按顺序执行",[NSThread currentThread]);
        NSLog(@"1");
        NSLog(@"2");
        NSLog(@"3");
    });
    
    //异步并行
    dispatch_async(glQueue, ^{
        
        //作用域内相当于任务 是顺序执行的
        //        NSLog(@"当前线程-%@ \n异步并行会开启n个新线程，任务无序执行",[NSThread currentThread]);
        //        NSLog(@"1");
        //        NSLog(@"2");
        //        NSLog(@"3");
        dispatch_async(cx, ^{
            NSLog(@"当前线程-%@ \n同步并行不会开启新线程只能在当前线程，任务按顺序执行",[NSThread currentThread]);
            NSLog(@"1");
            NSLog(@"2");
            NSLog(@"3");
            
            
        });
    });
    dispatch_async(glQueue, ^{
        
        //        NSLog(@"当前线程-%@ \n异步并行会开启n个新线程，任务无序执行",[NSThread currentThread]);
        //
        //        NSLog(@"4");
        //        NSLog(@"5");
        //        NSLog(@"6");
        dispatch_async(cx, ^{
            NSLog(@"当前线程-%@ \n异步并行会开启n个新线程，任务无序执行",[NSThread currentThread]);
            
            NSLog(@"4");
            NSLog(@"5");
            NSLog(@"6");
            
            
        });
        
    });
    dispatch_async(glQueue, ^{
        
        //        NSLog(@"当前线程-%@ \n异步并行会开启n个新线程，任务无序执行",[NSThread currentThread]);
        //
        //        NSLog(@"4");
        //        NSLog(@"5");
        //        NSLog(@"6");
        dispatch_async(cx, ^{
            
            
            
            NSLog(@"当前线程-%@ \n异步并行会开启n个新线程，任务无序执行",[NSThread currentThread]);
            
            NSLog(@"7");
            NSLog(@"8");
            NSLog(@"9");
            
            
        });
        
    });
    dispatch_async(glQueue, ^{
        
        //        NSLog(@"当前线程-%@ \n异步并行会开启n个新线程，任务无序执行",[NSThread currentThread]);
        //
        //        NSLog(@"4");
        //        NSLog(@"5");
        //        NSLog(@"6");
        dispatch_async(cx, ^{
            NSLog(@"当前线程-%@ \n异步并行会开启n个新线程，任务无序执行",[NSThread currentThread]);
            
            NSLog(@"10");
            NSLog(@"11");
            NSLog(@"12");
            
            
        });
        
    });
    //如上，glQueue队列有两个任务，这两个任务的执行顺序是无序的
    
    
}














- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell className] forIndexPath:indexPath];
    NSString *a = self.dataArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld.  %@",indexPath.row + 1,a];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self gcd_cxQueue];
    }else if (indexPath.row == 1){
        [self gcd_bfQueue];
    }else if (indexPath.row == 2){
        
    }else if (indexPath.row == 3){
        
    }else if (indexPath.row == 4){
        [self.navigationController pushViewController:NSOperationVC.new animated:YES];
    }else if (indexPath.row == 5){
        
        dispatch_queue_t queue = dispatch_queue_create("bfQueue", DISPATCH_QUEUE_CONCURRENT);
        for (int i = 0; i < 30; i ++) {
            
            //异步并发
            dispatch_async(queue, ^{

                [self read];
                [self write];
            });
            dispatch_async(queue, ^{
                [self write];
                [self read];
            });
            
        }
    }else if (indexPath.row == 6){
        //在串行队列内 追加同步任务 会死锁
        dispatch_queue_t q = dispatch_queue_create("q", DISPATCH_QUEUE_SERIAL);
        dispatch_async(q, ^{
            NSLog(@"123");
            dispatch_async(q, ^{
                NSLog(@"666");
            });
            
            dispatch_sync(q, ^{
                NSLog(@"4");
            });
            
            NSLog(@"567");
        });
    }
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 50;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        //_tableView.bounces = NO;
        //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[UITableViewCell className]];
        _tableView.tableFooterView = [UIView new];
        
    }
    return _tableView;
}

-(void)read{
    [self.lock lock];
    //dispatch_semaphore_wait(self.semap, DISPATCH_TIME_FOREVER);
    NSLog(@"读 - %d  %@",self.isSafe,[NSThread currentThread]);
    //dispatch_semaphore_signal(self.semap);
    [self.lock unlock];
}

-(void)write{
    [self.lock lock];
    //dispatch_semaphore_wait(self.semap, DISPATCH_TIME_FOREVER);
    self.isSafe = !self.isSafe;
    NSLog(@"写 - %d  %@",_isSafe,[NSThread currentThread]);
    //dispatch_semaphore_signal(self.semap);
    [self.lock unlock];
}

//setGet内加锁 只能保证同一时间只有一个线程访问资源，但是没法保证连续
- (void)setTicketNumber:(NSInteger)ticketNumber{

    dispatch_barrier_sync(self.readWriteQueue, ^{
        //sleep(time);
        //[NSThread sleepForTimeInterval:0.5];
        _ticketNumber = ticketNumber;
        //NSLog(@"%@ - %ld",[NSThread currentThread],self->_ticketNumber);
    });
    //_ticketNumber = ticketNumber;
}
- (NSInteger)ticketNumber{


    //return _ticketNumber;
    __block NSInteger result;
    dispatch_sync(self.readWriteQueue, ^{
        result = _ticketNumber;
    });
    return result;
}

@end
