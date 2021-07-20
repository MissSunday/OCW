//
//  RACCell.h
//  OCW
//
//  Created by 朵朵 on 2021/7/6.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN
@class Person;
@interface RACCell : UITableViewCell

@property(nonatomic,strong)RACSubject *btnClickSignal;

@property(nonatomic,strong)Person *model;

@property(nonatomic,weak)UIViewController *vc;
@end

NS_ASSUME_NONNULL_END
