//
//  CLLocation+XRLocation.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2023/2/17.
//

#import "CLLocation+XRLocation.h"
#import <ExternalAccessory/ExternalAccessory.h>

#define LocationDataSourceLowAccuracyValue 1200
//多次测试结果1400  设置成1200吧
@implementation CLLocation (XRLocation)
- (LocationDataSource)dataSource
{
    double latitude = self.coordinate.latitude; //纬度
    double longtitude = self.coordinate.longitude; //经度
    double altitude = self.altitude; //海拔
    CLLocationAccuracy vertAcc = self.verticalAccuracy;//垂直精度
    CLLocationAccuracy horiAcc = self.horizontalAccuracy;//水平精度
    
    NSString* lati74 = [self floatValue:latitude from:8 length:4];
    NSString* long74 = [self floatValue:longtitude from:8 length:4];
    NSString* alti15 = [self floatValue:altitude from:1 length:5];
    
    BOOL lati_b = [self isSameValueString:lati74];
    BOOL long_b = [self isSameValueString:long74];
    BOOL alti_b = [self isSameValueString:alti15];
    
    if(lati_b == long_b == alti_b == TRUE){
        
        return LocationDataSourceMFIDevice;
    }
    
    if(self.horizontalAccuracy > LocationDataSourceLowAccuracyValue){
        //水平精度很大
        return LocationDataSourceLowAccuracy;
    }
        
    return LocationDataSourceRealWorld;
}

- (NSString*)dataSourceDescription{
    LocationDataSource source = [self dataSource];
    switch (source) {
        case LocationDataSourceMFIDevice:
            return @"LocationDataSourceMFIDevice";
        case LocationDataSourceLowAccuracy:
            return @"LocationDataSourceLowAccuracy";
        case LocationDataSourceRealWorld:
            return @"LocationDataSourceRealWorld";
        default:
            return @"oh";
    }
}

- (NSString*)floatValue:(double)value from:(int)start length:(int)len{
    
    NSString* floatString = [NSString stringWithFormat:@"%.14f",value];
    NSLog(@"----   %@",floatString);
    
    floatString = [[floatString componentsSeparatedByString:@"."] lastObject];
    NSLog(@"----   %@",floatString);
    
    NSString *ret = [floatString substringWithRange:NSMakeRange(start, len)];
    NSLog(@"ret ---- %@",ret);
    return ret;
}

- (BOOL)isSameValueString:(NSString*)str{
    int len = (int)[str length];
    int value = [str intValue];
    
    int v = value%10;
    for(int i=1; i<len; i++){
        value = value / 10;
        if(value%10 != v) return false;
    }
    return true;
}
@end
