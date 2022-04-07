//
//  KNPhotoBrowserVC.m
//  OCW
//
//  Created by 朵朵 on 2021/7/27.
//

#import "KNPhotoBrowserVC.h"
#import "KNPhotoBrowserItem.h"

//icon行间距
#define itemSpace XR_Scale(10)
//collectionview 左右边距 距离父视图
#define itemleftSpace XR_Scale(10)
//icon列间距
#define itemLineSpace XR_Scale(10)

@interface KNPhotoBrowserVC ()
<
UIScrollViewDelegate,
KNPhotoBrowserDelegate
>
{
    CGFloat _itemH;
    CGFloat _itemW;
    CGFloat _contentSizeH;
}

@property(nonatomic,strong)NSArray *images;
@property(nonatomic,weak)KNPhotoBrowser *photoBrower;
@property(nonatomic,strong)NSMutableArray *sourceViews;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIView *containerView;
@end

@implementation KNPhotoBrowserVC
- (NSArray *)images{
    if (!_images) {
        NSMutableArray *array = [NSMutableArray new];
        for (int i = 0; i < 25; i++) {
            NSString *name = [NSString stringWithFormat:@"aozima_%02d.jpeg",i];
            NSLog(@"- - - -%@",name);
            [array addObject:name];
        }
        _images = array;
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSStringFromClass(self.class);
    _itemW = (kS_W - itemSpace * 2);
    _itemH = 1.1 * _itemW;
    _contentSizeH = (itemSpace + _itemH)*self.images.count +itemSpace;
    [self UI];
}
-(void)UI{
    [self.view addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake(kS_W, _contentSizeH);
    [self layout];
}
-(void)layout{
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self binding];
}
-(void)binding{
    @weakify(self);
    NSMutableArray *array = [NSMutableArray new];
    for (int i = 0; i < self.images.count; i++) {
        NSString *name = self.images[i];
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(itemSpace, 10+i*(_itemH + itemSpace), _itemW, _itemH)];
        imageV.image = [UIImage imageNamed:name];
        imageV.clipsToBounds = YES;
        imageV.layer.cornerRadius = XR_Scale(15);
        imageV.userInteractionEnabled = YES;
        imageV.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
        [tap.rac_gestureSignal subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            @strongify(self);
            NSLog(@"- - %ld",imageV.tag);
            KNPhotoBrowser *photoBrower = [[KNPhotoBrowser alloc] init];
            photoBrower.itemsArr = [self.sourceViews mutableCopy];
            photoBrower.currentIndex = imageV.tag;
            photoBrower.isNeedPageControl = NO;
            photoBrower.isNeedPageNumView = true;
            photoBrower.isNeedRightTopBtn = true;
            photoBrower.isNeedLongPress = true;
            [photoBrower present];
            photoBrower.delegate = self;
            self.photoBrower = photoBrower;
        }];
        [imageV addGestureRecognizer:tap];
        [self.scrollView addSubview:imageV];
        KNPhotoItems *item = [[KNPhotoItems alloc]init];
        item.sourceView = imageV;
        item.sourceImage = imageV.image;
        [array addObject:item];
        
    }
    _sourceViews = array;
    
}
#pragma mark - Delegate
//查看图片滚动后联动源scrollview也跟着变动
- (void)photoBrowser:(KNPhotoBrowser *)photoBrowser scrollToLocateWithIndex:(NSInteger)index{
    [self.scrollView setContentOffset:CGPointMake(0, index * (_itemH + itemSpace)) animated:NO];
}
#pragma mark - LazyLoad
-(UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.contentInset = UIEdgeInsetsZero;
        _scrollView.alwaysBounceHorizontal = NO;
        _scrollView.showsVerticalScrollIndicator = YES;
        _scrollView.backgroundColor = UIColor.whiteColor;
        //_scrollView.bounces = NO;
    }
    return _scrollView;
}
- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [[UIView alloc]init];
    }
    return _containerView;
}

@end
