//
//  POPVC.m
//  OCW
//
//  Created by 王晓冉 on 2021/12/13.
//

#import "POPVC.h"
#import "XRRequest.h"
#import "XRRequestParam.h"
#import "Cat.h"
#import "Dog.h"
@interface POPVC ()

@end

@implementation POPVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    XRRequestParam *param = [XRRequestParam postWithParam:@{@"token":@"gk"} url:@"666"];
    [[XRRequest shareManager]requestWithParam:param complete:^(NSDictionary * _Nonnull response) {
        NSLog(@"%@",response);
    } failed:^(NSDictionary * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
    Cat *cat = [Cat new];
    Dog *dog = [Dog new];
    
    [cat run];
    [dog run];
    
    [dog eat];
    
    [XRTool logMethodNamesOfClass:[Dog class]];
    
    
}



@end
