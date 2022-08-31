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
        config.supportBingFa = YES;
        config.backToMainThread = NO;
        config.isDebug = YES;
        config.needLog = NO;
        NSLog(@"参数设置完毕");
    }];
    
    //同步  在当前队列返回 
    id aaa = [[XXSDK sdk]getTokenSync];
    NSLog(@"aaa = %@",aaa);

    NSLog(@"1234");
    //异步
    [[XXSDK sdk]getTokenAsync:^(id  _Nonnull object) {

        NSLog(@"getTokenReturn - %@ %@",object,[NSThread currentThread]);
    }];
    NSLog(@"5678");
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
