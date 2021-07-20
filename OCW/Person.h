//
//  Person.h
//  OCW
//
//  Created by 朵朵 on 2021/5/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NSObject *_Nullable(^blockName)(int a);

@interface Person : NSObject

@property(nonatomic,strong)NSString *title;

@property(nonatomic,assign)int num;

-(void)run;

-(Person *(^)(int a))add;

-(blockName)reduce;

-(Person *(^)(int a ,int b))chi;


@end

NS_ASSUME_NONNULL_END
