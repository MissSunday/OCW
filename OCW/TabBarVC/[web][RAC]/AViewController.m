//
//  AViewController.m
//  OCW
//
//  Created by 朵朵 on 2021/7/20.
//

#import "AViewController.h"
#import "QJCommonWebViewController.h"
#import "KNPhotoBrowserVC.h"
#import "TZImagePickerVC.h"
#import "XRLocalSaveVC.h"
#import "RACVC.h"
#import "Person.h"
#import "CTMediator+First.h"
#import "MasonryTestVC.h"
#import "POPVC.h"
#import "ThreadSafeVC.h"
#import "SDK_API_VC.h"
#import "RuntimeVC.h"
#import "DataTypeVC.h"
@interface AViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong)Person *DuoDuo;
@end

@implementation AViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat a = [UIScreen mainScreen].scale;
    NSLog(@"scale = %f %fx%f",a,kS_W*a,kS_H*a);
    
    
    self.navigationItem.title = @"各种功能入口";
    [self UI];
    [self nav];
    [self block_text];
    [self func_chain];
    
    
}
//block 练习
-(void)block_text{
    
    /*
                并发队列        串行队列        主队列
      同步     没有开启新线程   没有开启新线程      死锁
               串行执行任务     串行执行任务
      异步      能开启新线程   有开启新线程(1条)  不开启新线程
               并发执行任务     串行执行任务     串行执行任务
    */
    
    //在函数内定义的静态局部变量，该变量存在内存的静态区
    //所以即使该函数运行结束，静态变量的值不会被销毁，函数下次运行时能仍用到这个值。
    for (int i = 0; i < 5; i++) {
        static int a = 1;
        NSLog(@"static静态变量 %d",a);
        a+=1;
    }
    
    
    //gcd测试
    NSLog(@"gcd - 4 %@",[NSThread currentThread]);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"gcd - 0 %@",[NSThread currentThread]);
        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"gcd - 1 %@",[NSThread currentThread]);
        });
        NSLog(@"gcd - 2 %@",[NSThread currentThread]);
    });
    NSLog(@"gcd - 3 %@",[NSThread currentThread]);
    
    
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
    
 
    _DuoDuo = [Person new];
    
    Person *running = [[_DuoDuo run]jump];
    

    NSLog(@"- %@",running);
    
    _DuoDuo.fgz(20000).jfz(6500).eat(2000);
    
    NSLog(@" 银行卡余额 ¥ %.2f",self.DuoDuo.money);
    
    NSMutableArray *array = @[@1,@2,@3,@4,@5,@6,@7,@11,@8,@-13,@9,@10].mutableCopy;
    NSArray *subA = [array subarrayWithRange:NSMakeRange(1, 4)];
    [array sortUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
        return [@(fabsf(obj1.floatValue)) compare:@(fabsf(obj2.floatValue))];
    }];
    
    NSLog(@"%@\n%@ hash - %ld",array,subA,array.hash);

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"- %s -",__func__);
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"- %s -",__func__);
}

- (void)updateViewConstraints{
    NSLog(@"- %s -",__func__);
    // --- remake/update constraints here
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    //according to apple super should be called at end of method
    [super updateViewConstraints];
    
}
-(void)UI{
    [self.view addSubview:self.tableView];
    [self layout];
}
-(void)layout{
    
    
}
-(void)nav{
    @weakify(self);
    self.navigationItem.rightBarButtonItem = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"RAC" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:(UIControlStateHighlighted)];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
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
        [btn setTitleColor:[UIColor orangeColor] forState:(UIControlStateHighlighted)];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
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
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell className] forIndexPath:indexPath];
    NSString *a = self.dataArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld.  %@",indexPath.row + 1,a];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:KNPhotoBrowserVC.new animated:YES];
    }else if (indexPath.row == 1){
        [self.navigationController pushViewController:TZImagePickerVC.new animated:YES];
    }else if (indexPath.row == 2){
        [self.navigationController pushViewController:XRLocalSaveVC.new animated:YES];
    }else if (indexPath.row == 3){
        UIViewController *vc = [[CTMediator sharedInstance]CTMediator_viewControllerForFirst];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 5){
        [self.navigationController pushViewController:[MasonryTestVC new] animated:YES];
    }else if (indexPath.row == 6){
        [self.navigationController pushViewController:[[POPVC alloc]init] animated:YES];
    }else if (indexPath.row == 7){
        [self.navigationController pushViewController:[[ThreadSafeVC alloc]init] animated:YES];
    }else if (indexPath.row == 8){
        [self.navigationController pushViewController:[[SDK_API_VC alloc]init] animated:YES];
    }else if (indexPath.row == 9){
        [self.navigationController pushViewController:[[RuntimeVC alloc]init] animated:YES];
    }else if (indexPath.row == 10){
        [self.navigationController pushViewController:[[DataTypeVC alloc]init] animated:YES];
    }
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
        _dataArray = @[@"图片浏览器-KNPhotoBrowser",
                       @"选取上传图片，保存到本地",
                       @"本地存储",
                       @"组件间通信CTMediator",
                       @"组件间通信JLRoutes",
                       @"Masonry示例",
                       @"面向协议编程",
                       @"多线程编程和线程安全",
                       @"SDK API 设计",
                       @"runtime相关",
                       @"数据类型"].mutableCopy;
    }
    return _dataArray;
}
@end
