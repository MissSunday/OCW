//
//  RACKeyWordUseVC.h
//  OCW
//
//  Created by 朵朵 on 2021/7/20.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RACKeyWordUseVC : BaseViewController
/*
 
 flattenMap map 用于把源信号内容映射成新的内容。

 concat 组合 按一定顺序拼接信号，当多个信号发出的时候，有顺序的接收信号

 then 用于连接两个信号，当第一个信号完成，才会连接then返回的信号。

 merge 把多个信号合并为一个信号，任何一个信号有新值的时候就会调用

 zipWith 把两个信号压缩成一个信号，只有当两个信号同时发出信号内容时，并且把两个信号的内容合并成一个元组，才会触发压缩流的next事件。

 combineLatest:将多个信号合并起来，并且拿到各个信号的最新的值,必须每个合并的signal至少都有过一次sendNext，才会触发合并的信号。

 reduce聚合:用于信号发出的内容是元组，把信号发出元组的值聚合成一个值

 filter:过滤信号，使用它可以获取满足条件的信号.

 ignore:忽略完某些值的信号.

 distinctUntilChanged:当上一次的值和当前的值有明显的变化就会发出信号，否则会被忽略掉。

 take:从开始一共取N次的信号

 takeLast:取最后N次的信号,前提条件，订阅者必须调用完成，因为只有完成，就知道总共有多少信号.

 takeUntil:(RACSignal *):获取信号直到某个信号执行完成

 skip:(NSUInteger):跳过几个信号,不接受。

 switchToLatest:用于signalOfSignals（信号的信号），有时候信号也会发出信号，会在signalOfSignals中，获取signalOfSignals发送的最新信号。

 doNext: 执行Next之前，会先执行这个Block

 doCompleted: 执行sendCompleted之前，会先执行这个Block

 timeout：超时，可以让一个信号在一定的时间后，自动报错。

 interval 定时：每隔一段时间发出信号

 delay 延迟发送next。

 retry重试 ：只要失败，就会重新执行创建信号中的block,直到成功.

 replay重放：当一个信号被多次订阅,反复播放内容

 throttle节流:当某个信号发送比较频繁时，可以使用节流，在某一段时间不发送信号内容，过了一段时间获取信号的最新内容发出。
 
 */
@end

NS_ASSUME_NONNULL_END
