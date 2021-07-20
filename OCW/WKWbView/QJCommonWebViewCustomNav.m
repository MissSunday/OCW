//
//  QJCommonWebViewCustomNav.m
//  QJLookingForHouseAPP
//
//  Created by admin on 2020/5/25.
//  Copyright © 2020 唐山千家房地产经纪有限公司. All rights reserved.
//

#import "QJCommonWebViewCustomNav.h"
#import <Masonry/Masonry.h>
@implementation QJCommonWebViewCustomNav
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self UI];
    }
    return self;
}
-(void)UI{
    
    [self addSubview:self.backBtn];
    [self addSubview:self.closeBtn];
    [self addSubview:self.titleL];
    [self layout];
}
-(void)layout{
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
    }];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backBtn.mas_right);
        make.bottom.equalTo(self);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
    }];
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.backBtn);
    }];
}

- (UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"login_back_img"] forState:UIControlStateNormal];
        [_backBtn setImage:[UIImage imageNamed:@"nav_back_hightLight"] forState:UIControlStateHighlighted];
    }
    return _backBtn;
}
- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
       [_closeBtn setImage:[UIImage imageNamed:@"home_esc_img"] forState:UIControlStateNormal];
        _closeBtn.hidden = YES;
    }
    return _closeBtn;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [[UILabel alloc]init];
        _titleL.numberOfLines = 1;
        _titleL.textAlignment = NSTextAlignmentCenter;
        _titleL.font = [UIFont boldSystemFontOfSize:17];
        _titleL.textColor = [UIColor blackColor];
    }
    return _titleL;
}

@end
