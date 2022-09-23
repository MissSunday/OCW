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
#import "GitCommandVC.h"
#import "LinuxCommandVC.h"

@interface AHeadView ()
@property(nonatomic,strong)AViewModel *viewModel;
@end

@implementation AHeadView

-(instancetype)initWithModel:(AViewModel *)viewModel{
    
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.viewModel = viewModel;
        [self UI];
    }
    return self;
    
}
-(void)UI{
    
    self.backgroundColor = UIColor.whiteColor;
    @weakify(self);

    int l = 3;
    
    CGFloat space = 15;
    
    CGFloat w = ((kS_W-(l+1)*space)/l);
    
    CGFloat h = (kS_H/4 - l*space)/2;
    
    int a = (int)self.viewModel.btnArray.count / l;
    
    int b = (int)self.viewModel.btnArray.count % l;
    
    int c = b > 0 ? a + 1 : a;
    
    CGFloat headH = (c+1)*space + c*h;
    
    for (int i = 0; i < self.viewModel.btnArray.count ; i++) {
    
        CGFloat x = ( i % l ) * ( w + space ) + space;
        CGFloat y = ( i / l ) * ( h + space ) + space;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [self randomColor];
        [btn setTitle:self.viewModel.btnArray[i][@"title"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        btn.clipsToBounds = YES;
        btn.layer.cornerRadius = 10;
        btn.tag = i;
        [self addSubview:btn];
        btn.frame = CGRectMake(x, y, w, h);
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            NSString *vcName = self.viewModel.btnArray[btn.tag][@"vc"];
            Class cls = NSClassFromString(vcName);
            if (cls) {
                UIViewController *vc = [[cls alloc]init];
                [self.viewModel.vc.navigationController pushViewController:vc animated:YES];
            }
        }];
    }
    self.viewModel.headHeight = headH;
}
- (UIColor *)randomColor{
    return [UIColor colorWithRed:(arc4random() % 150+100)/255.0 green:(arc4random() % 150+100)/255.0 blue:(arc4random() % 150+100)/255.0 alpha:1];
}
@end
@implementation AViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        _headHeight = 0;
        _btnArray = @[
            @{@"title":@"数据类型",    @"vc":@"DataTypeVC"},
            @{@"title":@"runtime",    @"vc":@"RuntimeVC"},
            @{@"title":@"本地存储",     @"vc":@"XRLocalSaveVC"},
            @{@"title":@"Masonry",    @"vc":@"MasonryTestVC"},
            @{@"title":@"图片浏览器",   @"vc":@"KNPhotoBrowserVC"},
            @{@"title":@"选取上传图片", @"vc":@"TZImagePickerVC"},
            @{@"title":@"多线程",      @"vc":@"ThreadSafeVC"},
            @{@"title":@"面向协议",    @"vc":@"POPVC"},
            @{@"title":@"SDK设计",    @"vc":@"SDK_API_VC"},
            @{@"title":@"git命令",    @"vc":@"GitCommandVC"},
            @{@"title":@"Linux命令",  @"vc":@"LinuxCommandVC"},
        ];
    }
    return self;
}
@end

@interface AViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
//head数据
@property(nonatomic,strong)AViewModel *viewModel;

@property(nonatomic,strong)AHeadView *headView;
//cell数据
@property(nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong)Person *DuoDuo;
@end

@implementation AViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self UI];
    [self nav];
    [self func_chain];
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
    self.navigationItem.title = @"😘😘";
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
    [[RACObserve(self.viewModel, headHeight)skip:0]subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.headView.frame = CGRectMake(0, 0, kS_W, self.viewModel.headHeight);
            [self.tableView reloadData];
        });
    }];
    
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
        //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[UITableViewCell className]];
        _tableView.tableFooterView = [UIView new];
        _headView = [[AHeadView alloc]initWithModel:self.viewModel];
        _tableView.tableHeaderView = _headView;
    }
    return _tableView;
}
- (AViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[AViewModel alloc]init];
        _viewModel.vc = self;
    }
    return _viewModel;
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[
                       @"组件间通信CTMediator",
                       @"组件间通信JLRoutes",].mutableCopy;
    }
    return _dataArray;
}
@end
