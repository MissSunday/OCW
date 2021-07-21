//
//  BHViewController.h
//  OCW
//
//  Created by 朵朵 on 2021/7/21.
//

#import "BaseViewController.h"
#import "GKPageScrollView.h"
#import "GKBaseListViewController.h"
#import "JXCategoryView.h"
NS_ASSUME_NONNULL_BEGIN

@interface BHViewController : BaseViewController<GKPageScrollViewDelegate>
// pageScrollView
@property (nonatomic, strong) GKPageScrollView  *pageScrollView;

@property (nonatomic, strong) JXCategoryTitleView   *segmentView;
@property (nonatomic, strong) UIScrollView          *contentScrollView;

@property (nonatomic, strong) NSArray           *childVCs;
@end

NS_ASSUME_NONNULL_END
