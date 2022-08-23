//
//  GitCommandVC.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/8/22.
//

#import "GitCommandVC.h"

@interface GitCommandVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)GitCommandViewModel *viewModel;
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation GitCommandVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.viewModel = [[GitCommandViewModel alloc]init];
    @weakify(self);
    [RACObserve(self.viewModel, modelArray)subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }]; 
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.modelArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.viewModel.modelArray[indexPath.row].cellHeight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GitCommandCell *cell = [tableView dequeueReusableCellWithIdentifier:[GitCommandCell className] forIndexPath:indexPath];
    cell.model = self.viewModel.modelArray[indexPath.row];
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
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[GitCommandCell class] forCellReuseIdentifier:[GitCommandCell className]];
        _tableView.tableFooterView = [UIView new];
        
    }
    return _tableView;
}
@end

@interface GitCommandCell ()
@property(nonatomic,strong)YYLabel *contentLabel;
@end

@implementation GitCommandCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
            make.height.mas_equalTo(0);
        }];
    }
    return self;
}
- (void)setModel:(gitCellModel *)model{
    _model = model;
    self.contentLabel.textLayout = model.textLayout;
    [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(model.textLayout.textBoundingRect.size.height);
    }];
}
- (YYLabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [YYLabel new];
    }
    return _contentLabel;
}
@end

@implementation gitModel

@end
@implementation gitCellModel
//映射字段
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"name"  : @"n",
             @"page"  : @"p",
             @"desc"  : @"ext.desc",
             @"bookID": @[@"id", @"ID", @"book_id"]};
}
//映射类
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"content" : [gitModel class]};
}

@end

@interface GitCommandViewModel ()
@property(nonatomic,strong)NSArray *dataArray;
@property(nonatomic,strong)dispatch_queue_t gitViewModelQueue;
@end

