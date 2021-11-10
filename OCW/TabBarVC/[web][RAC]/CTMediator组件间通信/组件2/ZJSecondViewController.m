//
//  ZJSecondViewController.m
//  OCW
//
//  Created by 王晓冉 on 2021/11/10.
//

#import "ZJSecondViewController.h"

@interface ZJSecondViewController ()

@end

@implementation ZJSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //模拟回调 比如这个页面做完了某事,要告诉上一个页面
    if (self.block) {
        self.block(@"可以是字符串 也可以是字典等数据类型");
    }
}


@end
