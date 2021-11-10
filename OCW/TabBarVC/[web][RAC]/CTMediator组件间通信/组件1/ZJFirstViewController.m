//
//  ZJFirstViewController.m
//  OCW
//
//  Created by 王晓冉 on 2021/11/10.
//

#import "ZJFirstViewController.h"
#import "CTMediator+Second.h"
@interface ZJFirstViewController ()

@end

@implementation ZJFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
   UIViewController *vc = [[CTMediator sharedInstance]CTMediator_viewControllerForSecondWithBlock:^(NSString * _Nonnull str) {
       NSLog(@" 组件二回调数据了---- %@",str);
    }];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
