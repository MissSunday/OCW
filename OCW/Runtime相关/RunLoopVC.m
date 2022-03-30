//
//  RunLoopVC.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/3/23.
//

#import "RunLoopVC.h"

@interface RunLoopVC ()

@end

@implementation RunLoopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


//控制线程生命周期（线程保活、线程永驻）。
+(void)addRunLoop{
    @autoreleasepool {
        
        [[NSThread currentThread]setName:@"AFNetworking"];
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
        [runLoop run];
    }
}
+(NSThread *)netWorkThread{
    
    static NSThread *_netWorkThread = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _netWorkThread = [[NSThread alloc]initWithTarget:self selector:@selector(addRunLoop) object:nil];
        [_netWorkThread start];
    });
    
    return _netWorkThread;
}


@end
