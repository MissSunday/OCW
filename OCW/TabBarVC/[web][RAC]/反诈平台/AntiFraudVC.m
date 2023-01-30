//
//  AntiFraudVC.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2023/1/11.
//

#import "AntiFraudVC.h"
#import "AntiFraudHeadView.h"
#import "AntiFraudViewModel.h"
#import "AntiFraudDataCell.h"
@interface AntiFraudVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)AntiFraudHeadView *headView;

@property(nonatomic,strong)AntiFraudViewModel *viewModel;

@end

@implementation AntiFraudVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self UI];
    [self ob];
    [self.viewModel loadData];
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
-(void)ob{
    @weakify(self);
    [RACObserve(self.viewModel, dataArray) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.tableView reloadData];
    }];
}
#pragma mark -Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 305;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AntiFraudDataCell *cell = [tableView dequeueReusableCellWithIdentifier:[AntiFraudDataCell className] forIndexPath:indexPath];
    cell.model = self.viewModel.dataArray[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Lazy
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 50;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[AntiFraudDataCell class] forCellReuseIdentifier:[AntiFraudDataCell className]];
        _tableView.tableFooterView = [UIView new];
        _headView = [[AntiFraudHeadView alloc]initWithFrame:CGRectMake(0, 0, kS_W, 130)];
        _tableView.tableHeaderView = _headView;
    }
    return _tableView;
}
- (AntiFraudViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[AntiFraudViewModel alloc]init];
    }
    return _viewModel;
}
@end
