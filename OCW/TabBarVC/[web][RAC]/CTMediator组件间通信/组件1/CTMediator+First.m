//
//  CTMediator+First.m
//  OCW
//
//  Created by 王晓冉 on 2021/11/10.
//

#import "CTMediator+First.h"
NSString * const kCTMediatorTargetFirst = @"first";

NSString * const kCTMediatorActionNativeFetchFirstViewController = @"nativeFetchFirstViewController";
@implementation CTMediator (First)
- (UIViewController *)CTMediator_viewControllerForFirst{
    
    UIViewController *viewController = [self performTarget:kCTMediatorTargetFirst
                                                    action:kCTMediatorActionNativeFetchFirstViewController
                                                    params:@{@"title":@"第一个组件"}
                                         shouldCacheTarget:NO
                                        ];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[UIViewController alloc] init];
    }

}
@end
