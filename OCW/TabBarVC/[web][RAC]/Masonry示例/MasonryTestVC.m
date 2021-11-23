//
//  MasonryTestVC.m
//  OCW
//
//  Created by 王晓冉 on 2021/11/23.
//

#import "MasonryTestVC.h"

@interface MasonryTestVC ()

@property(nonatomic,strong)UIView *someView;

@property(nonatomic,strong)UIView *otherView;
@end

@implementation MasonryTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSStringFromClass(self.class);
    
    
    [self.view addSubview:self.someView];
    [self.view addSubview:self.otherView];
    
    [self.someView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(200);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(150);
    }];
    
    [self.otherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.someView.mas_bottom).offset(40);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(150);
    }];
    
    
    
}

- (UIView *)someView{
    if (!_someView) {
        _someView = [[UIView alloc]init];
        _someView.backgroundColor = [UIColor randomColor];
        _someView.clipsToBounds = YES;
        _someView.layer.cornerRadius = 15.f;
    }
    return _someView;
}
- (UIView *)otherView{
    if (!_otherView) {
        _otherView = [[UIView alloc]init];
        _otherView.backgroundColor = [UIColor randomColor];
        _otherView.clipsToBounds = YES;
        _otherView.layer.cornerRadius = 15.f;
    }
    return _otherView;
}
@end
