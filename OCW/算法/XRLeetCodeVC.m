//
//  XRLeetCodeVC.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2023/3/1.
//

#import "XRLeetCodeVC.h"

@interface XRLeetCodeVC ()

@end

@implementation XRLeetCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.groupTableViewBackgroundColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self maoPaoPaiXu];
}

-(void)maoPaoPaiXu{
    //顺序比较两者大小，如果后者小于前者，就交换位置
    
    int x = arc4random()%10 + 10;
    
    int arr[x];
    
    for (int i = 0; i < x; i++) {
        arr[i] = arc4random()%100;
    }
    
    unsigned long len = sizeof(arr)/sizeof(arr[0]);
    
    for (int i = 0 ; i < len; i++) {
        
        for (int j = 0; j < (len - 1 - i); j++) {
            
            int a = arr[j];
            
            int b = arr[j+1];
            
            if(a>b){
                
                arr[j] = b;
                
                arr[j+1] = a;
                
            }
        }
    }
    
    
    
}
// 生成随机整数
- (int)getRandomInt:(int)from to:(int)to {
    return (int)(from + (arc4random() % (to - from + 1)));
}

// 生成随机浮点数
- (float)getRandomFloat:(float)from to:(float)to {
    float diff = to - from;
    return (((float) arc4random() / UINT_MAX) * diff) + from;
}
@end
