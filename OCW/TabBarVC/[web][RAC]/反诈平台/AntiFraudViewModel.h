//
//  AntiFraudViewModel.h
//  OCW
//
//  Created by ext.wangxiaoran3 on 2023/1/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface AntiFraudDataModel : NSObject

@property(nonatomic,copy)NSString *danwei;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *titleL;
@property(nonatomic,copy)NSString *day;
@property(nonatomic,copy)NSString *week;
@property(nonatomic,copy)NSString *month;
@end

@interface AntiFraudViewModel : NSObject

@property(nonatomic,strong)NSMutableArray <AntiFraudDataModel *>*dataArray;

-(void)loadData;
@end

NS_ASSUME_NONNULL_END
