//
//  BViewController.m
//  OCW
//
//  Created by 朵朵 on 2021/7/20.
//

#import "BViewController.h"
#import "BHViewController.h"
#import "BTViewController.h"
#import "SPPageMenu.h"
#import "BHLTViewController.h"
#import "BTOneViewController.h"
#import "T.h"
#define pageMenuH 50

#define scrollViewHeight (kS_H-kNavHeight-kTabbarHeight-pageMenuH)

@interface BViewController ()<SPPageMenuDelegate, UIScrollViewDelegate>

@property (nonatomic,weak)SPPageMenu *pageMenu;

@property (nonatomic,strong)UIScrollView *scrollView;

@property (nonatomic,strong)NSMutableArray *myChildViewControllers;

@property (nonatomic,strong)NSArray *titleArray;
@end


@implementation BViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"分段控制器";
    [self nav];
    [self UI];
    [XRTool logPropertyOfClass:[T class]];
    [XRTool logMethodNamesOfClass:[T class]];
}
-(void)UI{
    self.titleArray = @[@"一手房",@"二手房",@"租房"];
    
    // trackerStyle:跟踪器的样式
    SPPageMenu *pageMenu = [SPPageMenu pageMenuWithFrame:CGRectMake(0, 0, kS_W, pageMenuH) trackerStyle:SPPageMenuTrackerStyleLine];
    // 传递数组，默认选中第0个
    [pageMenu setItems:self.titleArray selectedItemIndex:0];
    // 不可滑动的等宽排列
    pageMenu.permutationWay = SPPageMenuPermutationWayNotScrollEqualWidths;
    pageMenu.trackerWidth = 30;
    pageMenu.dividingLine.image = [UIImage imageWithColor:[UIColor color6E]];
    pageMenu.dividingLineHeight = 0.5;
    pageMenu.selectedItemTitleColor = [UIColor blackColor];
    pageMenu.unSelectedItemTitleColor = [UIColor color63];
    pageMenu.selectedItemTitleFont = [UIFont boldSystemFontOfSize:15];
    pageMenu.unSelectedItemTitleFont = [UIFont systemFontOfSize:14];
    pageMenu.trackerColor = [UIColor mainColor];
    // 设置代理
    pageMenu.delegate = self;
    // 给pageMenu传递外界的大scrollView，内部监听self.scrollView的滚动，从而实现让跟踪器跟随self.scrollView移动的效果
    pageMenu.bridgeScrollView = self.scrollView;
    [self.view addSubview:pageMenu];
    _pageMenu = pageMenu;
    
    [self.view addSubview:self.scrollView];
    
    NSArray *controllerClassNames = [NSArray arrayWithObjects:@"BTOneViewController",@"BTViewController",@"BTViewController", nil];
    for (int i = 0; i < self.titleArray.count; i++) {
        if (controllerClassNames.count > i) {
            BaseViewController *baseVc = [[NSClassFromString(controllerClassNames[i]) alloc] init];
            id object = [self.pageMenu contentForItemAtIndex:i];
            if ([object isKindOfClass:[NSString class]]) {
                
            } else if ([object isKindOfClass:[UIImage class]]) {
                
            } else {
                //SPPageMenuButtonItem *item = (SPPageMenuButtonItem *)object;
            }
            [self addChildViewController:baseVc];
            // 控制器本来自带childViewControllers,但是遗憾的是该数组的元素顺序永远无法改变，只要是addChildViewController,都是添加到最后一个，而控制器不像数组那样，可以插入或删除任意位置，所以这里自己定义可变数组，以便插入(删除)(如果没有插入(删除)功能，直接用自带的childViewControllers即可)
            [self.myChildViewControllers addObject:baseVc];
        }
    }
    
    // pageMenu.selectedItemIndex就是选中的item下标
    if (self.pageMenu.selectedItemIndex < self.myChildViewControllers.count) {
        BaseViewController *baseVc = self.myChildViewControllers[self.pageMenu.selectedItemIndex];
        
        [self.scrollView addSubview:baseVc.view];
        baseVc.view.frame = CGRectMake(kS_W*self.pageMenu.selectedItemIndex, 0, kS_W, scrollViewHeight);
        self.scrollView.contentOffset = CGPointMake(kS_W*self.pageMenu.selectedItemIndex, 0);
        self.scrollView.contentSize = CGSizeMake(self.titleArray.count*kS_W, 0);
    }
}
#pragma mark - Delegate
#pragma mark - SPPageMenu的代理方法
- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedAtIndex:(NSInteger)index {
    NSLog(@"%zd",index);
}

- (void)pageMenu:(SPPageMenu *)pageMenu itemSelectedFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    NSLog(@"%zd------->%zd",fromIndex,toIndex);
    
    // 如果该代理方法是由拖拽self.scrollView而触发，说明self.scrollView已经在用户手指的拖拽下而发生偏移，此时不需要再用代码去设置偏移量，否则在跟踪模式为SPPageMenuTrackerFollowingModeHalf的情况下，滑到屏幕一半时会有闪跳现象。闪跳是因为外界设置的scrollView偏移和用户拖拽产生冲突
    if (!self.scrollView.isDragging) { // 判断用户是否在拖拽scrollView
        // 如果fromIndex与toIndex之差大于等于2,说明跨界面移动了,此时不动画.
        if (labs(toIndex - fromIndex) >= 2) {
            [self.scrollView setContentOffset:CGPointMake(kS_W * toIndex, 0) animated:NO];
        } else {
            [self.scrollView setContentOffset:CGPointMake(kS_W * toIndex, 0) animated:YES];
        }
    }
    
    if (self.myChildViewControllers.count <= toIndex) {return;}
    
    BaseViewController *targetViewController = self.myChildViewControllers[toIndex];
    // 如果已经加载过，就不再加载
    if ([targetViewController isViewLoaded]) return;
    if (toIndex == 0) {
        
    }else if (toIndex == 1){
        
    }else{
        
    }
    targetViewController.view.frame = CGRectMake(kS_W * toIndex, 0, kS_W, scrollViewHeight);
    [_scrollView addSubview:targetViewController.view];
    
}
-(void)nav{
   
}
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, pageMenuH, kS_W, scrollViewHeight)];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return  _scrollView;
}

- (NSMutableArray *)myChildViewControllers {
    
    if (!_myChildViewControllers) {
        _myChildViewControllers = [NSMutableArray array];
        
    }
    return _myChildViewControllers;
}






@end
