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

@property (nonatomic, strong) XRPhotoPreviewView *previewView;

@property(nonatomic,copy)NSString *image;

@property (nonatomic, strong)NSString *imageUrl;

- (void)recoverSubviews;
@end


//这个比较重要  可以拿出来通用
@interface XRPhotoPreviewView : UIView
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *imageContainerView;

@property(nonatomic,copy)NSString *image;
@property (nonatomic, strong)NSString *imageUrl;


- (void)recoverSubviews;
@end










NS_ASSUME_NONNULL_END
