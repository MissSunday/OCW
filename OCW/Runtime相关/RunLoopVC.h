//
//  RunLoopVC.h
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/3/23.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RunLoopVC : BaseViewController


/*
 和线程之间的关系
 1、RunLoop保存在一个全局的Dictionary里面，线程为key，RunLoop为value。
 2、线程刚创建的时候是没有RunLoop对象的，RunLoop会在第一次获取它的时候创建。
 3、RunLoop会在线程结束的时候销毁。
 4、主线程的RunLoop已经自动获取（创建），子线程默认没有开启RunLoop。
 5、每条线程都有唯一的一个与之对应的RunLoop对象。
 6、先有线程，再有RunLoop。
 
 */




@end

NS_ASSUME_NONNULL_END
