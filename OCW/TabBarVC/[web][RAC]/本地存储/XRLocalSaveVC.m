//
//  XRLocalSaveVC.m
//  OCW
//
//  Created by 王晓冉 on 2021/9/23.
//

#import "XRLocalSaveVC.h"
#import "T.h"
@interface XRLocalSaveVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation XRLocalSaveVC

#pragma mark 沙盒路径存储文件
-(void)directorieSave{
    
    /*应用沙盒
     
     Document:适合存储重要的数据， iTunes同步应用时会同步该文件下的内容,（比如游戏中的存档）
     Library/Caches：适合存储体积大，不需要备份的非重要数据，iTunes不会同步该文件
     Library/Preferences:通常保存应用的设置信息, iTunes会同步
     tmp:保存应用的临时文件，用完就删除，系统可能在应用没在运行时删除该目录下的文件，iTunes不会同步
     */
    
    //沙盒路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSLog(@"SandBoxPath--->%@",documentDirectory);

     
   
    // 拼接一个文件名
    NSString *dataPath = [documentDirectory stringByAppendingPathComponent:@"face.model"];
    
    // 拿到本地文件 转化成data
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"KM_August_Face_Gray" ofType:@"model"]];
    // 存
    BOOL su = [data writeToFile:dataPath atomically:YES];
    if (su) {
        NSLog(@"存储成功");
    }else{
        NSLog(@"失败");
    }
    //取
    NSData *d = [NSData dataWithContentsOfFile:dataPath];
    //self.imageV.image = [UIImage imageWithData:data];
    
}

#pragma mark NSUserDefaults
-(void)userDefaultSave{
    
    /*
     NSuserDefault适合存储轻量级的本地数据，支持的数据类型有：
     NSNumber，NSString，NSDate，NSArray，NSDictionary，BOOL，NSData
     沙盒路径为 Library/Preferences
     文件格式为 .plist
     */
    //存
    NSArray *A = @[@"2",@"3"];
    [[NSUserDefaults standardUserDefaults]setObject:A forKey:@"someArray"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    //取
    id B = [[NSUserDefaults standardUserDefaults]objectForKey:@"someArray"];
    
    
    #pragma mark plist
    //支持NSString，NSData，NSDate，NSNumber，NSArray，NSDictionary
    //存
    //获取一个路径
    //NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    //创建文件路径
    //NSString *filePath = [cachePath stringByAppendingPathComponent:@"set.plist"];
   
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    NSString *path1 = [documentDirectory stringByAppendingPathComponent:@"sam"];
  
    if (![[NSFileManager defaultManager] fileExistsAtPath:path1]) {
         [[NSFileManager defaultManager] createDirectoryAtPath:path1 withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *filePath = [path1 stringByAppendingPathComponent:@"set.plist"];
    
    
    NSDictionary *setDic = @{@"name":@"666",@"age":@"100"};
    [setDic writeToFile:filePath atomically:YES];
    
    //取
    id D = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    
}

#pragma mark NSKeyedArchiver
-(void)archiverSave{
    
    //实体类需要遵循NSCoding协议
    //存
    //获取路径
    NSString *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    //设置文件路径
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:@"personModel"];
    NSMutableData *data = [[NSMutableData alloc]init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    
    T *t1 = [T new];
    t1.array = @[].mutableCopy;
    [archiver encodeObject:t1 forKey:@"t1"];
    
    T *t2 = [T new];
    t2.array = @[].mutableCopy;
    [archiver encodeObject:t2 forKey:@"t2"];
    
    [archiver finishEncoding];
    
    [data writeToFile:filePath atomically:YES];
    
    //取
    NSData *D = [NSData dataWithContentsOfFile:filePath];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:D];
    
    id t11 = [unarchiver decodeObjectForKey:@"t1"];
    id t22 = [unarchiver decodeObjectForKey:@"t2"];
    
    [unarchiver finishDecoding];
    
    
    
    #pragma mark archiver结合userdefault使用
    NSArray *dataArray = @[t1,t2]; //内部是model 需要实现NSCoding协议
    //存
    //编码
    NSData *dd = [NSKeyedArchiver archivedDataWithRootObject:dataArray];
    //存储
    [kUserDefaults setObject:dd forKey:@"dataArray"];
    [kUserDefaults synchronize];
    
    //取
    //取出对应的data
    NSData *tt = [kUserDefaults objectForKey:@"dataArray"];
    //解码
    id array = [NSKeyedUnarchiver unarchiveObjectWithData:tt];
    if ([array isKindOfClass:[NSArray class]]) {
        //开始搞事
    }
    
}
#pragma mark 数据库存储
-(void)sqlSave{
    
}
#pragma mark coreData存储
-(void)coreDataSave{
    
}







#pragma mark - 页面相关
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSStringFromClass(self.class);
    [self UI];
    //[self userDefaultSave];
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
    cell.textLabel.text = a;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

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
        _dataArray = @[@"1. NSUserDefaults（Preference偏好设置）",@"2. plist存储，保存到本地",@"3. 归档",@"4. SQLite3",@"5. CoreData"].mutableCopy;
    }
    return _dataArray;
}

@end
