//
//  AViewController.m
//  OCW
//
//  Created by 朵朵 on 2021/7/20.
//

#import "AViewController.h"
#import "QJCommonWebViewController.h"
#import "RACVC.h"
@interface AViewController ()

@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"A";
    [self UI];
    [self nav];
}


































-(void)UI{
 
    [self layout];
}
-(void)layout{
    
    
}
-(void)nav{
    @weakify(self);
    self.navigationItem.rightBarButtonItem = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"RAC" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:(UIControlStateHighlighted)];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [self.navigationController pushViewController:RACVC.new animated:YES];
        }];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
        item;
    });
    self.navigationItem.leftBarButtonItem = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"WEB" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:(UIControlStateHighlighted)];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            QJCommonWebViewController *vc = [QJCommonWebViewController new];
            vc.url = @"https://www.jianshu.com/u/f8b0e5cce3ab";
            [self.navigationController pushViewController:vc animated:YES];
        }];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
        item;
    });
    
}


@end
