//
//  XRBaseNavigationController.m
//  OCW
//
//  Created by 朵朵 on 2021/7/20.
//

#import "XRBaseNavigationController.h"
#import "NSBundle+XRBundle.h"
@interface XRBaseNavigationController ()

@end

@implementation XRBaseNavigationController

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
    UIImage *image = [NSBundle xr_navBackImage];
    //image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navigationBar.backIndicatorImage = image;
    navigationBar.backIndicatorTransitionMaskImage = image;
    UIView *view = self.navigationBar.subviews.firstObject;
    view.backgroundColor = UIColor.orangeColor;

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
