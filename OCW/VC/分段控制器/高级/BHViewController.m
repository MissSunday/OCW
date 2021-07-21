//
//  BHViewController.m
//  OCW
//
//  Created by 朵朵 on 2021/7/21.
//

#import "BHViewController.h"

#import "GKBaseListViewController.h"
@interface BHViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView           *headerView;

@property (nonatomic, strong) UIView                *pageView;

@property (nonatomic,strong)MJRefreshNormalHeader *refreshHeader;

@end

@implementation BHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"新首页";
    self.isHidenNav = NO;
    [self.view addSubview:self.pageScrollView];
       [self.pageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.edges.equalTo(self.view);
       }];
    [self.pageScrollView reloadData];
    
    self.refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.pageScrollView.mainTableView.mj_header endRefreshingWithCompletionBlock:^{
                    
                }];
            });
    }];
    self.pageScrollView.mainTableView.mj_header = self.refreshHeader;
    
}
#pragma mark - GKPageScrollViewDelegate
- (UIView *)headerViewInPageScrollView:(GKPageScrollView *)pageScrollView {
    return self.headerView;
}

- (UIView *)pageViewInPageScrollView:(GKPageScrollView *)pageScrollView {
    return self.pageView;
}

- (NSArray<id<GKPageListViewDelegate>> *)listViewsInPageScrollView:(GKPageScrollView *)pageScrollView {
    return self.childVCs;
}
- (void)mainTableViewDidScroll:(UIScrollView *)scrollView isMainCanScroll:(BOOL)isMainCanScroll{
    //NSLog(@"%@   -----   %f",scrollView.class,scrollView.contentOffset.y);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"%@   -----   %f",scrollView.class,scrollView.contentOffset.y);
    [self.pageScrollView horizonScrollViewWillBeginScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.pageScrollView horizonScrollViewDidEndedScroll];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.pageScrollView horizonScrollViewDidEndedScroll];
}

#pragma mark - 懒加载
- (GKPageScrollView *)pageScrollView {
    if (!_pageScrollView) {
        _pageScrollView = [[GKPageScrollView alloc] initWithDelegate:self];
        _pageScrollView.ceilPointHeight = 0;
    }
    return _pageScrollView;
}

- (UIImageView *)headerView {
    if (!_headerView) {
        _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kS_W, 250)];
        _headerView.contentMode = UIViewContentModeScaleAspectFill;
        _headerView.clipsToBounds = YES;
        _headerView.image = [UIImage imageWithColor:[UIColor magentaColor]];
    }
    return _headerView;
}

- (UIView *)pageView {
    if (!_pageView) {
        _pageView = [UIView new];
        
        [_pageView addSubview:self.segmentView];
        [_pageView addSubview:self.contentScrollView];
    }
    return _pageView;
}

- (JXCategoryTitleView *)segmentView {
    if (!_segmentView) {
        _segmentView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, kS_W, 50)];
        _segmentView.titles = @[@"动态", @"文章", @"更多"];
        _segmentView.titleFont = [UIFont systemFontOfSize:15.0f];
        _segmentView.titleSelectedFont = [UIFont systemFontOfSize:15.0f];
        _segmentView.titleColor = [UIColor grayColor];
        _segmentView.titleSelectedColor = [UIColor redColor];
        
        JXCategoryIndicatorLineView *lineView = [JXCategoryIndicatorLineView new];
        lineView.lineStyle = JXCategoryIndicatorLineStyle_Normal;
        lineView.indicatorHeight = 2;
        lineView.verticalMargin = 2;
        _segmentView.indicators = @[lineView];
        _segmentView.contentScrollView = self.contentScrollView;
        
    }
    return _segmentView;
}

- (UIScrollView *)contentScrollView {
    if (!_contentScrollView) {
        CGFloat scrollW = kS_W;
        CGFloat scrollH = kS_H - 50 - kNavHeight;
        
        _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 50, scrollW, scrollH)];
        _contentScrollView.pagingEnabled = YES;
        _contentScrollView.bounces = NO;
        _contentScrollView.delegate = self;
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        [self.childVCs enumerateObjectsUsingBlock:^(GKBaseListViewController *vc, NSUInteger idx, BOOL * _Nonnull stop) {
            [self addChildViewController:vc];
            [self->_contentScrollView addSubview:vc.view];
            
            vc.view.frame = CGRectMake(idx * scrollW, 0, scrollW, scrollH);
            
            vc.scrollToTop = ^(GKBaseListViewController * _Nonnull listVC, NSIndexPath * _Nonnull indexPath) {
                [self.pageScrollView scrollToCriticalPoint];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [listVC.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
                });
            };
        }];
        _contentScrollView.contentSize = CGSizeMake(scrollW * self.childVCs.count, 0);
    }
    return _contentScrollView;
}

- (NSArray *)childVCs {
    if (!_childVCs) {
        GKBaseListViewController *dynamicVC = [GKBaseListViewController new];
        
        GKBaseListViewController *articleVC = [GKBaseListViewController new];
        
        GKBaseListViewController *moreVC = [GKBaseListViewController new];
        
        _childVCs = @[dynamicVC, articleVC, moreVC];
    }
    return _childVCs;
}

@end
