//
//  XRPhotoBrower.m
//  OCW
//
//  Created by 朵朵 on 2021/7/28.
//

#import "XRPhotoBrower.h"
#import "XRPhotoPreviewCell.h"
#import "XRPhotoBrowerNav.h"

@interface XRPhotoBrower ()
<
UICollectionViewDataSource,
UICollectionViewDelegate,
UIScrollViewDelegate
>

@property (nonatomic,strong)XRPhotoBrowerNav *nav;

@property (nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,assign)NSInteger sourceType;
@end

@implementation XRPhotoBrower
- (instancetype)init
{
    self = [super init];
    if (self) {
        _showNav = YES;
        _selectIndex = 0;
    }
    return self;
}
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.sourceType = 3;
    self.sourceType = [self checkImageSource];
    NSAssert(self.sourceType < 3, @"没传数据源");
    [self defaultValue];
    [self UI];
    
}
#pragma mark 一些默认值
-(void)defaultValue{
    self.isHidenNav = YES;
    self.view.backgroundColor = [UIColor blackColor];
    [self configData];
}
-(void)configData{
  
}
#pragma mark UI
-(void)UI{
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.nav];
    [self layout];
}
#pragma mark layout
-(void)layout{
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(-10);
        make.top.equalTo(self.view);
        make.width.mas_equalTo(self.view.width + 20);
        make.bottom.equalTo(self.view);
    }];
    [self.nav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(kNavHeight);
    }];
    self.nav.hidden = !self.showNav;
    [self binding];
}
#pragma mark 方法绑定
-(void)binding{
    @weakify(self);
    [[self.nav.backBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    //延时处理  不做延时的话  collection和sppagemenu初始化都需要时间  一进来就给他们值 可能不触发  延时是为了让控件先把数据加载完成  之后再进行索引赋值  一般手机只要不是太卡  0.1秒够用了 肉眼也感觉不到
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.selectIndex inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionNone) animated:NO];

    });
}
-(NSInteger)checkImageSource{
    if (self.photoUrls) {
        return 0;
    }else if (self.photos){
        return 1;
    }else if (self.photoNames){
        return 2;
    }
    return 3;
}
#pragma mark - Delegate
#pragma mark - UICollectionViewDataSource && Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.sourceType == 0) {
        return self.photoUrls.count;
    }
    if (self.sourceType == 1) {
        return self.photos.count;
    }
    if (self.sourceType == 2) {
        return self.photoNames.count;
    }
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XRPhotoPreviewCell *photoPreviewCell = [collectionView dequeueReusableCellWithReuseIdentifier:[XRPhotoPreviewCell description] forIndexPath:indexPath];
    if (self.sourceType == 0) {
        photoPreviewCell.imageUrl = self.photoUrls[indexPath.item];
    }
    if (self.sourceType == 1) {
        photoPreviewCell.image = self.photos[indexPath.item];
    }
    if (self.sourceType == 2) {
        photoPreviewCell.imageName = self.photoNames[indexPath.item];
    }
    @weakify(self);
    [photoPreviewCell.subject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.showNav = !self.showNav;
        self.nav.hidden = !self.showNav;
    }];
    return photoPreviewCell;
}
//要出现的那个
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[XRPhotoPreviewCell class]]) {
       [(XRPhotoPreviewCell *)cell recoverSubviews];
    }
}
//划走的那个
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[XRPhotoPreviewCell class]]) {
        [(XRPhotoPreviewCell *)cell recoverSubviews];
    }
}


#pragma mark - 懒加载
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        // 创建FlowLayout
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //设置单元格大小
        flowLayout.itemSize = CGSizeMake(self.view.width + 20, self.view.height);
        //最小行间距(默认为10)
        flowLayout.minimumLineSpacing = 0;
        //最小item间距（默认为10）
        flowLayout.minimumInteritemSpacing = 0;
        //设置senction的内边距
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //设置UICollectionView的滑动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //sectionHeader的大小,如果是竖向滚动，只需设置Y值。如果是横向，只需设置X值。
        flowLayout.headerReferenceSize = CGSizeMake(0,0);
        // 创建collectionView
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        // 设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.scrollsToTop = NO;
        //_collectionView.contentOffset = CGPointMake(0, 0);
        _collectionView.contentSize = CGSizeMake(self.photos.count * (self.view.width + 20), 0);
        // 其他属性
        _collectionView.backgroundColor = [UIColor blackColor];
        // 注册cell
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[XRPhotoPreviewCell class] forCellWithReuseIdentifier:[XRPhotoPreviewCell description]];
        if (@available(iOS 11, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _collectionView;
}
- (XRPhotoBrowerNav *)nav{
    if (!_nav) {
        _nav = [[XRPhotoBrowerNav alloc] init];
        _nav.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }
    return _nav;
}



@end
