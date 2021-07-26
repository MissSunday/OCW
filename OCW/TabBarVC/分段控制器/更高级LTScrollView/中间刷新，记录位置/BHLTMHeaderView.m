//
//  BHLTMHeaderView.m
//  OCW
//
//  Created by 朵朵 on 2021/7/26.
//

#import "BHLTMHeaderView.h"
@interface BHLTMHeaderView ()
@property(strong, nonatomic) UILabel *testLabel;
@end
@implementation BHLTMHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

#pragma mark - 布局子视图
-(void)setupSubviews {
    self.backgroundColor = [UIColor blueColor];
    [self addSubview:self.testLabel];
}

-(void)tagGesture:(UITapGestureRecognizer *)gesture {
    NSLog(@"响应事件，回调自己处理吧。");
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {
            UILabel *subLabel = (UILabel *)subView;
            CGPoint convertP = [self convertPoint:point toView:subLabel];
            if (CGRectContainsPoint(subLabel.bounds, convertP)) {
                return YES;
            }
        }
    }
    return NO;
}

-(UILabel *)testLabel {
    if (!_testLabel) {
        _testLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 200, 20)];
        _testLabel.text = @"点击响应事件";
        _testLabel.backgroundColor = [UIColor grayColor];
        _testLabel.textColor = [UIColor whiteColor];
        _testLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagGesture:)];
        [_testLabel addGestureRecognizer:gesture];
    }
    return _testLabel;
}


@end
