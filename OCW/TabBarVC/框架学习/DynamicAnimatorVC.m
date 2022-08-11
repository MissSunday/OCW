//
//  DynamicAnimatorVC.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2022/8/3.
//

#import "DynamicAnimatorVC.h"

@interface DynamicAnimatorVC ()

@property(nonatomic,strong)UIView *gravityView;

@end

@implementation DynamicAnimatorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.gravityView];


}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIDynamicAnimator*an = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    UIGravityBehavior *grab = [[UIGravityBehavior alloc]initWithItems:@[_gravityView]];
    [grab setAngle:90 magnitude:10];
    [an addBehavior:grab];
    
}
- (UIView *)gravityView{
    if (!_gravityView) {
        _gravityView = [[UIView alloc]initWithFrame:CGRectMake(100, 200, 50, 60)];
        _gravityView.backgroundColor = [UIColor redColor];
    }
    return _gravityView;
}


@end
