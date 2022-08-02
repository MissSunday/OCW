//
//  XRPerson.h
//  XRSDK
//
//  Created by ext.wangxiaoran3 on 2022/7/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XRPerson : NSObject

//第一种形式  alloc init形式

//变量1 oc对象

@property(nonatomic,copy)NSString *name;

//变量2 bool类型
@property(nonatomic,assign)BOOL sex;

@end




@interface TYPerson : NSObject

//第二种形式  单利形式

+(instancetype)manager;


-(void)updateName:(NSString *)neName;

-(void)updateSEX:(BOOL)neSEX;

-(void)updateAgree:(BOOL)is;

//变量1 oc对象

@property(nonatomic,copy)NSString *name;

//变量2 bool类型
@property(nonatomic,assign)BOOL sex;

//变量3 bool类型 仿照问题的写法
@property(nonatomic,assign,readonly)BOOL isAgree;



@end
NS_ASSUME_NONNULL_END
