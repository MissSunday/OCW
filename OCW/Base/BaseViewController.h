//
//  BaseViewController.h
//  OCW
//
//  Created by 朵朵 on 2021/7/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
//子类可以在viewDidLoad里重写这个属性，更改nav的显示和隐藏
@property (nonatomic, assign) BOOL isHidenNav;

@end

NS_ASSUME_NONNULL_END
