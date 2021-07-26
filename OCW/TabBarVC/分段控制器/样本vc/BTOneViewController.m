//
//  BTOneViewController.m
//  OCW
//
//  Created by 朵朵 on 2021/7/26.
//

#import "BTOneViewController.h"
#import "BHViewController.h"
#import "BHLTViewController.h"
#import "BHLTMViewController.h"
@interface BTOneViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray *lineArray;

@property(nonatomic,strong)UIView *headView;

@end

@implementation BTOneViewController

- (NSArray *)lineArray{
    if (!_lineArray) {
        _lineArray = @[@{@"title":@"GKPageScrollView-OC在本地，依赖部分三方库",
                         @"line":@[@"BHViewController"]},
                       @{@"title":@"LTScrollView-Swift库",
                         @"line":@[@"刷新控件在顶部-LTSimple",@"刷新控件在中间-LTAdvanced"]}];
    }
    return _lineArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor vcBackgroundColor];
    [self UI];
}
-(void)UI{
    [self.view addSubview:self.tableView];
    
    [self layout];
}
-(void)layout{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self binding];
}
-(void)binding{
    //TODO: ViewModel获取请求数据
    
    //TODO: 绑定ViewModel的属性，坚挺变化，刷新UI
    
}

#pragma mark - Delegate
#pragma mark UITabelViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.lineArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *A = self.lineArray[section][@"line"];
    return A.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor vcBackgroundColor];
    UILabel *label = [UILabel new];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.text = self.lineArray[section][@"title"];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(view);
        make.left.equalTo(view).offset(15);
    }];
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell className] forIndexPath:indexPath];
    NSArray *A = self.lineArray[indexPath.section][@"line"];
    NSString *B = A[indexPath.row];
    cell.textLabel.text = B;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        [self.navigationController pushViewController:BHViewController.new animated:YES];
    }else{
        if (indexPath.row == 0) {
            [self.navigationController pushViewController:BHLTViewController.new animated:YES];
        }else{
            [self.navigationController pushViewController:BHLTMViewController.new animated:YES];
            
        }
    }
}
#pragma mark - LazyLoad
- (UITableView *)tableView{
    if (!_tableView) {
        //UITableViewStyleGrouped 不悬停   UITableViewStylePlain 悬停
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 50;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.tableHeaderView = self.headView;
        //_tableView.bounces = NO;
        //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[UITableViewCell className]];
    }
    return _tableView;
}
- (UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kS_W, 150)];
        _headView.backgroundColor = [UIColor orangeColor];
    }
    return _headView;
}

@end
