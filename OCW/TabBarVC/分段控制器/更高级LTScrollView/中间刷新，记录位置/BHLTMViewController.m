//
//  BHLTMViewController.m
//  OCW
//
//  Created by 朵朵 on 2021/7/26.
//

#import "BHLTMViewController.h"
#import "BHLTMHeaderView.h"
#import "BHLTMListViewController.h"
@interface BHLTMViewController ()<LTAdvancedScrollViewDelegate>
@property(copy, nonatomic) NSArray <UIViewController *> *viewControllers;
@property(copy, nonatomic) NSArray <NSString *> *titles;
@property(strong, nonatomic) LTLayout *layout;
@property(strong, nonatomic) LTAdvancedManager *managerView;

@end

@implementation BHLTMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = NSStringFromClass([self class]);
    
    [self setupSubViews];
}


-(void)setupSubViews {
    
    [self.view addSubview:self.managerView];
    
    [self.managerView setAdvancedDidSelectIndexHandle:^(NSInteger index) {
        NSLog(@"%ld", index);
    }];
}

-(LTAdvancedManager *)managerView {
    if (!_managerView) {
        
        _managerView = [[LTAdvancedManager alloc]initWithFrame:CGRectMake(0, 0, kS_W, kS_H) viewControllers:self.viewControllers titles:self.titles currentViewController:self layout:self.layout titleView:nil headerViewHandle:^UIView * _Nonnull{
            return [self setupHeaderView];
        }];
        
        
        /* 设置代理 监听滚动 */
        _managerView.delegate = self;
        
        /* 设置悬停位置 */
        //        _managerView.hoverY = 64;
        
        /* 点击切换滚动过程动画 */
//        _managerView.isClickScrollAnimation = YES;
        
        /* 代码设置滚动到第几个位置 */
//        [_managerView scrollToIndexWithIndex:self.viewControllers.count - 1];
    }
    return _managerView;
}

-(void)glt_scrollViewOffsetY:(CGFloat)offsetY {
    NSLog(@"---> %lf", offsetY);
}

-(BHLTMHeaderView *)setupHeaderView {
    BHLTMHeaderView *headerView = [[BHLTMHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 180.0)];
    return headerView;
}

-(LTLayout *)layout {
    if (!_layout) {
        _layout = [[LTLayout alloc] init];
        _layout.isAverage = YES;
        _layout.sliderWidth = 20;
        /* 更多属性设置请参考 LTLayout 中 public 属性说明 */
    }
    return _layout;
}


- (NSArray <NSString *> *)titles {
    if (!_titles) {
        _titles = @[@"热门", @"精彩推荐", @"科技控", @"游戏"];
    }
    return _titles;
}


-(NSArray <UIViewController *> *)viewControllers {
    if (!_viewControllers) {
        _viewControllers = [self setupViewControllers];
    }
    return _viewControllers;
}


-(NSArray <UIViewController *> *)setupViewControllers {
    NSMutableArray <UIViewController *> *testVCS = [NSMutableArray arrayWithCapacity:0];
    [self.titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger index, BOOL * _Nonnull stop) {
        BHLTMListViewController *testVC = [[BHLTMListViewController alloc] init];
        [testVCS addObject:testVC];
    }];
    return testVCS.copy;
}


@end
