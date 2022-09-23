//
//  AViewController.h
//  OCW
//
//  Created by 朵朵 on 2021/7/20.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@interface AViewModel : NSObject

@property(nonatomic,assign)CGFloat headHeight;

@property(nonatomic,weak)UIViewController *vc;

@property(nonatomic,assign)NSInteger selectIndex;

@property(nonatomic,readonly,strong)NSArray *btnArray;

@end
@interface AHeadView : UIView

-(instancetype)initWithModel:(AViewModel *)viewModel;

@end
@interface AViewController : BaseViewController

@end

NS_ASSUME_NONNULL_END
