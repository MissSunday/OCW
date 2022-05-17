//
//  DViewController.m
//  OCW
//
//  Created by 朵朵 on 2021/7/20.
//

#import "DViewController.h"
#import "T.h"
#import "co_queue.h"
@interface DViewController (){
    dispatch_queue_t cxqueue;
    dispatch_semaphore_t semaphore;
    __block BOOL _com;
    //NSInteger _time;
}

@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)UIButton *btn2;
@property(nonatomic,strong)NSLock *lock;
@end

@implementation DViewController
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    __block BOOL isInstalledCydia = NO;
    
    if ([[NSThread currentThread]isMainThread]) {
        isInstalledCydia = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]];
        NSLog(@"123");
    }else{
        dispatch_sync(dispatch_get_main_queue(), ^{
            isInstalledCydia = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]];
            NSLog(@"234");
        });
    }
    NSLog(@"77777777777");

    
    NSLog(@"45645645646456");
 
//    NSArray *objs = [NSArray arrayWithObjects:@1, @1, @2, nil];
//
//    NSNumber * a = [XRTool performSelectorWithClassName:@"Person" selectorName:@"add:add:add:" objects:objs];
//
//    NSLog(@"- %@",a);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"多线程测试";
    _com = NO;
    self.lock = [NSLock new];
    
    [self.view addSubview:self.btn];
    [self.view addSubview:self.btn2];
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view).offset(15);
        make.width.mas_equalTo((kS_W-30-15)/2);
        make.height.mas_equalTo(1.77*(kS_W-30-15)/2);
    }];
    [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.width.mas_equalTo((kS_W-30-15)/2);
        make.height.mas_equalTo(1.77*(kS_W-30-15)/2);
    }];
    //串行队列
    cxqueue = dispatch_queue_create("cxqueue", DISPATCH_QUEUE_SERIAL);
    semaphore = dispatch_semaphore_create(1);
    @weakify(self);
    [[self.btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
        NSLog(@"开始测试");
        
        //用户端调用  异步并发多个
        dispatch_queue_t queue = dispatch_queue_create("bfQueue", DISPATCH_QUEUE_CONCURRENT);
        
        for (int i = 1; i < 50; i++) {
            dispatch_async(queue, ^{
                
                //调用多次sdk接口
                [self sdkFunc:^(NSString *s) {
                    
                    NSLog(@" %d- %@ %@",i,s,[NSThread currentThread]);
                }];
            });
        }
        
        

    }];

    
    [[self.btn2 rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self ttt];
        dispatch_queue_t qwe = dispatch_queue_create("ntQueue", DISPATCH_QUEUE_CONCURRENT);
        
        dispatch_async(qwe, ^{
            
            NSLog(@"1-%@",[NSThread currentThread]);
        });
        dispatch_async(qwe, ^{
            NSLog(@"2-%@",[NSThread currentThread]);
        });
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"3-%@",[NSThread currentThread]);
        });
        dispatch_async(dispatch_queue_create("cd", DISPATCH_QUEUE_CONCURRENT), ^{
            NSLog(@"4-%@",[NSThread currentThread]);
        });
        dispatch_async(dispatch_queue_create("cf", DISPATCH_QUEUE_CONCURRENT), ^{
            NSLog(@"5-%@",[NSThread currentThread]);
        });
       
    }];
    


}
-(void)sdkFunc:(void(^)(NSString *s))block{
    
   // [self.lock lock];

    
    //dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

 
    //NSLog(@"wwwwwwwww");
    //sdk端写法
    //1. 开启一个异步串行队列
    dispatch_async(cxqueue, ^{
        [self.lock lock];
       
        //是否上报
        NSLog(@"开始了 - %@",[NSThread currentThread]);
       
        NSLog(@"部分业务逻辑判断");
        
        if (self->_com) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                block(@"asd");
                NSLog(@"结束了");
                [self.lock unlock];
                [self unlock];
                //dispatch_semaphore_signal(self->semaphore);
            });
            return;
        }
       
        dispatch_async(dispatch_queue_create("ttt", DISPATCH_QUEUE_CONCURRENT), ^{
            [NSThread sleepForTimeInterval:2];
            NSLog(@"ppppppppppp - %@",[NSThread currentThread]);
            self->_com = YES;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                block(@"666");
                NSLog(@"结束了");
                [self.lock unlock];
                //dispatch_semaphore_signal(self->semaphore);
            });
        });
        
        
        
        
        
      

        //上报  开启异步串行队列 模拟网络请求  之后回到主线程 回调
        //NSLog(@"666");
        //dispatch_semaphore_signal(self->semaphore);

    });
    
    //dispatch_queue_t allTasksQueue = dispatch_queue_create("allTasksQueue", DISPATCH_QUEUE_CONCURRENT);

    
    
//    dispatch_block_t dispatch_block = dispatch_block_create(0, ^{
//        NSLog(@"开始执行");
//        [NSThread sleepForTimeInterval:1.0];
//        NSLog(@"结束执行");
//    });
//
//    dispatch_async(cxqueue, dispatch_block);
//    // 等待时长，10s 之后超时
//    dispatch_time_t timeout = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC));
//    long resutl = dispatch_block_wait(dispatch_block, timeout);
//    if (resutl == 0) {
//        //NSLog(@"执行成功");
//        block(@"执行成功");
//    } else {
//        //NSLog(@"执行超时");
//        block(@"执行超时");
//    }
    
    
}

//- (void)setTime:(NSInteger)time{
//    NSLog(@"- ~ - %ld",time);
//    _time = time;
//}
//- (NSInteger)time{
//    NSLog(@"- ! - %ld",_time);
//    return _time;
//}


-(void)unlock{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"解锁了");
        [self.lock unlock];
    });
}
-(void)ttt{
    
}

- (UIButton *)btn{
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //_btn.backgroundColor = [UIColor orangeColor];
        [_btn setTitle:@"异步串行加中间网络请求" forState:UIControlStateNormal];
        _btn.titleLabel.numberOfLines = 0;
        _btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_btn setBackgroundImage:[UIImage imageWithColor:[UIColor orangeColor]] forState:UIControlStateNormal];
        _btn.titleLabel.font = [UIFont systemFontOfSize:18];
        _btn.clipsToBounds = YES;
        _btn.layer.cornerRadius = 15;
    }
    return _btn;
}
- (UIButton *)btn2{
    if (!_btn2) {
        _btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        //_btn.backgroundColor = [UIColor orangeColor];
        [_btn2 setTitle:@"栅栏函数" forState:UIControlStateNormal];
        _btn2.titleLabel.numberOfLines = 0;
        _btn2.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_btn2 setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_btn2 setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        _btn2.titleLabel.font = [UIFont systemFontOfSize:18];
        _btn2.clipsToBounds = YES;
        _btn2.layer.cornerRadius = 15;
    }
    return _btn2;
}
@end

