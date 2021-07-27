//
//  TZImagePickerItem.h
//  OCW
//
//  Created by 朵朵 on 2021/7/27.
//

#import <UIKit/UIKit.h>
@class TZImagePickerItemModel;
NS_ASSUME_NONNULL_BEGIN

@interface TZImagePickerItem : UICollectionViewCell
@property(nonatomic,strong)UIImageView *imageV;
@property(nonatomic,strong)TZImagePickerItemModel *model;
@property(nonatomic,strong)UIButton *deleteBtn;
@property(nonatomic,strong)RACSubject *subject;
@end

NS_ASSUME_NONNULL_END
