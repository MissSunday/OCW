//
//  Target_first.m
//  OCW
//
//  Created by 王晓冉 on 2021/11/10.
//

#import "Target_first.h"
#import "ZJFirstViewController.h"
@implementation Target_first
- (UIViewController *)Action_nativeFetchFirstViewController:(NSDictionary *)params{
    // 因为action是从属于ModuleA的，所以action直接可以使用ModuleA里的所有声明
    ZJFirstViewController *viewController = [[ZJFirstViewController alloc] init];
    viewController.navigationItem.title = params[@"title"];
    return viewController;

}
@end
