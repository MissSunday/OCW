//
//  XRPhotoBrower.h
//  OCW
//
//  Created by 朵朵 on 2021/7/28.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XRPhotoBrower : BaseViewController

@property(nonatomic,strong)NSArray <NSString *>*photos; //本地图片

@property(nonatomic,strong)NSArray <NSString *>*photoUrls; //图片url

@property(nonatomic,assign)NSInteger selectIndex; //进入时对应选择的图片 默认0

@end

NS_ASSUME_NONNULL_END
