//
//  Target_second.m
//  OCW
//
//  Created by 王晓冉 on 2021/11/10.
//

#import "Target_second.h"
#import "ZJSecondViewController.h"

typedef void (^ZJCallbackBlock)(NSString *info);

@implementation Target_second

- (UIViewController *)Action_nativeFetchSecondViewController:(NSDictionary *)params{
    
    
    ZJSecondViewController *viewController = [[ZJSecondViewController alloc] init];
    //viewController.valueLabel.text = params[@"key"];
    ZJCallbackBlock callBack = params[@"block"];
    viewController.block = ^(NSString * _Nonnull str) {
        callBack(str);
    };
    return viewController;
}
@end
