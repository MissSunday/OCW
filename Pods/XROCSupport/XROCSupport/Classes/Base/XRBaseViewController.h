//
//  XRBaseViewController.h
//  XROCSupport
//
//  Created by ext.wangxiaoran3 on 2022/11/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XRBaseViewController : UIViewController
//子类可以在viewDidLoad里重写这个属性，更改nav的显示和隐藏
@property (nonatomic, assign) BOOL isHidenNav;
@end

NS_ASSUME_NONNULL_END
