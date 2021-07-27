//
//  TZImagePickerVC.m
//  OCW
//
//  Created by 朵朵 on 2021/7/27.
//

#import "TZImagePickerVC.h"
#import "TZImagePickerItem.h"
#import "T.h"
#import "TZImagePickerItemModel.h"

#define TZImagePickerVCImageKey @"TZImagePickerVCImageKey"

@interface TZImagePickerVC ()<
UIImagePickerControllerDelegate,
TZImagePickerControllerDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource
>
{
    CGFloat _itemH;
    CGFloat _itemW;
    CGFloat _itemSpace;
}
@property(nonatomic,strong)UIImageView *imageV;

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSMutableArray <TZImagePickerItemModel*>*pictures;
@end

@implementation TZImagePickerVC
- (NSMutableArray<TZImagePickerItemModel *> *)pictures{
    if (!_pictures) {
        _pictures = [self takeLocationData].mutableCopy;
    }
    return _pictures;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSStringFromClass(self.class);
    _itemSpace = XR_SCALE(10);
    _itemW = (kS_W - _itemSpace * 5)/4;
    _itemH = _itemW;
    
    [self UI];
}
-(void)UI{
    [self.view addSubview:self.imageV];
    [self.view addSubview:self.collectionView];
    @weakify(self);
    self.navigationItem.rightBarButtonItem = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"添加" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:(UIControlStateHighlighted)];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [self takePhoto];
        }];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
        item;
    });
    [self layout];
}
-(void)layout{
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.mas_equalTo(kS_W);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self binding];
}
-(void)binding{
    //TODO: ViewModel获取请求数据
    
    //TODO: 绑定ViewModel的属性，坚挺变化，刷新UI
    
}
-(void)takePhoto{
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        // 无相机权限 做一个友好的提示
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"未开权限");
        });
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self takePhoto];
                });
            }
        }];
        // 拍照之前还需要检查相册权限
    } else if ([PHPhotoLibrary authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"未开权限");
        });
    } else if ([PHPhotoLibrary authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self presentImagePicker];
    }
}
/**
 图片选择器 多选
 @author 王晓冉
 @date 2020/05/16
 */
-(void)presentImagePicker{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.isSelectOriginalPhoto = YES;
    //如果需要记录已选的照片,先用本地数组记录,暂时不做
    imagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮
    imagePickerVc.allowTakeVideo = NO;   // 在内部显示拍视频按
    imagePickerVc.cancelBtnTitleStr = @"取消  ";
    imagePickerVc.showPhotoCannotSelectLayer = YES; //不可选择时是否显示蒙版
    imagePickerVc.allowPickingVideo = NO;   //是否可以选视频
    imagePickerVc.allowPickingImage = YES;   //是否可以选图片
    imagePickerVc.allowPickingOriginalPhoto = NO; //是否可以选原图
    imagePickerVc.allowPickingGif = NO;   //是否可以选gif图
    imagePickerVc.allowPickingMultipleVideo = NO; // 是否可以多选视频
    imagePickerVc.sortAscendingByModificationDate = NO; //排序,拍照按钮在上边
    imagePickerVc.showSelectedIndex = YES; // 设置是否显示图片序号
    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent; //状态栏
    // 自定义导航栏上的返回按钮
    [imagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton){
        [leftButton setImage:[UIImage imageNamed:@"hd_nav_back_white"] forState:UIControlStateNormal];
    }];
    // 你可以通过block或者代理，来得到用户选择的照片.
    WS(weakSelf)
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        //这里没有选原图,直接拿image对象了,如果需要原图,可以设置
        NSLog(@"- %@",photos);
        if (photos.count > 0) {
            NSMutableArray *array = [NSMutableArray new];
            for (UIImage *image in photos) {
                TZImagePickerItemModel *model = [[TZImagePickerItemModel alloc]init];
                model.image = image;
                [array addObject:model];
            }
            [weakSelf addImages:array];
        }
    }];
    
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
    
}
/**
 自定义长宽  如果遇到太占内存的图片可以压缩一下
 @param image 原图片
 @param reSize 定义的图片大小
 @return 压缩后的图片
 */
- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize {
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}
#pragma mark - 存取
//查
-(NSArray *)takeLocationData{
    NSData *data = [kUserDefaults objectForKey:TZImagePickerVCImageKey];
    if (data) {
        NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if ([array isKindOfClass:[NSArray class]]) {
            return array;
        }
        return @[];
    }else{
        return @[];
    }
}
//增
-(void)addImages:(NSArray *)array{
    [self.pictures addObjectsFromArray:array];
    [self save];
}
//删
-(void)deleteWithIndex:(NSInteger)index{
    [self.pictures removeObjectAtIndex:index];
    [self save];
}
-(void)deleteWithModle:(TZImagePickerItemModel *)model{
    [self.pictures removeObject:model];
    [self save];
}
//存
-(void)save{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.pictures];
    [kUserDefaults setObject:data forKey:TZImagePickerVCImageKey];
    [kUserDefaults synchronize];
    [self.collectionView reloadData];
}

#pragma mark - Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.pictures.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TZImagePickerItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[TZImagePickerItem description] forIndexPath:indexPath];
    cell.model = self.pictures[indexPath.row];
    @weakify(self);
    [cell.subject subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
        TZImagePickerItemModel *model = x.second;
        [self deleteWithModle:model];
    }];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
    
}
#pragma mark - LazyLoad
- (UIImageView *)imageV{
    if (!_imageV) {
        _imageV = [UIImageView new];
    }
    return _imageV;
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        // 创建FlowLayout
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //设置单元格大小
        flowLayout.itemSize = CGSizeMake(_itemW,_itemH);
        //最小行间距(默认为10)
        flowLayout.minimumLineSpacing = _itemSpace;
        //最小item间距（默认为10）
        flowLayout.minimumInteritemSpacing = _itemSpace;
        //设置senction的内边距
        flowLayout.sectionInset = UIEdgeInsetsMake(_itemSpace, _itemSpace, _itemSpace, _itemSpace);
        //设置UICollectionView的滑动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //sectionHeader的大小,如果是竖向滚动，只需设置Y值。如果是横向，只需设置X值。
        flowLayout.headerReferenceSize = CGSizeMake(0,0);
        // 创建collectionView
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        // 设置代理
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        // 其他属性
        _collectionView.backgroundColor = [UIColor whiteColor];
        // 注册cell
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[TZImagePickerItem class] forCellWithReuseIdentifier:[TZImagePickerItem description]];
        
    }
    return _collectionView;
}

@end
