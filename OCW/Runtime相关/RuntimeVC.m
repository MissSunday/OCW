//
//  RuntimeVC.m
//  OCW
//
//  Created by 朵朵 on 2021/7/14.
//

#import "RuntimeVC.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "Person.h"
#import <XRSDK/XRSDK.h>

@interface RuntimeVC ()

@end

@implementation RuntimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSStringFromClass(self.class);
    
 
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    Class testClass = [[XRRoute router] routerClassName:@"XRRouteTestVC"];
    
    if (testClass) {
        UIViewController *vc = [[testClass alloc]init];
        
        [vc setValue:[UIColor redColor] forKey:@"bgColor"];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    Class testClass = [[XRRoute router] routerClassName:@"XRRouteTest"];
    if (testClass) {
        {
            NSString *a = [testClass performSelectorClassMethod:@"abc" parameter:nil].returnValue;
            NSLog(@"(|-.-|) %@",a);
            NSNumber *b = [testClass performSelectorClassMethod:@"ccc" parameter:nil].returnValue;
            NSLog(@"(|-.-|) %@",b);
            
            [testClass performSelectorClassMethod:@"ddd" parameter:nil];
        }
        {
            NSString *a = @"A";
            int b = 10;
            CGRect rect = CGRectMake(100, 12, 123, 54);
            NSValue *value = [testClass performSelectorClassMethod:@"eee:fff:ggg:" parameter:&a,&b,&rect, nil].returnValue;
            NSLog(@"(|-.-|) %@",value);
        }
        {
            NSString *a = @"B";
            float b = 100.666f;
            void(^block)(NSString *) = ^(NSString *str){
                NSLog(@"(|-.-|) block返回 %@",str);
            };
            NSString *str = [testClass performSelectorClassMethod:@"str:num:block:" parameter:&a,&b,&block, nil].returnValue;
            NSLog(@"(|-.-|) %@",str);
            
        }
        {
            NSString *a = @"C";
            int b = 200;
            NSString *c = @"D";
            [testClass performSelectorClassMethod:@"fff:ggg:hhh:" parameter:&a,&b,&c, nil];
            
        }

        NSObject *instance = [testClass performSelectorClassMethod:@"shareInstance" parameter:nil].returnValue;
        if (instance) {
            {
                NSString *a = [instance performSelectorInstanceMethod:@"abc" parameter:nil].returnValue;
                NSLog(@"(|-.-|) %@",a);
                NSNumber *b = [instance performSelectorInstanceMethod:@"ccc" parameter:nil].returnValue;
                NSLog(@"(|-.-|) %@",b);
                [instance performSelectorInstanceMethod:@"doSomething" parameter:nil];
            }
            {
                double a = 88.1234;
                NSString *b = @"kkk";
                char c = 'F';
                id obj = [instance performSelectorInstanceMethod:@"doSomethingWithNum:str:cstr:" parameter:&a,&b,&c,nil].returnValue;
                NSLog(@"(|-.-|) %@",obj);
            }
            {
                double a = 989357.234234;
                NSString *b = @"person";
                char c = 'L';
                void(^block)(NSString *,double,char);
                block = ^(NSString *str,double num,char s){
                    NSLog(@"(|-.-|) block %f--%@--%c",num,str,s);
                };
                [instance performSelectorInstanceMethod:@"doSomethingWithNum:str:cstr:block:" parameter:&a,&b,&c,&block, nil];
            }
 
        }
    }
}
@end
