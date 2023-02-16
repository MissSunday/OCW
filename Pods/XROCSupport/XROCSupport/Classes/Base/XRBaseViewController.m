//
//  XRBaseViewController.m
//  XROCSupport
//
//  Created by ext.wangxiaoran3 on 2022/11/24.
//

#import "XRBaseViewController.h"

@interface XRBaseViewController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation XRBaseViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        //默认不隐藏
        _isHidenNav = NO;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 解决右滑返回失效问题
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [self updateNav];
}
//注意:这里把除了rootvc的第一个vc设置为不能pop以外,其它界面均可以pop,如果需要禁用右滑返回,除了在子vc重写navleftbtn以外,还需要重写下边的方法.
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 是否允许右滑返回
    if (self.navigationController.viewControllers.count > 1) {
        //注意:这个方法只要设置一次,就对所有的nav栈里的vc通用,所以要定义某一界面与其它界面不同的时候,需要额外的注意
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }else{
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //子类可以重写，以改变属性
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.title = NSStringFromClass([self class]);
    //去掉导航下划线
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    //导航的背景颜色
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    UIView *view = self.navigationController.navigationBar.subviews.firstObject;
    view.backgroundColor = UIColor.orangeColor;
    self.navigationController.navigationBar.translucent = NO;
    


    
}
-(void)updateNav{
    [self.navigationController setNavigationBarHidden:self.isHidenNav animated:YES];
}
- (void)dealloc {
    NSLog(@"===  %@释放了",[self class]);
}

@end
