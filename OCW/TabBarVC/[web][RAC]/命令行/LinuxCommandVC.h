//
//  LinuxCommandVC.h
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/8/23.
//


#import "BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface commandModel : NSObject

@property(nonatomic,copy)NSString *command;

@property(nonatomic,copy)NSString *des;

@end

@interface commandCellModel : NSObject

@property(nonatomic,strong)NSString *title;

@property(nonatomic,strong)NSArray <commandModel *>*content;

@property(nonatomic,strong)YYTextLayout *textLayout;

@property(nonatomic,assign)CGFloat cellHeight;

@end

@interface GitCommandViewModel : NSObject

@property(nonatomic,strong)NSMutableArray <commandCellModel *>*modelArray;

-(void)updateDataArray:(NSArray *)dataArray;

@end

@interface GitCommandCell : UITableViewCell

@property(nonatomic,strong)commandCellModel *model;

@end

@interface LinuxCommandVC : BaseViewController

-(void)updateDataArray:(NSArray *)dataArray;

@end

NS_ASSUME_NONNULL_END
