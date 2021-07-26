//
//  AViewController.m
//  OCW
//
//  Created by 朵朵 on 2021/7/20.
//

#import "AViewController.h"
#import "QJCommonWebViewController.h"
#import "RACVC.h"
#import "Person.h"
@interface AViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong)Person *DuoDuo;
@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"A";
    [self UI];
    [self nav];
    [self block_text];
    [self func_chain];
    test1 *t1 = [[test1 alloc]init];
    [t1 show];
    
}
//block 练习
-(void)block_text{
    
    static int a = 10;
    void(^block)(void) = ^{
        
        NSLog(@"- %d",a);
        //20
    };
    a = 20;
    block();
    
    //作用域测试
    __weak id tmp = nil;
    {
    NSObject *obj = [NSObject new];
    tmp = obj;
    }
    NSLog(@"--- %@",tmp); //出了作用域 就消失了
}
//链式编程 练习
-(void)func_chain{
    
    self.DuoDuo = [Person new];
    
    //[self.xiaoDuo.add(2).add(5).add(6) run];
    
    self.DuoDuo.chi(4,2).add(8);
    
    //[self.xiaoDuo add](5);
    
    NSLog(@" - %d",self.DuoDuo.num);
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"- %s -",__func__);
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"- %s -",__func__);
}

-(void)UI{
    [self.view addSubview:self.tableView];
    [self layout];
}
-(void)layout{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}
-(void)nav{
    @weakify(self);
    self.navigationItem.rightBarButtonItem = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"RAC" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:(UIControlStateHighlighted)];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [self.navigationController pushViewController:RACVC.new animated:YES];
        }];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
        item;
    });
    self.navigationItem.leftBarButtonItem = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"WEB" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:(UIControlStateHighlighted)];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            QJCommonWebViewController *vc = [QJCommonWebViewController new];
            vc.url = @"https://www.jianshu.com/u/f8b0e5cce3ab";
            [self.navigationController pushViewController:vc animated:YES];
        }];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
        item;
    });
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell className] forIndexPath:indexPath];
    NSString *a = self.dataArray[indexPath.row];
    cell.textLabel.text = a;
    return cell;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 50;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        //_tableView.bounces = NO;
        //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[UITableViewCell className]];
        _tableView.tableFooterView = [UIView new];
        
    }
    return _tableView;
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@"1",@"2",@"3",@"4",@"5",@"6"].mutableCopy;
    }
    return _dataArray;
}
@end
