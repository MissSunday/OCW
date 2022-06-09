//
//  CTMediator+Second.h
//  OCW
//
//  Created by 王晓冉 on 2021/11/10.
//

#import <CTMediator/CTMediator.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^secondBlock)(NSString *str);

@interface CTMediator (Second)

- (UIViewController *)CTMediator_viewControllerForSecondWithBlock:(secondBlock)block;

@end

NS_ASSUME_NONNULL_END
