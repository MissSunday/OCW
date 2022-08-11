//
//  RACKeyWordUseVC.m
//  OCW
//
//  Created by 朵朵 on 2021/7/20.
//

#import "RACKeyWordUseVC.h"
#import "Person.h"
@interface RACKeyWordUseVC ()
@property(nonatomic,strong)UITextField *tf;


@end

@implementation RACKeyWordUseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSStringFromClass([self class]);
    [self UI];
}
-(void)UI{
    [self.view addSubview:self.tf];
    
    [self layout];
    [self reduce];
}
-(void)layout{
    [self.tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(50);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(50);
    }];
    
    [self binding];
}
-(void)binding{
    
    // !!!: 关键字
    // !!!: filter 过滤
    // !!!: map 映射
    // !!!: bind 包装信号
    // !!!: skip 跳过信号（数量）
    @weakify(self);
    [[[[self.tf.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        BOOL a = value.length > 3;
        BOOL b = value.length < 12;
        BOOL c = a && b;
        return c;
    }] map:^id _Nullable(NSString * _Nullable value) {
        
        NSString *result = [NSString stringWithFormat:@"%@-aaa",value];
        return result;
    }] bind:^RACSignalBindBlock {
        return ^RACSignal*(id value,BOOL *stop){
            return [RACReturnSignal return:[NSString stringWithFormat:@"hello: %@",value]];
        };
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"执行后的结果 = %@",x);
    }];
    
//    [[[self.tf.rac_textSignal bind:^RACSignalBindBlock {
//            return ^RACSignal*(id value,BOOL *stop){
//                return [RACReturnSignal return:[NSString stringWithFormat:@"hello: %@",value]];
//            };
//    }]skip:1] subscribeNext:^(id  _Nullable x) {
//
//        //包装信号
//
//        NSLog(@"包装后的输出为-----%@",x);
//    }];
    

    // !!!: 字典转型
    NSArray *p = @[@{@"num":@5},@{@"num":@6},@{@"num":@7}];
    NSMutableArray *persons = [[[p.rac_sequence map:^id _Nullable(NSDictionary *value) {
        @strongify(self);
        return [Person yy_modelWithDictionary:value];
    }]array]mutableCopy];
    NSLog(@"模型数组 - %@",persons);
    
    
}
//reduce 用来处理元祖数据
-(void)reduce{
    
    
    RACSubject *sub1 = [RACSubject subject];
    RACSubject *sub2 = [RACSubject subject];
    RACSignal *signal = [RACSignal combineLatest:@[sub1,sub2] reduce:^id _Nonnull(NSString *string1,NSString *string2){
        
        return [NSString stringWithFormat:@"%@-%@",string1,string2];
    }];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"输出的为--%@",x);
    }];
    [sub1 subscribeNext:^(id  _Nullable x) {
        NSLog(@"1有变化 - %@",x);
    }];
    [sub1 sendNext:@"a"];
    [sub2 sendNext:@"b"];
    [sub2 sendNext:@"B"];
    [sub1 sendNext:@"A"];
    //输出的为--a-b
    //输出的为--a-B
    //输出的为--A-B
    
}

#pragma mark - Delegate

#pragma mark - LazyLoad
- (UITextField *)tf{
    if (!_tf) {
        _tf = [[UITextField alloc]init];
        _tf.placeholder = @"请输入";
        _tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        _tf.textColor = [UIColor color63];
        _tf.font = [UIFont systemFontOfSize:15];
        _tf.borderStyle = UITextBorderStyleBezel;
        _tf.backgroundColor = [UIColor cyanColor];
    }
    return _tf;
}
@end
