//
//  BTViewController.m
//  OCW
//
//  Created by 朵朵 on 2021/7/21.
//

#import "BTViewController.h"
#import "SVC.h"
@interface BTViewController ()

@end

@implementation BTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor randomColor];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"- %@",self.navigationController);
    //2021-07-21 10:59:13.449653+0800 OCW[42784:4520781] - <BaseNavigationController: 0x15b85e200>
    [self.navigationController pushViewController:SVC.new animated:YES];
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
