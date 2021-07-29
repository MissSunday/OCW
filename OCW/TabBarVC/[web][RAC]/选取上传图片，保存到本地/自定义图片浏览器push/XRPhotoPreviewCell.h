//
//  XRPhotoPreviewCell.h
//  QJLookingForHouseAPP
//
//  Created by admin on 2020/6/6.
//  Copyright © 2020 唐山千家房地产经纪有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class XRPhotoPreviewView;
@interface XRPhotoPreviewCell : UICollectionViewCell

@property(nonatomic,strong)XRPhotoPreviewView *previewView;

@property(nonatomic,copy)NSString *imageName;

@property(nonatomic,copy)NSString *imageUrl;

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,strong)RACSubject *subject;

- (void)recoverSubviews;
@end


typedef void(^tapBlock)(void);
//这个比较重要  可以拿出来通用
@interface XRPhotoPreviewView : UIView
@property(nonatomic,strong)UIImageView  *imageView;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIView       *imageContainerView;
@property(nonatomic,copy)tapBlock       tapBlock;
@property(nonatomic,copy)NSString       *imageName;
@property(nonatomic,copy)NSString       *imageUrl;
@property(nonatomic,strong)UIImage      *image;

- (void)recoverSubviews;
@end










NS_ASSUME_NONNULL_END
