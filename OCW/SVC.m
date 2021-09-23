//
//  SVC.m
//  OCW
//
//  Created by 朵朵 on 2021/6/28.
//

#import "SVC.h"
#import "T.h"


@interface SVC ()

@property (nonatomic,strong)T *model;

@end

@implementation SVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.orangeColor;
    self.model = T.new;
    @weakify(self);
    [[RACObserve(self.model, array)skip:1] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSLog(@"搞了点事");
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    [btn setTitle:@"搞了点事" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor cyanColor];
    btn.layer.cornerRadius = 10;
    btn.clipsToBounds = YES;
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.mas_equalTo(200);
    }];
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.model.array = NSMutableArray.new;
    }];
    
}
- (void)dealloc
{
    NSLog(@"释放");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
