//
//  CLLocation+XRLocation.h
//  OCW
//
//  Created by ext.wangxiaoran3 on 2023/2/17.
//

#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN


typedef enum : NSUInteger {
    // 真实世界数据源
    LocationDataSourceRealWorld,
    // 外设数据源 （如果MFI设备和使用gpx原理相同，则可以统一返回，待验证）
    LocationDataSourceMFIDevice,
    /*
     拔掉外设，此时经纬度信息有可能恢复正常，但此时horizontalAccuracy数值会变得很大。
     这种情况下也可以认定当前坐标不能反映真实世界坐标
     */
    LocationDataSourceLowAccuracy,
} LocationDataSource;

@interface CLLocation (XRLocation)
- (LocationDataSource)dataSource;
- (NSString*)dataSourceDescription;
@end

NS_ASSUME_NONNULL_END
