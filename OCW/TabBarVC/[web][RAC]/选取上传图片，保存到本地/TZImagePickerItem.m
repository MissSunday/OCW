//
//  TZImagePickerItem.m
//  OCW
//
//  Created by 朵朵 on 2021/7/27.
//

#import "TZImagePickerItem.h"
#import "TZImagePickerItemModel.h"

@implementation TZImagePickerItem
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self UI];
    }
    return self;
}
-(void)UI{
    self.contentView.backgroundColor = [UIColor randomColor];
    [self.contentView addSubview:self.imageV];
    [self.contentView addSubview:self.deleteBtn];
    [self layout];
}
-(void)layout{
    
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(XR_SCALE(20));
        make.top.equalTo(self.contentView).offset(XR_SCALE(-10));
        make.right.equalTo(self.contentView).offset(XR_SCALE(10));
    }];
    @weakify(self);
    [[self.deleteBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        //发送信号 在需要的地方接收信号 可替代代理 这里传参可以进行包装 比如model 比如RACTuple
        RACTuple *tuple = [RACTuple tupleWithObjects:self,self.model, nil];
        
        [self.subject sendNext:tuple];
    }];
}
- (void)setModel:(TZImagePickerItemModel *)model{
    _model = model;
    _imageV.image = model.image;
}
- (UIImageView *)imageV{
    if (!_imageV) {
        _imageV = [UIImageView new];
    }
    return _imageV;
}
- (UIButton *)deleteBtn{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setBackgroundImage:[UIImage imageNamed:@"icon_delete"] forState:UIControlStateNormal];
    }
    return _deleteBtn;
}
- (RACSubject *)subject{
    if (!_subject) {
        _subject = [RACSubject subject];
    }
    return _subject;
}
@end
