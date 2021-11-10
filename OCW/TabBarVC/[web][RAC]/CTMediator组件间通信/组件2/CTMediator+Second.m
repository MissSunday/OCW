//
//  CTMediator+Second.m
//  OCW
//
//  Created by 王晓冉 on 2021/11/10.
//

#import "CTMediator+Second.h"
NSString * const kCTMediatorTargetSecond = @"second";
NSString * const kCTMediatorActionNativeFetchSecondViewController = @"nativeFetchSecondViewController";
@implementation CTMediator (Second)

- (UIViewController *)CTMediator_viewControllerForSecondWithBlock:(secondBlock)block{
    
    UIViewController *viewController = [self performTarget:kCTMediatorTargetSecond
                                                    action:kCTMediatorActionNativeFetchSecondViewController
                                                    params:@{@"block":block}
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
