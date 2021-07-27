//
//  KNPhotoBrowserItem.m
//  OCW
//
//  Created by 朵朵 on 2021/7/27.
//

#import "KNPhotoBrowserItem.h"

@implementation KNPhotoBrowserItem
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self UI];
    }
    return self;
}
-(void)UI{
    self.contentView.backgroundColor = [UIColor randomColor];
    [self addSubview:self.imageV];
    [self layout];
}
-(void)layout{
    
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];

}
//- (void)setModel:(QJCityModel *)model{
//    _model = model;
//    self.titleL.text = model.cityName;
//}
- (UIImageView *)imageV{
    if (!_imageV) {
        _imageV = [UIImageView new];
    }
    return _imageV;
}
@end
