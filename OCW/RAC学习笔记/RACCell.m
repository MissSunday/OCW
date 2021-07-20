//
//  RACCell.m
//  OCW
//
//  Created by 朵朵 on 2021/7/6.
//

#import "RACCell.h"
#import "Person.h"
#import <Masonry/Masonry.h>
@interface RACCell ()

@property(nonatomic,strong)UILabel *descL;

@property(nonatomic,strong)UIButton *communicateBtn;
@end

@implementation RACCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.clipsToBounds = YES;
        [self UI];
    }
    return self;
}
-(void)UI{
    
    
    [self.contentView addSubview:self.descL];
    [self.contentView addSubview:self.communicateBtn];
    
    
    [self layout];
}
-(void)layout{
    
    [self.descL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.centerY.equalTo(self.contentView);
    }];
    [self.communicateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(40);
    }];
    
    
    
    [self binding];
}
-(void)binding{
    @weakify(self);
    [[self.communicateBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        //发送信号 在需要的地方接收信号 可替代代理 这里传参可以进行包装 比如model 比如RACTuple
        RACTuple *tuple = [RACTuple tupleWithObjects:self,self.model, nil];
        
        [self.btnClickSignal sendNext:tuple];
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"是否从列表中移除？"
                                                                       message:@""
                                                                preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault
                                                              handler:nil];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
            //响应事件
            NSLog(@"action = %@", action);

        }];
        [alert addAction:defaultAction];
        [alert addAction:cancelAction];
        [self.vc presentViewController:alert animated:YES completion:nil];
        
        
    }];
    
}
//- (UIViewController *)viewController{
//    for (UIView* next = self; next; next = next.superview) {
//        UIResponder* nextResponder = [next nextResponder];
//        if ([nextResponder isKindOfClass:[UIViewController class]]) {
//            return (UIViewController*)nextResponder;
//        }
//    }
//    return nil;
//}
- (void)setModel:(Person *)model{
    _model = model;
    _descL.text = model.title;
}
- (RACSubject *)btnClickSignal{
    if (!_btnClickSignal) {
        _btnClickSignal = [RACSubject subject];
    }
    return _btnClickSignal;
}
- (UILabel *)descL{
    if (!_descL) {
        _descL = [[UILabel alloc]init];
        _descL.textColor = [UIColor blackColor];
        _descL.font = [UIFont systemFontOfSize:17];
    }
    return _descL;
}
- (UIButton *)communicateBtn{
    if (!_communicateBtn) {
        _communicateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _communicateBtn.backgroundColor = [UIColor orangeColor];
        [_communicateBtn setTitle:@"rac代理" forState:UIControlStateNormal];
        [_communicateBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _communicateBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _communicateBtn;
}





@end
