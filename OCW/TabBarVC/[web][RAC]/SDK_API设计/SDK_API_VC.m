//
//  SDK_API_VC.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/2/24.
//

#import "SDK_API_VC.h"
#import "XXSDK.h"
@interface SDK_API_VC ()

@end

@implementation SDK_API_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSStringFromClass(self.class);
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //初始化 写在AppDelegate里
    [[XXSDK sdk]registAppKey:@"" configBlock:^(XXSDKConfig *config) {
        config.supportBingFa = NO;
        //config.backToMainThread = NO;
    }];

    for (int i = 0; i < 2; i ++) {
        
//        dispatch_queue_t queue = dispatch_queue_create("asd", DISPATCH_QUEUE_CONCURRENT);
//        dispatch_async(queue, ^{
//            //使用
//            [[XXSDK sdk] getToken:^(id  _Nonnull object) {
//
//                NSLog(@"返回数据 - %@ %@",object,[NSThread currentThread]);
//            }];
//        });
      
    }
    
    [[XXSDK sdk] getToken:^(id  _Nonnull object) {
                
        NSLog(@"返回数据 - %@ %@",object,[NSThread currentThread]);
    }];
    
    
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
