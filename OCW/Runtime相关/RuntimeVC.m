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
    
    NSObject *person = [[NSClassFromString(@"Person") alloc]init];
    
    [person addObserver:self forKeyPath:@"num" options:NSKeyValueObservingOptionNew context:nil];
    

 
    
    
    
    
    
   // [XRTool logPropertyOfClass:[UIButton class]];
    

    CFRunLoopRef runloop = CFRunLoopGetCurrent();

       
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    NSLog(@"123");
    
}
    - (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
        
        //NSString *a = [NSString stringWithFormat:@"[%s] %s [%d行]",__TIMESTAMP__,__func__,__LINE__];
        

        
        //第一种 正常的
//        NSObject *xrp = [[NSClassFromString(@"XRPerson") alloc]init];
//
//        if (xrp && [xrp respondsToSelector:@selector(name)]) {
//            NSString *name = [xrp performSelector:@selector(name)];
//            NSLog(@"默认值xrperson-name = %@",name);
//            [xrp setValue:@"小亮" forKey:@"name"];
//            NSString *name2 = [xrp performSelector:@selector(name)];
//            NSLog(@"修改后xrperson-name = %@",name2);
//        }
//        if (xrp && [xrp respondsToSelector:@selector(sex)]) {
//            BOOL sex = [xrp performSelector:@selector(sex)];
//            NSLog(@"默认值xrperson-sex = %d",sex);
//            [xrp setValue:@0 forKey:@"sex"];
//            BOOL sex2 = [xrp performSelector:@selector(sex)];
//            NSLog(@"修改后xrperson-sex = %d",sex2);
//        }



        //第二种 单利
        Class cls = NSClassFromString(@"TYPerson");
        SEL sel = NSSelectorFromString(@"manager");
        id  obj;
        if (cls && [cls respondsToSelector:sel])
        {
            obj = [cls performSelector:sel];
        }

//        if (obj && [obj respondsToSelector:@selector(name)]) {
//            NSString *tyname = [obj performSelector:@selector(name)];
//            NSLog(@"默认值typerson-name = %@",tyname);
//            //修改
//            if ([obj respondsToSelector:@selector(updateName:)]) {
//
//                for (int i = 0 ; i < 5; i ++) {
//                    [obj performSelector:@selector(updateName:) withObject:[NSString stringWithFormat:@"小红-%d",i]];
//                    NSString *tyname2 = [obj performSelector:@selector(name)];
//                    NSLog(@"修改后typerson-name = %@",tyname2);
//                }
//            }
//        }
//        if (obj && [obj respondsToSelector:@selector(sex)]) {
//            BOOL tysex = [obj performSelector:@selector(sex)];
//            NSLog(@"默认值typerson-sex = %d",tysex);
//
//            //修改
//            [[TYPerson manager]updateSEX:YES];
//            if ([obj respondsToSelector:@selector(updateSEX:)]) {
//                //[obj performSelector:@selector(updateSEX:) withObject:@1];
//                BOOL tysex2 = [obj performSelector:@selector(sex)];
//                NSLog(@"修改后typerson-sex = %d",tysex2);
//
//            }
//
//        }
        
        //修改
        [[TYPerson manager]updateAgree:YES];

        //特殊类型 仿照问题的写法
//        if (obj && [obj respondsToSelector:@selector(isAgree)]) {
//            BOOL isAgree = [obj performSelector:@selector(isAgree)];
//            NSLog(@"默认值typerson-isAgree = %d",isAgree);
//
//            if ([obj respondsToSelector:@selector(updateAgree:)]) {
//                //[obj performSelector:@selector(updateAgree:) withObject:@2];
//                //[obj performSelectorOnMainThread:@selector(updateAgree:) withObject:@10 waitUntilDone:YES];
 //       objc_msgSend(obj,@selector(updateAgree:),NO);
//                [obj setValue:@YES forKeyPath:@"isAgree"];
//
                //BOOL isAgree2 = [obj performSelector:@selector(isAgree)];
    //    id isAgree3 = [obj valueForKeyPath:@"isAgree"];
     //   NSLog(@"修改后typerson-isAgree = %d",[isAgree3 boolValue]);
//
//            }
//
//        }
//
        
        
        
        
    }

@end
