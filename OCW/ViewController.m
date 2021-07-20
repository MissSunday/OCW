//
//  ViewController.m
//  OCW
//
//  Created by 朵朵 on 2021/5/20.
//

#import "ViewController.h"
#import "Person.h"
#import "SVC.h"
#import "FLEXManager.h"
#import "RACVC.h"
#import "QJCommonWebViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tf;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[FLEXManager sharedManager] showExplorer];
    
    long a = s;
    NSLog(@"- %s - %ld",__func__,a);
    self.view.backgroundColor = UIColor.cyanColor;
    self.xiaoDuo = [Person new];
    [self add];
    [self nav];
    
    @weakify(self);
    [[[self.tf.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        
        BOOL a = value.length > 3;
        BOOL b = value.length < 12;
        BOOL c = a && b;
        return c;
    }] map:^id _Nullable(NSString * _Nullable value) {
        
        NSString *result = [NSString stringWithFormat:@"%@-aaa",value];
        return result;
    }]subscribeNext:^(id  _Nullable x) {
        NSLog(@"执行后的结果 = %@",x);
    }];
    
    
    
}

-(void)add{
    static int a = 10;
    void(^block)(void) = ^{
        
        NSLog(@"- %d",a);
        //20
    };
    a = 20;
    block();
  
    //[self.xiaoDuo.add(2).add(5).add(6) run];
    
    self.xiaoDuo.chi(4,2).add(8);
    
    //[self.xiaoDuo add](5);
    
    NSLog(@" - %d",self.xiaoDuo.num);
    
    NSString *str = @"";
    
    __weak id tmp = nil;
    {
    NSObject *obj = [NSObject new];
    tmp = obj;
    }
    NSLog(@"--- %@",tmp); //出了作用域 就消失了
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    [btn setTitle:@"GO" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor orangeColor];
    btn.layer.cornerRadius = 10;
    btn.clipsToBounds = YES;
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.mas_equalTo(200);
    }];
    @weakify(self);
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
        [self.navigationController pushViewController:SVC.new animated:YES];
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
            vc.url = @"https://community-stg.unileverfoodsolutions.com.cn/h5/#/level?id=5&isUse=1&times=1626167462";
            [self.navigationController pushViewController:vc animated:YES];
        }];
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
        item;
    });
   
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"- %s -",__func__);
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"- %s -",__func__);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.tf endEditing:YES];
}
@end
