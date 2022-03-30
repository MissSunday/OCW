//
//  DataTypeVC.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/3/30.
//

#import "DataTypeVC.h"

@interface DataTypeVC ()

@end

@implementation DataTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSStringFromClass(self.class);
    
    [self enumFunc];
    
    
    char a = 0;
    
    char * c = 'r';
    
    //u_char *b 
}

// !!!: 枚举类型
-(void)enumFunc{
    
    
    self.enumType = enumTypeC;
    
    self.myOption = MyOption1 | MyOption2;
    
    if (self.myOption & MyOption2) {
        NSLog(@"包含 2 类型");
    }
    
    //增加选项
    self.myOption = _myOption | MyOption4;//0011 | 1000 = 1011, 11
    
    //self.myOption |= MyOption4;
    
    //减少选项
    self.myOption = _myOption & (~MyOption4);//1011 & (~1000) = 1011 & 0111 = 0011, 3
    
    //self.myOption &= ~MyOption4;
    
    
    
    
    
    
    
    
    
}

@end
