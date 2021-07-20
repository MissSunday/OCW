//
//  BaseNavigationController.m
//  OCW
//
//  Created by 朵朵 on 2021/7/20.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

/**
 导航的基础配置
 @author 王晓冉
 @date 2020/04/01
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    
    // 设置返回箭头
    UIImage *image = [UIImage imageNamed:@"login_back_img"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navigationBar.backIndicatorImage = image;
    navigationBar.backIndicatorTransitionMaskImage = image;
}
/**
 设置push隐藏tabbar
 @author 王晓冉
 @date 2020/04/01
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
}

@end
