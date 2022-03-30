//
//  DataTypeVC.h
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/3/30.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN


//位运算枚举类型
typedef NS_OPTIONS(NSUInteger, MyOption) {
  MyOptionNone = 0, //二进制0000,十进制0
  MyOption1 = 1 << 0,//0001,1
  MyOption2 = 1 << 1,//0010,2
  MyOption3 = 1 << 2,//0100,4
  MyOption4 = 1 << 3,//1000,8
};

//枚举
typedef NS_ENUM(NSUInteger, enumType) {
    enumTypeA,
    enumTypeB,
    enumTypeC,
};

@interface DataTypeVC : BaseViewController

@property(nonatomic,assign)MyOption myOption;

@property(nonatomic,assign)enumType enumType;

@end

NS_ASSUME_NONNULL_END
