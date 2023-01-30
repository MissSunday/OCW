//
//  AntiFraudDataCell.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2023/1/11.
//

#import "AntiFraudDataCell.h"
#import "AntiFraudViewModel.h"
@interface XRLabel : UIView

@property(nonatomic,strong)UILabel *leftL;

@property(nonatomic,strong)UILabel *rightL;

@end

@implementation XRLabel
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self UI];
    }
    return self;
}
-(void)UI{
    
    [self addSubview:self.leftL];
    [self addSubview:self.rightL];
    [self.leftL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(10);
    }];
    [self.rightL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-10);
    }];
}
- (UILabel *)leftL{
    if (!_leftL) {
        _leftL = [UILabel new];
        _leftL.font = [UIFont systemFontOfSize:18];
        _leftL.textColor = [UIColor color66];
        _leftL.text = @"";
    }
    return _leftL;
}
- (UILabel *)rightL{
    if (!_rightL) {
        _rightL = [UILabel new];
        _rightL.font = [UIFont boldSystemFontOfSize:18];
        _rightL.textColor = [UIColor color62];
        _rightL.text = @"";
        _rightL.textAlignment = NSTextAlignmentRight;
    }
    return _rightL;
}
@end

@interface AntiFraudDataCell ()

@property(nonatomic,strong)UIView *containerView;
@property(nonatomic,strong)XRLabel *titleView;
@property(nonatomic,strong)XRLabel *dayView;
@property(nonatomic,strong)XRLabel *weekView;
@property(nonatomic,strong)XRLabel *monthView;
@end

@implementation AntiFraudDataCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self UI];
    }
    return self;
}
-(void)UI{
    
    [self.contentView addSubview:self.containerView];
    [self.containerView addSubview:self.titleView];
    [self.containerView addSubview:self.dayView];
    [self.containerView addSubview:self.weekView];
    [self.containerView addSubview:self.monthView];
    [self layout];
}
-(void)layout{
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    [self.monthView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).offset(15);
        make.right.equalTo(self.containerView).offset(-15);
        make.bottom.equalTo(self.containerView.mas_bottom).offset(-10);
        make.height.mas_equalTo(60);
    }];
   
    [self.weekView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.monthView);
        make.bottom.equalTo(self.monthView.mas_top).offset(-10);
        make.height.mas_equalTo(60);
    }];
    [self.dayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.monthView);
        make.bottom.equalTo(self.weekView.mas_top).offset(-10);
        make.height.mas_equalTo(60);
    }];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.monthView);
        make.bottom.equalTo(self.dayView.mas_top).offset(-10);
        make.height.mas_equalTo(60);
    }];
}
- (void)setModel:(AntiFraudDataModel *)model{
    _model = model;
    self.dayView.leftL.text = @"今日";
    self.weekView.leftL.text = @"本周";
    self.monthView.leftL.text = @"本月";
    
    self.dayView.rightL.text = [NSString stringWithFormat:@"%@%@",model.day,model.danwei];
    self.weekView.rightL.text = [NSString stringWithFormat:@"%@%@",model.week,model.danwei];
    self.monthView.rightL.text = [NSString stringWithFormat:@"%@%@",model.month,model.danwei];
    
    self.titleView.leftL.text = model.title;
    self.titleView.rightL.text = [NSString stringWithFormat:@"%@%@",model.titleL,model.danwei];
}
- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.backgroundColor = [UIColor whiteColor];
    }
    return _containerView;
}
- (XRLabel *)dayView{
    if (!_dayView) {
        _dayView = [[XRLabel alloc]init];
    }
    return _dayView;
}
- (XRLabel *)weekView{
    if (!_weekView) {
        _weekView = [[XRLabel alloc]init];
    }
    return _weekView;
}
- (XRLabel *)monthView{
    if (!_monthView) {
        _monthView = [[XRLabel alloc]init];
    }
    return _monthView;
}
- (XRLabel *)titleView{
    if (!_titleView) {
        _titleView = [[XRLabel alloc]init];
        _titleView.leftL.textColor = [UIColor color62];
        _titleView.leftL.font = [UIFont boldSystemFontOfSize:18];
        
        _titleView.rightL.textColor = [UIColor blueColor];
        _titleView.rightL.font = [UIFont boldSystemFontOfSize:18];
        _titleView.backgroundColor = [UIColor whiteColor];
    }
    return _titleView;
}
@end
