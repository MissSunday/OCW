//
//  GitCommandVC.h
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/8/22.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN


@interface gitModel : NSObject

@property(nonatomic,copy)NSString *command;

@property(nonatomic,copy)NSString *des;

@end

@interface gitCellModel : NSObject

@property(nonatomic,strong)NSString *title;

@property(nonatomic,strong)NSArray <gitModel *>*content;

@property(nonatomic,strong)YYTextLayout *textLayout;

@property(nonatomic,assign)CGFloat cellHeight;
@end

@interface GitCommandViewModel : NSObject

@property(nonatomic,strong)NSMutableArray <gitCellModel *>*modelArray;

@end


@interface GitCommandCell : UITableViewCell

@property(nonatomic,strong)gitCellModel *model;

@end

@interface GitCommandVC : BaseViewController



@end

NS_ASSUME_NONNULL_END
