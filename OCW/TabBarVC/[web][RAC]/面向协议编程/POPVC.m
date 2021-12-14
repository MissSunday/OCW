//
//  POPVC.m
//  OCW
//
//  Created by 王晓冉 on 2021/12/13.
//

#import "POPVC.h"
#import "XRRequest.h"
#import "XRRequestParam.h"
@interface POPVC ()

@end

@implementation POPVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    XRRequestParam *param = [XRRequestParam postWithParam:@{@"token":@"gk"} url:@"666"];
    [[XRRequest shareManager]requestWithParam:param complete:^(NSDictionary * _Nonnull response) {
        NSLog(@"%@",response);
        } failed:^(NSDictionary * _Nonnull error) {
            NSLog(@"%@", error);
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
