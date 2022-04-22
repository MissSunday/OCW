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
//位或(|) ：两个位进行或(|)运算。运算规则：两个运算的位只要有一个为1则运算结果为1，否则为0
//位与(&) ：两个位进行与(&)运算。运算规则：两个运算的位都为1则运算结果为1，否则为0
//位移     位移包含两种：左移(<<) 和 右移(>>)
// << ：将一个数的二进制位向左移动 n 位，高位丢弃，低位补 0。如将数字1(0000 0001)左移两位得到结果为：4(0000 0100)。表述为：1 << 2。
// >> ：将一个数的二进制位向右移动 n 位，低位丢弃，高位补 0。如将数字4(0000 0100)右移两位得到结果为：1(0000 0001)。表述为：4 >> 2。


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
