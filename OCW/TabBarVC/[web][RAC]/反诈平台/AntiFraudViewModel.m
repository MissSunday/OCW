//
//  AntiFraudViewModel.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2023/1/11.
//

#import "AntiFraudViewModel.h"

@implementation AntiFraudDataModel

@end

@interface AntiFraudViewModel ()
@property(nonatomic,strong)NSArray *AntiFraudDataList;
@end

@implementation AntiFraudViewModel
- (NSMutableArray<AntiFraudDataModel *> *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.AntiFraudDataList = @[
            @{
                @"danwei":@"人",
                @"title":@"劝阻PIN数量",
                @"titleL":@"406152",
                @"day":@"4082",
                @"week":@"32134",
                @"month":@"96113",
            },
            @{@"danwei":@"次",
              @"title":@"劝阻次数数量",
              @"titleL":@"577317",
              @"day":@"4870",
              @"week":@"40406",
              @"month":@"125102",
              
            },
            @{@"danwei":@"元",
              @"title":@"劝阻金额量",
              @"titleL":@"6,399,203,769.00",
              @"day":@"54,115,130.00",
              @"week":@"436,814,014.00",
              @"month":@"1,358,885,172.00",
              
            },
            @{@"danwei":@"条",
              @"title":@"客诉数量",
              @"titleL":@"781556",
              @"day":@"1340",
              @"week":@"9293",
              @"month":@"29910",
              
            },
            @{@"danwei":@"元",
              @"title":@"资损金额量",
              @"titleL":@"865,008,105.93",
              @"day":@"205,995.00",
              @"week":@"5,549,530.66",
              @"month":@"23,887,322.01",
              
            },
        ];
        
    }
    return self;
}

-(void)loadData{
    
    NSMutableArray *dataArray = [NSMutableArray new];
    
    for (NSDictionary *temp in self.AntiFraudDataList) {
        
        AntiFraudDataModel *model = [AntiFraudDataModel yy_modelWithDictionary:temp];
        
        [dataArray addObject:model];
    }
    self.dataArray = dataArray;
}

@end
