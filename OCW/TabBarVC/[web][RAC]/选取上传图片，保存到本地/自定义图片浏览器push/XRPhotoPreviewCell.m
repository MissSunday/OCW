//
//  XRPhotoPreviewCell.m
//  QJLookingForHouseAPP
//
//  Created by admin on 2020/6/6.
//  Copyright © 2020 唐山千家房地产经纪有限公司. All rights reserved.
//

#import "XRPhotoPreviewCell.h"

@implementation XRPhotoPreviewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self configSubviews];
    }
    return self;
}

- (void)configSubviews {
    self.previewView = [[XRPhotoPreviewView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.previewView];
}
- (void)recoverSubviews {
    [_previewView recoverSubviews];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.previewView.frame = self.bounds;
}
- (void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
    
}
- (void)setImage:(NSString *)image{
    _image = image;
    self.previewView.image = image;
}
@end

@interface XRPhotoPreviewView ()<UIScrollViewDelegate>

@end

@implementation XRPhotoPreviewView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.bouncesZoom = YES;
        _scrollView.maximumZoomScale = 2.5;
        _scrollView.minimumZoomScale = 1.0;
        _scrollView.multipleTouchEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.scrollsToTop = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = YES;
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _scrollView.delaysContentTouches = NO;
        _scrollView.canCancelContentTouches = YES;
        _scrollView.alwaysBounceVertical = NO;
        if (@available(iOS 11, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [self addSubview:_scrollView];
        
        _imageContainerView = [[UIView alloc] init];
        _imageContainerView.clipsToBounds = YES;
        _imageContainerView.contentMode = UIViewContentModeScaleAspectFill;
        [_scrollView addSubview:_imageContainerView];
        
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.500];
        _imageView.backgroundColor = [UIColor blackColor];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.clipsToBounds = YES;
        [_imageContainerView addSubview:_imageView];
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        [self addGestureRecognizer:tap1];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
        tap2.numberOfTapsRequired = 2;
        [tap1 requireGestureRecognizerToFail:tap2];
        [self addGestureRecognizer:tap2];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _scrollView.frame = CGRectMake(10, 0, self.width - 20, self.height);
    [self recoverSubviews];
}
- (void)recoverSubviews {
    [_scrollView setZoomScale:_scrollView.minimumZoomScale animated:NO];
    [self resizeSubviews];
}
- (void)resizeSubviews {
    _imageContainerView.origin = CGPointZero;
    _imageContainerView.width = self.scrollView.width;
    _imageContainerView.height = 0.75 * self.scrollView.width;
    _imageContainerView.centerY = self.height / 2;
    
    UIImage *image = _imageView.image;
    if (image.size.height / image.size.width > self.height / self.scrollView.width) {
        _imageContainerView.height = floor(image.size.height / (image.size.width / self.scrollView.width));
    } else {
        CGFloat height = image.size.height / image.size.width * self.scrollView.width;
        if (height < 1 || isnan(height)) height = self.height;
        height = floor(height);
        _imageContainerView.height = height;
        _imageContainerView.centerY = self.height / 2;
    }
    if (_imageContainerView.height > self.height && _imageContainerView.height - self.height <= 1) {
        _imageContainerView.height = self.height;
    }
    CGFloat contentSizeH = MAX(_imageContainerView.height, self.height);
    _scrollView.contentSize = CGSizeMake(self.scrollView.width, contentSizeH);
    _scrollView.alwaysBounceVertical = _imageContainerView.height <= self.height ? NO : YES;
    [_scrollView scrollRectToVisible:self.bounds animated:NO];
    _imageView.frame = _imageContainerView.bounds;
    
    
}
- (void)configMaximumZoomScale {
    _scrollView.maximumZoomScale = 2.5;
}
- (void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
    [_scrollView setZoomScale:1.0 animated:NO];
    [self.imageView yy_setImageWithURL:[NSURL URLWithString:imageUrl] placeholder:[UIImage imageWithColor:[UIColor colorWithHexString:@"F5F5F5"]] options:(YYWebImageOptionSetImageWithFadeAnimation) completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        [self resizeSubviews];
    }];
    [self configMaximumZoomScale];
}
- (void)setImage:(NSString *)image{
    _image = image;
    self.imageView.image = [UIImage imageNamed:image];
    [_scrollView setZoomScale:1.0 animated:NO];
    [self resizeSubviews];
    [self configMaximumZoomScale];
}
#pragma mark - UITapGestureRecognizer Event

- (void)doubleTap:(UITapGestureRecognizer *)tap {
    if (_scrollView.zoomScale > _scrollView.minimumZoomScale) {
        _scrollView.contentInset = UIEdgeInsetsZero;
        [_scrollView setZoomScale:_scrollView.minimumZoomScale animated:YES];
    } else {
        CGPoint touchPoint = [tap locationInView:self.imageView];
        CGFloat newZoomScale = _scrollView.maximumZoomScale;
        CGFloat xsize = self.frame.size.width / newZoomScale;
        CGFloat ysize = self.frame.size.height / newZoomScale;
        [_scrollView zoomToRect:CGRectMake(touchPoint.x - xsize/2, touchPoint.y - ysize/2, xsize, ysize) animated:YES];
        
    }
}

- (void)singleTap:(UITapGestureRecognizer *)tap {
}
#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageContainerView;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    scrollView.contentInset = UIEdgeInsetsZero;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self refreshImageContainerViewCenter];
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    //[self refreshScrollViewContentSize];
}

#pragma mark - Private

- (void)refreshImageContainerViewCenter {
    CGFloat offsetX = (_scrollView.width > _scrollView.contentSize.width) ? ((_scrollView.width - _scrollView.contentSize.width) * 0.5) : 0.0;
    CGFloat offsetY = (_scrollView.height > _scrollView.contentSize.height) ? ((_scrollView.height - _scrollView.contentSize.height) * 0.5) : 0.0;
    self.imageContainerView.center = CGPointMake(_scrollView.contentSize.width * 0.5 + offsetX, _scrollView.contentSize.height * 0.5 + offsetY);
}

@end
