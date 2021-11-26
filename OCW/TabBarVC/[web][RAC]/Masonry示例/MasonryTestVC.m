//
//  MasonryTestVC.m
//  OCW
//
//  Created by 王晓冉 on 2021/11/23.
//

#import "MasonryTestVC.h"
#import "UIImage+ReColor.h"
@interface MasonryTestVC ()

@property(nonatomic,strong)UIView *someView;

@property(nonatomic,strong)UIImageView *otherView;
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
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:1 animations:^{
            [self.someView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view).offset(300);
            }];
            [self.view layoutIfNeeded];
            
        }];
        
    });
    NSLog(@"hello world !");
    
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
- (UIImageView *)otherView{
    if (!_otherView) {
        _otherView = [[UIImageView alloc]init];
        _otherView.backgroundColor = [UIColor cyanColor];
        _otherView.clipsToBounds = YES;
        _otherView.layer.cornerRadius = 15.f;
        UIImage *img = [UIImage imageNamed:@"directory"];
        _otherView.image = [img reColor:[UIColor orangeColor] size:img.size];

    }
    return _otherView;
}
@end
