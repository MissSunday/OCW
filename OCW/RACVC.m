//
//  RACVC.m
//  OCW
//
//  Created by 朵朵 on 2021/7/5.
//

#import "RACVC.h"
#import <ReactiveObjC.h>
#import "Person.h"
#import <YYModel.h>
#import "RACCell.h"
#import <Masonry/Masonry.h>
@interface RACVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UILabel *label;

@property(nonatomic,strong)UIButton *button;

@property(nonatomic,strong)UITextField *textField;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation RACVC
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.cyanColor;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
    //TODO:开始你的表演
    [self rac_RACSignal];
    [self rac_RACDisposable];
    [self rac_RACSubject];
    [self rac_use];
    
    [self racCommand];
}
#pragma mark RACSignal RACMulticastConnection
-(void)rac_RACSignal{
    
    //1、创建信号量
    RACSignal * signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        NSLog(@"创建信号量");
        
        //3、发布信息
        [subscriber sendNext:@"I'm send next data"];
        
        NSLog(@"那我啥时候运行");
        
        return nil;
    }];
    
    //2、订阅信号量
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%s - %@",__func__,x);
    }];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%s - %@",__func__,x);
    }];
    //多次订阅会多次执行创建信号量内部的block
    
    //如果想要一个信号被多次订阅，避免多次调用创建信号中的block，可以用RACMulticastConnection
    
    //场景：一次网络请求的结果，被多处用到
    
    //RACMulticastConnection用法
    
    RACSignal * signal1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送网络请求");
        [subscriber sendNext:@"网络请求成功"];
        NSError *error = [NSError errorWithDomain:NSNetServicesErrorDomain code:200 userInfo:@{NSLocalizedFailureReasonErrorKey:@"你是不是网不好啊"}];
        [subscriber sendError:error];
        [subscriber sendCompleted];
        //error 和 complete 不会同时发送 或者说 error 和 complete的订阅不会同时执行
        return nil;
    }];
    
    RACMulticastConnection *connect = [signal1 publish];
    
    [connect.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"1 %s - %@",__func__,x);
    }error:^(NSError * _Nullable error) {
        NSLog(@"1 - %@",error);
    }completed:^{
        NSLog(@"1 请求完成");
    }];
    [connect.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"2 %s - %@",__func__,x);
    }error:^(NSError * _Nullable error) {
        NSLog(@"2 - %@",error);
    }completed:^{
        NSLog(@"2 请求完成");
    }];
    //务必调用此方法
    [connect connect];
}
#pragma mark RACDisposable
-(void)rac_RACDisposable{
    
    //1、创建信号量
    RACSignal * signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        NSLog(@"创建信号量");
        
        //3、发布信息
        [subscriber sendNext:@"I'm send next data"];
        
        NSLog(@"那我啥时候运行");
        
        return [RACDisposable disposableWithBlock:^{
            /* 当
             订阅者被销毁  或者
             RACDisposable 调用dispose取消订阅
             会执行此block
             */
            NSLog(@"订阅者销毁了");
            
            //如果subscriber被强引用 将不会被销毁 就无法调用此block 这时候可以主动调用[disposable dispose]触发取消订阅
        }];
        
        
    }];
    
    //2、订阅信号量
    RACDisposable *disposable = [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%s - %@",__func__,x);
    }];
    //主动触发取消订阅
    //[disposable dispose];
}
#pragma mark RACSubject、RACReplaySubject
-(void)rac_RACSubject{
    
    //RACSignal是不具备发送信号的能力的，但是RACSubject这个类就可以做到订阅／发送为一体。
    
    //1创建信号，
    RACSubject * subject = [RACSubject subject];
    
    //2订阅信号
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    //3发送数据
    [subject sendNext:@"发送数据"];
    
    //RACSubject 内部创建了一个_disposable取消信号和一个数组_subscribers，用来保存订阅者。
    
    //1、创建的subject的是内部会创建一个数组_subscribers用来保存所有的订阅者
    //2、订阅信息的时候会创建订阅者，并且保存到数组中
    //3、遍历subject中_subscribers中的订阅者，依次发送信息
    
    // !!: 对于RACSignal不同的地方是：RACSubject可以被订阅多次，并且只能是 先订阅后发布。
    
    //如果非要 先发送再订阅，用 RACReplaySubject
    //RACReplaySubject 继承自 RACSubject
    
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    [replaySubject sendNext:@"我先发送数据，等你接收"];
    [replaySubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    //1、创建的时候会在父类的基础之上多做一步，创建一个数组用来保存发送的数据,还有一个数量值，用来控制信号数量，如果超过这个限制，从第0个开始删除多余的条数的信号
    //2、发送数据，但是此时发送会失败啊，为什么？因为没有人订阅啊，我发给谁啊。
    //3、订阅信号，先遍历一次保存数据的数组，如果有就执行 2 。
    
}
#pragma mark 基本用法
-(void)rac_use{
    
    //监听
    [[self.button rac_valuesForKeyPath:@"frame" observer:nil]subscribeNext:^(id  _Nullable x) {
        NSLog(@"2 - %@",x);
    }];
    [[RACObserve(self.button, frame)skip:1]subscribeNext:^(id  _Nullable x) {
        NSLog(@"3 - %@",x);
    }];
    
    UIRefreshControl * control = [[UIRefreshControl alloc] init];
    //关联对象方法
    [[control rac_signalForSelector:@selector(beginRefreshing)] subscribeNext:^(id _Nullable x) {
        NSLog(@"开始刷新");
    }];
    
    [[control rac_signalForSelector:@selector(endRefreshing)] subscribeNext:^(id _Nullable x) {
        NSLog(@"结束刷新");
    }];
    
    [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"%@",x);
    }];
    //通知
    [[[NSNotificationCenter defaultCenter]rac_addObserverForName:UIKeyboardDidShowNotification object:nil]subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    //textfield
    [self.textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@",x);
    }];
    /*
     RAC(self.button,enabled) = [RACSignal combineLatest:@[RACObserve(self, dataArray),self.textField.rac_textSignal]reduce:^id(NSMutableArray *array,NSString *text){
     return @(array.count > 0 && text.length > 0);
     }];
     */
    
    [[self.textField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        //过滤
        return value.length > 5;
    }]subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    //绑定
    RAC(self.label,text) = self.textField.rac_textSignal;
    //RAC(对象，对象的属性) = (一个信号);
    //比如：RAC(btn,enable) = (RACSignal) 按钮的enable等于一个信号
    
    
    
    NSArray *array = @[@{@"title":@"RACSignal"},
                       @{@"title":@"RACDisposable"},
                       @{@"title":@"RACSubject、RACReplaySubject"},
                       @{@"title":@"基本用法"},
                       @{@"title":@"RACTuple、RACSequence"},
                       @{@"title":@"7777777"}];
    self.dataArray = [[[array.rac_sequence map:^id _Nullable(NSDictionary *  _Nullable value) {
        return [Person yy_modelWithDictionary:value];
    }]array]mutableCopy];
    [self.tableView reloadData];
    
}
#pragma mark RACTuple、RACSequence
-(void)rac_RACTuple_RACSequence{
    @weakify(self);
    
    //RACTuple: 元组, 相当于swift 中的数组, 也是OC 中数组的简化, 即数组中的元素可以是不同类型.
    
    RACTuple *a = [RACTuple tupleWithObjects:@"大吉大利",@"今晚吃鸡",@66666,@99999, nil];
    RACTuple *b = [RACTuple tupleWithObjectsFromArray:@[@"大吉大利",@"今晚吃鸡",@66666,@99999]];
    RACTuple *c = [RACTuple tupleWithObjectsFromArray:@[@"大吉大利",@"今晚吃鸡",@66666,@99999] convertNullsToNils:YES];
    
    id aa = a.first;
    id bb = b[0];
    id cc = c.last;
    
    
    NSArray *array = @[@"qwe",@"asd",@"vcx",@"239",@"klu"];
    
    RACSequence *sequence = array.rac_sequence;
    
    RACSignal *signal = sequence.signal;
    
    [signal subscribeNext:^(id  _Nullable x) {
        
    }];
    //写在一起就是下面
    [array.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSLog(@"--- %@",x);
        //遍历
    }];
    NSDictionary * dict = @{@"大吉大利":@"今晚吃鸡",
                            @"666666":@"999999",
                            @"dddddd":@"aaaaaa"
    };
    
    [dict.rac_sequence.signal subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);NSLog(@"%@",x);
    }];
    [dict.rac_sequence.signal subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self); NSLog(@"key - %@ value - %@",x[0],x[1]);
    }];
    [dict.rac_sequence.signal subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
        RACTupleUnpack(NSString *key,id value) = x;
        NSLog(@"key - %@ value - %@",key,value);
    }];
    
    // !!!: 字典转型
    NSArray *p = @[@{@"num":@5},@{@"num":@6},@{@"num":@7}];
    NSMutableArray *persons = [[[p.rac_sequence map:^id _Nullable(NSDictionary *value) {
        @strongify(self);
        return [Person yy_modelWithDictionary:value];
    }]array]mutableCopy];
    
    //[persons removeLastObject];

}
#pragma mark rac_liftSelector
- (void)rac_liftSelector {
    
    RACSignal *firstSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        NSLog(@"模拟第一个网络请求");
        [subscriber sendNext:@"第一次获取到的网络数据"];
        return nil;
    }];
    
    RACSignal *secondSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        NSLog(@"模拟第二个网络请求");
        [subscriber sendNext:@"第二次获取到的网络数据"];
        return nil;
    }];
    
    RACSignal *thirdSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        NSLog(@"模拟第三个网络请求");
        [subscriber sendNext:@"第三次获取到的网络数据"];
        return nil;
    }];
    // 方法updateUIWithData1...的参数，对应每个信号发送的数据
    [self rac_liftSelector:@selector(updateUIWithData1:Data2:Data3:) withSignalsFromArray:@[firstSignal, secondSignal, thirdSignal]];
    
}
/// 监听多个模块全部执行完成
/// 方法的参数必须与监听的信号一一对应
/// 方法的参数就是每个信号发送的数据
/// @param data1 对应上面firstSignal 监听的信号发送的数据
/// @param data2 对应上面secondSignal 监听的信号发送的数据
/// @param data3 对应上面thirdSignal 监听的信号发送的数据
- (void)updateUIWithData1:(NSString *)data1 Data2:(NSString *)data2 Data3:(NSString *)data3 {
    
    NSLog(@"更新UI:%@-%@-%@", data1, data2, data3);
}
-(void)racCommand{
    
    RACCommand *command = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@"命令信息 - %@",input);
        
        RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            NSLog(@"拿到命令信息 - %@",input);
            NSLog(@"开始搞事比如网络请求");
            [subscriber sendNext:@"执行后结果"];
            [subscriber sendCompleted];
            return nil;
        }];
        return signal;
        
    }];
    [[command execute:@{@"token":@"RFssdg23GEEGF",@"id":@"6666"}]subscribeNext:^(id  _Nullable x) {
        NSLog(@"执行完命令，带回来的数据是 - %@",x);
    }];
    
    
}



#pragma mark - Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RACCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RACCell class]) forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    cell.vc = self;
    [cell.btnClickSignal subscribeNext:^(RACTuple * _Nullable x) {
        RACCell *currentCell = x.first;
        Person *person = x.second;
        NSLog(@"- %@ %@",NSStringFromClass([currentCell class]),person.title);
    }];
    return cell;
}



#pragma mark - 懒加载
/*
 ******************************************************************************************************
 ******************************************懒加载隔开不用看**********************************************
 ******************************************************************************************************
 */
- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(0, 0, 0, 0);
    }
    return _button;
}
- (UITextField *)textField{
    if (!_textField) {
        _textField = [UITextField new];
    }
    return _textField;
}
- (UILabel *)label{
    if (!_label) {
        _label = UILabel.new;
    }
    return _label;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 50;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        //_tableView.bounces = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[RACCell class] forCellReuseIdentifier:NSStringFromClass([RACCell class])];
    }
    return _tableView;
}
- (void)dealloc{
    NSLog(@"释放了");
}
@end