@implementation GitCommandViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.gitViewModelQueue = dispatch_queue_create("gitViewModelQueue", DISPATCH_QUEUE_CONCURRENT);
        [self analyseData];
    }
    return self;
}
-(void)analyseData{
    dispatch_async(self.gitViewModelQueue, ^{
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for (NSDictionary *temp in self.dataArray) {
            gitCellModel *model = [gitCellModel yy_modelWithDictionary:temp];
            
            model.textLayout = [self calculateTextLayoutWithModle:model];
            
            model.cellHeight = [self calculateCellHeightWithModle:model];
            
            [array addObject:model];
        }
        self.modelArray = array;
    });
}
-(YYTextLayout *)calculateTextLayoutWithModle:(gitCellModel *)model{
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:model.title];
    
    title.yy_color = [UIColor blackColor];
    title.yy_font = [UIFont boldSystemFontOfSize:20];
    title.yy_lineSpacing = 15;
    
    [title appendAttributedString:[[NSMutableAttributedString alloc]initWithString:@"\n"]];
    
    for (int i = 0; i< model.content.count; i++) {
        gitModel *gm = model.content[i];
        NSString *ori = [NSString stringWithFormat:@" %@ ",gm.command];
        
        NSMutableAttributedString *command = [[NSMutableAttributedString alloc]initWithString:ori];
        command.yy_color = [UIColor redColor];
        command.yy_font = [UIFont boldSystemFontOfSize:18];
        command.yy_lineSpacing = 8;
        YYTextBorder *bor = [YYTextBorder borderWithFillColor:[[UIColor redColor]colorWithAlphaComponent:0.1] cornerRadius:2];
        [command yy_setTextBackgroundBorder:bor range:[ori rangeOfAll]];
        
        [command appendAttributedString:[[NSMutableAttributedString alloc]initWithString:@"\n"]];
        
        NSMutableAttributedString *des = [[NSMutableAttributedString alloc]initWithString:gm.des];
        
        des.yy_color = [UIColor blackColor];
        des.yy_font = [UIFont systemFontOfSize:18];
        des.yy_lineSpacing = 15;
        
        [title appendAttributedString:command];
        [title appendAttributedString:des];
        if (i != model.content.count - 1) {
            [title appendAttributedString:[[NSMutableAttributedString alloc]initWithString:@"\n"]];
        }
    }
    
 
    
    YYTextContainer *container = [YYTextContainer new];
    
    container.size = CGSizeMake(kS_W-30, CGFLOAT_MAX);
    //container.insets = UIEdgeInsetsMake(15, 15, 15 , 10);
    YYTextLayout *textLayout = [YYTextLayout layoutWithContainer:container text:title];
    return textLayout;
}
-(CGFloat)calculateCellHeightWithModle:(gitCellModel *)model{
    
    return model.textLayout.textBoundingRect.size.height+15;
    
}

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray =   @[
            @{@"title":@"一、基本的linux命令",
              @"content":@[
                  @{@"command":@"cd",
                    @"des"    :@"进入某个目录"},
                  @{@"command":@"pwd",
                    @"des"    :@"显示当前目录路径"},
                  @{@"command":@"ls",
                    @"des"    :@"列出当前目录的文件"},
                  @{@"command":@"ls -l",
                    @"des"    :@"列出详细信息"},
                  @{@"command":@"touch",
                    @"des"    :@"新建一个文件"},
                  @{@"command":@"rm",
                    @"des"    :@"删除文件"},
                  @{@"command":@"-rf",
                    @"des"    :@"强制删除目录"},
                  @{@"command":@"mkdir",
                    @"des"    :@"新建一个目录"},
                  @{@"command":@"mv",
                    @"des"    :@"移动文件"},
                  @{@"command":@"cat",
                    @"des"    :@"显示文件内容"}
              ]
            },
            @{@"title":@"二、git常用命令",
              @"content":@[
                  @{@"command":@"git init",
                    @"des"    :@"在当前目录新建一个仓库"},
                  @{@"command":@"git init [project-name]",
                    @"des"    :@"在一个目录下新建本地仓库"},
                  @{@"command":@"git clone [url]",
                    @"des"    :@"克隆一个远程仓库"},
                  @{@"command":@"git status [file-name]",
                    @"des"    :@" 查看指定文件状态"},
                  @{@"command":@"git status",
                    @"des"    :@"查看所有文件状态"},
                  @{@"command":@"git add [file-name1] [file-name2] ...",
                    @"des"    :@"从工作区添加指定文件到暂存区"},
                  @{@"command":@"git add .",
                    @"des"    :@"将被修改的文件和新增的文件提交到暂存区，不包括被删除的文件"},
                  @{@"command":@"git add -u .",
                    @"des"    :@"u指update，将工作区的被修改的文件和被删除的文件提交到暂存区，不包括新增的文件"},
                  @{@"command":@"git add -A .",
                    @"des"    :@"A指all，将工作区被修改、被删除、新增的文件都提交到暂存区"},
                  @{@"command":@"git commit -m [massage]",
                    @"des"    :@"将暂存区所有文件添加到本地仓库"},
                  @{@"command":@"git commit [file-name-1] [file-name-2] -m [massage]",
                    @"des"    :@"将暂存区指定文件添加到本地仓库"},
                  @{@"command":@"git commit -am [massage]",
                    @"des"    :@"将工作区的内容直接加入本地仓库"},
                  @{@"command":@"git commit --amend",
                    @"des"    :@"快速将当前文件修改合并到最新的commit，不会产生新的commit"},
                  @{@"command":@"git clean -df",
                    @"des"    :@"加-d是指包含目录，加-f是指强制，删除所有未跟踪的文件"},
                  @{@"command":@"git log",
                    @"des"    :@"显示所有commit日志"},
                  @{@"command":@"git log --pretty=oneline",
                    @"des"    :@"将日志缩写为单行显示"},
                  @{@"command":@"git log --graph --pretty=oneline --abbrev-commit",
                    @"des"    :@"查看分支合并情况"},
                  @{@"command":@"git log --oneline --decorate --graph --all",
                    @"des"    :@"查看分叉历史，包括：提交历史、各个分支的指向以及项目的分支分叉情况"},
                  @{@"command":@"git log -3",
                    @"des"    :@"查看最新3条commit日志数据"},
              ]
            }
        ];
    }
    return _dataArray;
}
@end
