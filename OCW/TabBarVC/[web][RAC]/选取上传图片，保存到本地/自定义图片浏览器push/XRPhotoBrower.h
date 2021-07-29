//
//  XRPhotoBrower.h
//  OCW
//
//  Created by 朵朵 on 2021/7/28.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XRPhotoBrower : BaseViewController

@property(nonatomic,strong)NSArray <NSString *>*photoUrls; //图片url 优先级最高

@property(nonatomic,strong)NSArray <UIImage *>*photos; //本地图片 优先级第二

@property(nonatomic,strong)NSArray <NSString *>*photoNames; //本地图片名字 优先级第三

@property(nonatomic,assign)NSInteger selectIndex; //进入时对应选择的图片 默认0

@property(nonatomic,assign)BOOL showNav;

@end

NS_ASSUME_NONNULL_END
