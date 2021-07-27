//
//  CViewController.m
//  OCW
//
//  Created by 朵朵 on 2021/7/20.
//

#import "CViewController.h"

@interface CViewController ()

@end

@implementation CViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"C";
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    NSDictionary *dic = @{@"accountId":@"101010010000002",
                          @"password": @"14BD12E5143B7D2812C361993CAA0EE2"};
    
    [XRNetRequest postWithUrl:@"https://houseagent.91hilife.com/hshxf/app/login/passwordLogin" header:dic body:@{} success:^(id  _Nullable data, BOOL isCanUse) {
        
    } failure:^(NSError * _Nonnull error, BOOL haveNet) {
        
    }];
    
    
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
