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

@interface AViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong)Person *DuoDuo;
@end

@implementation AViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"各种功能入口";
    [self UI];
    [self nav];
    [self block_text];
    [self func_chain];
    test1 *t1 = [[test1 alloc]init];
    [t1 show];
    
}
//block 练习
-(void)block_text{
    
    //gcd测试
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"gcd - 0");
        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"gcd - 1");
        });
        NSLog(@"gcd - 2");
    });
    NSLog(@"gcd - 3");
    
    
    
    
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
    
    NSMutableArray *array = @[@1,@2,@3,@4,@5,@6,@7,@11,@8,@-13,@9,@10].mutableCopy;
    NSArray *subA = [array subarrayWithRange:NSMakeRange(1, 4)];
    [array sortUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
        return [@(fabsf(obj1.floatValue)) compare:@(fabsf(obj2.floatValue))];
    }];

    NSLog(@"%@\n%@",array,subA);
    
    
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
        _dataArray = @[@"图片浏览器-KNPhotoBrowser",@"选取上传图片，保存到本地",@"本地存储",@"组件间通信CTMediator",@"组件间通信JLRoutes",@""].mutableCopy;
    }
    return _dataArray;
}
@end
