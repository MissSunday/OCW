//
//  XRPhotoBrowerNav.m
//  OCW
//
//  Created by 朵朵 on 2021/7/29.
//

#import "XRPhotoBrowerNav.h"

@implementation XRPhotoBrowerNav

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
    [self layout];
}
-(void)layout{
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
    }];
}

- (UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"hd_nav_back_white"] forState:UIControlStateNormal];
        [_backBtn setImage:[UIImage imageNamed:@"nav_back_hightLight"] forState:UIControlStateHighlighted];
    }
    return _backBtn;
}


@end
