//
//  DViewController.m
//  OCW
//
//  Created by 朵朵 on 2021/7/20.
//

#import "DViewController.h"
@interface DViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation DViewController
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@"UIKit Dynamics力学动画生成       |DynamicAnimatorVC",
                       @"预留"].mutableCopy;
    }
    return _dataArray;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.title = @"框架";
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

    NSString *title = self.dataArray[indexPath.row];
    NSArray *array = [title componentsSeparatedByString:@"|"];
    if (array.count > 1) {
        NSString *className = array[1];
        Class class = NSClassFromString(className);
        [self.navigationController pushViewController:[[class alloc]init] animated:YES];
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

@end

