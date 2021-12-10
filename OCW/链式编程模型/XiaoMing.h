//
//  XiaoMing.h
//  OCW
//
//  Created by 王晓冉 on 2021/11/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//类
@interface People : NSObject
//全局变量 属性
@property(nonatomic,strong)NSString *name;
@property(nonatomic,assign)int age;
//吃饭  实例方法
-(void)eat;
//交房租 类方法
+(void)jfz;
@end

//继承
@interface xiaoHong : People
@end

//分类category
@interface People (work)
-(void)code;
@end

NS_ASSUME_NONNULL_END
