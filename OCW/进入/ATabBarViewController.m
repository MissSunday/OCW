//
//  ATabBarViewController.m
//  OCW
//
//  Created by 朵朵 on 2021/7/20.
//

#import "ATabBarViewController.h"
#import "AViewController.h"
#import "BViewController.h"
#import "CViewController.h"
#import "DViewController.h"
#import "BaseNavigationController.h"
@interface ATabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation ATabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.view.backgroundColor = [UIColor mainColor];
    self.tabBar.barTintColor = [UIColor whiteColor];
    //self.tabBar.translucent = NO;
    [self UI];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    UIView *view = self.tabBar.subviews.firstObject;
    view.backgroundColor = UIColor.whiteColor;
    
}
-(void)UI{
    NSArray *array = @[@{@"title":@"A",@"img":@"tab_A_N",
                         @"selectedImg":@"tab_A_S",
                         @"class":@"AViewController"},
                       @{@"title":@"B",@"img":@"tab_B_N",
                         @"selectedImg":@"tab_B_S",
                         @"class":@"BViewController"},
                       @{@"title":@"C",@"img":@"tab_C_N",
                         @"selectedImg":@"tab_C_S",
                         @"class":@"CViewController"},
                       @{@"title":@"D",@"img":@"tab_D_N",
                         @"selectedImg":@"tab_D_S",
                         @"class":@"DViewController"},
    ];
    for (NSDictionary *dic in array) {
        [self createItemWithDict:dic];
    }
    
}
-(void)createItemWithDict:(NSDictionary *)dict {
    
    NSString *title = dict[@"title"];
    NSString *img = dict[@"img"];
    NSString *selectedImg = dict[@"selectedImg"];
    Class cls = NSClassFromString(dict[@"class"]);
    
    BaseNavigationController * viewController = [[BaseNavigationController alloc] initWithRootViewController:[[cls alloc] init]];
    viewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[[UIImage imageNamed:img]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImg]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [viewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor mainColor]} forState:UIControlStateSelected];
    [viewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor color69]} forState:UIControlStateNormal];
    [self addChildViewController:viewController];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    return YES;
}


@end
