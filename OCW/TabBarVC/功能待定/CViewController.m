//
//  CViewController.m
//  OCW
//
//  Created by 朵朵 on 2021/7/20.
//

#import "CViewController.h"
#import <Security/Security.h>
//#import <SenseTimeFaceSDK_iOS/SenseTimeFaceHeader.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import "XRAFNRequest.h"
@interface CViewController ()

@property(nonatomic,strong)UISwitch *open;

@end

int CMethod(void);

@implementation CViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"C语言";
    
    CMethod();
    
    
    [self.view addSubview:self.open];
    [self.open mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
    @weakify(self);
    [[self.open rac_signalForControlEvents:UIControlEventValueChanged]subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        int a = [self currentScreenMode];
        NSLog(@"%d --- %d",self.open.isOn,a);
    }];
}
//设备是否设置了解锁密码
-(NSString *) deviceHasPasscode {
    
    if (@available(iOS 8.0, *)) {
        NSData* secret = [@"Device has passcode set?" dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *attributes = @{ (__bridge id)kSecClass: (__bridge id)kSecClassGenericPassword, (__bridge id)kSecAttrService: @"LocalDeviceServices",  (__bridge id)kSecAttrAccount: @"NoAccount", (__bridge id)kSecValueData: secret, (__bridge id)kSecAttrAccessible: (__bridge id)kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly };
        
        OSStatus status = SecItemAdd((__bridge CFDictionaryRef)attributes, NULL);
        if (status == errSecSuccess) { // item added okay, passcode has been set
            SecItemDelete((__bridge CFDictionaryRef)attributes);
            return @"1";
        }
        return @"0";
    }else{
        //不能检测
        return @"lessThaniOS8.0";
    }
}
-(void)passwordCheck{
    LAContext *context = [[LAContext alloc]init];
    
    NSError *error = nil;
    BOOL support =  [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error];
    
    NSLog(@"%@密码",support? @"设置了" : @"关闭了");
    
    
}
-(void)faceCheck{
    
    LAContext *context = [[LAContext alloc]init];
    
    NSError *error = nil;
    BOOL support =  [context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error];
    
    //if (support) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"Home键验证已有手机指纹" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                
            }else {
                
                
            }
        }];
    //}
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //NSLog(@"---- %@  ",[self deviceHasPasscode]);
    //[self faceCheck];
    //[self passwordCheck];
    
    
    XRAFNRequest *req = [[XRAFNRequest alloc]init];
    [req req];
    
    
}


-(int)currentScreenMode{
    if (@available(iOS 13.0, *)) {
        UIUserInterfaceStyle mode = UITraitCollection.currentTraitCollection.userInterfaceStyle;
        if (mode == UIUserInterfaceStyleDark) {
            NSLog(@"深色模式");
            return 1;
        } else if (mode == UIUserInterfaceStyleLight) {
            NSLog(@"浅色模式");
            return 0;
        } else {
            NSLog(@"未知模式");
            return 6;
        }
    }
    return 6;
}


//c函数
//:completeSettings = none
int CMethod(void){
    
    printf("hello world\n");
    
    NSString *str = @"asdf";
    void *p;
    p = &str;
    printf("str 变量的地址： %p\n", p);
    
    NSLog(@"--- %p   %p",&str,&p);
    
    return 123;
}


- (UISwitch *)open{
    if (!_open) {
        _open = [[UISwitch alloc]init];
    }
    return _open;
}










@end
