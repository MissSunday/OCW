//
//  AntiFraudHeadView.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2023/1/11.
//

#import "AntiFraudHeadView.h"


@interface AntiFraudHeadView ()

@property(nonatomic,strong)UIImageView *bgImage;

@property(nonatomic,strong)UILabel *titleL;

@property(nonatomic,strong)UIView *searchBg;

@property(nonatomic,strong)UIButton *searchBtn;

@property(nonatomic,strong)UIImageView *searchIcon;

@property(nonatomic,strong)UITextField *searchField;
@end

@implementation AntiFraudHeadView
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor randomColor];
        [self UI];
    }
    return self;
}
-(void)UI{
    [self addSubview:self.bgImage];
    [self addSubview:self.titleL];
    [self addSubview:self.searchBg];
    [self.searchBg addSubview:self.searchBtn];
    [self.searchBg addSubview:self.searchIcon];
    [self.searchBg addSubview:self.searchField];
    [self layout];
}
-(void)layout{
    
    [self.bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(15);
    }];
    [self.searchBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.titleL.mas_bottom).offset(15);
        make.width.mas_equalTo(kS_W - 60);
        make.height.mas_equalTo(45);
    }];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.searchBg).offset(-8);
        make.centerY.equalTo(self.searchBg);
        make.width.mas_equalTo(62);
        make.height.mas_equalTo(31);
    }];
    [self.searchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchBg).offset(8);
        make.centerY.equalTo(self.searchBg);
        make.width.height.mas_equalTo(25);
    }];
    [self.searchField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchIcon.mas_right).offset(1);
        make.top.bottom.equalTo(self.searchBg);
        make.right.equalTo(self.searchBtn.mas_left).offset(-5);
    }];
}
- (UIImageView *)bgImage{
    if (!_bgImage) {
        _bgImage = [[UIImageView alloc]init];
        _bgImage.backgroundColor = [UIColor whiteColor];
        _bgImage.image = [UIImage imageNamed:@"afi_01"];
    }
    return _bgImage;
}
- (UIImageView *)searchIcon{
    if (!_searchIcon) {
        _searchIcon = [[UIImageView alloc]init];
        _searchIcon.backgroundColor = [UIColor whiteColor];
        _searchIcon.image = [UIImage imageNamed:@"afi_02"];
    }
    return _searchIcon;
}
- (UILabel *)titleL{
    if (!_titleL) {
        _titleL = [UILabel new];
        _titleL.font = [UIFont boldSystemFontOfSize:20];
        _titleL.textColor = [UIColor color62];
        _titleL.text = @"智能反诈平台";
    }
    return _titleL;
}
- (UIView *)searchBg{
    if (!_searchBg) {
        _searchBg = [UIView new];
        _searchBg.backgroundColor = [UIColor whiteColor];
        _searchBg.clipsToBounds = YES;
        _searchBg.layer.cornerRadius = 2.f;
    }
    return _searchBg;
}
- (UIButton *)searchBtn{
    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //_searchBtn.backgroundColor = [UIColor blueColor];
        [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
        [_searchBtn setBackgroundImage:[UIImage imageWithColor:[UIColor blueColor]] forState:UIControlStateNormal];
        [_searchBtn setBackgroundImage:[UIImage imageWithColor:[[UIColor blueColor] colorWithAlphaComponent:0.3]] forState:UIControlStateHighlighted];
        [_searchBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _searchBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _searchBtn.clipsToBounds = YES;
        _searchBtn.layer.cornerRadius = 3.f;
        
    }
    return _searchBtn;
}
- (UITextField *)searchField{
    if (!_searchField) {
        _searchField = [[UITextField alloc]init];
        _searchField.placeholder = @"请输入检索内容";
        _searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchField.textColor = [UIColor color63];
        _searchField.font = [UIFont systemFontOfSize:13];
        _searchField.borderStyle = UITextBorderStyleNone;
        _searchField.backgroundColor = [UIColor whiteColor];
    }
    return _searchField;
}

@end
