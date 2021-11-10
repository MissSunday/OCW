//
//  ZJSecondViewController.h
//  OCW
//
//  Created by 王晓冉 on 2021/11/10.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^zjsBlock)(NSString *str);
@interface ZJSecondViewController : BaseViewController

@property(nonatomic,copy)zjsBlock block;
@end

NS_ASSUME_NONNULL_END
