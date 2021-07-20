//
//  RACKeyWordUseVC.m
//  OCW
//
//  Created by 朵朵 on 2021/7/20.
//

#import "RACKeyWordUseVC.h"

@interface RACKeyWordUseVC ()
@property(nonatomic,strong)UITextField *tf;


@end

@implementation RACKeyWordUseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self UI];
}
-(void)UI{
    [self.view addSubview:self.tf];
    
    [self layout];
}
-(void)layout{
    [self.tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(50);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(50);
    }];
    
    [self binding];
}
-(void)binding{
    
    // !!!: 关键字
    // !!!: filter 过滤
    // !!!: map 映射
    @weakify(self);
    [[[self.tf.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        BOOL a = value.length > 3;
        BOOL b = value.length < 12;
        BOOL c = a && b;
        return c;
    }] map:^id _Nullable(NSString * _Nullable value) {
        
        NSString *result = [NSString stringWithFormat:@"%@-aaa",value];
        return result;
    }]subscribeNext:^(id  _Nullable x) {
        NSLog(@"执行后的结果 = %@",x);
    }];
    
    
}
#pragma mark - Delegate

#pragma mark - LazyLoad
- (UITextField *)tf{
    if (!_tf) {
        _tf = [[UITextField alloc]init];
        _tf.placeholder = @"请输入";
        _tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _tf.textColor = [UIColor color63];
        _tf.font = [UIFont systemFontOfSize:15];
        _tf.borderStyle = UITextBorderStyleBezel;
        _tf.backgroundColor = [UIColor cyanColor];
    }
    return _tf;
}
@end
