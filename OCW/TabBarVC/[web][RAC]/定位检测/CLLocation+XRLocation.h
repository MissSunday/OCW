//
//  CLLocation+XRLocation.h
//  OCW
//
//  Created by ext.wangxiaoran3 on 2023/2/17.
//

#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LocationSource) {
    
    //正常定位
    LocationSourceNormal = 0,
    
    //外设传入的定位 MFi设备检测CLLocationManager最好设置为kCLLocationAccuracyBest，否则代理方法返回失败
    LocationSourceMFiOrCarPlay,
    
    //通过修改GPX得到的定位，包括xcode使用GPX和爱思助手等工具的模拟定位
    LocationSourceGPX,
    
    /*
     水平精度过大
     使用GPX修改定位后取消使用，但此时horizontalAccuracy数值会变得很大。
     虽然精度不对，但是坐标是准确的
     */
    LocationSourceLowAccuracy,
    
    //定位api被hook
    LocationAPIHook,
};
@interface CLLocation (XRLocation)

- (LocationSource)locationSourceInfo;

- (NSString *)locationSourceDescription;

@end

NS_ASSUME_NONNULL_END
