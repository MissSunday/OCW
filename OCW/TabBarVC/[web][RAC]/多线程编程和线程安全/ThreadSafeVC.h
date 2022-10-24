//
//  ThreadSafeVC.h
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/1/21.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ThreadModel : NSObject

-(void)addData;

-(void)removeData;

@end

@interface ThreadSafeVC : BaseViewController

@end

NS_ASSUME_NONNULL_END
