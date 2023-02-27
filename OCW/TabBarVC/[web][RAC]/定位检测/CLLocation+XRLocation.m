//
//  CLLocation+XRLocation.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2023/2/17.
//

#import "CLLocation+XRLocation.h"
#import "XRLocationHook.h"
#define LocationHorizontalAccuracyValue 1200
//多次测试结果1400  设置成1200吧
@implementation CLLocation (XRLocation)

- (LocationSource)locationSourceInfo{
  
    // !!!: 不判断经纬度的精度，因为精度在虚拟定位下可以随意修改，不作为判断条件
    //hook检测  越狱或重签名
    if([XRLocationHook checkCLLocationDetectApis].count || [XRLocationHook checkCLLocationManagerDetectApis].count){
        return LocationAPIHook;
    }else{
        
        if (@available(iOS 15.0, *)) {
            if([XRLocationHook checkCLLocationSourceInformationDetectApis].count){
                return LocationAPIHook;
            }
            if (self.sourceInformation.isProducedByAccessory) {
                return LocationSourceMFiOrCarPlay;
            }else if (self.sourceInformation.isSimulatedBySoftware){
                return LocationSourceGPX;
            }
            if(self.horizontalAccuracy > LocationHorizontalAccuracyValue){
                return LocationSourceLowAccuracy;
            }
            
        }else{
            
            //海拔
            CLLocationDistance altitude           = self.altitude;
            //垂直精度
            CLLocationAccuracy verticalAccuracy   = self.verticalAccuracy;
            //水平精度
            CLLocationAccuracy horizontalAccuracy = self.horizontalAccuracy;
            
            
            
            //gpx判断
            if(verticalAccuracy == -1 && altitude == 0){
                //排除海拔为0的误杀
                if([self calculteDecimalPointWithArgument:horizontalAccuracy] >= 6){
                    if(horizontalAccuracy > LocationHorizontalAccuracyValue){
                        return LocationSourceLowAccuracy;
                    }
                    return LocationSourceNormal;
                }
                if(horizontalAccuracy > LocationHorizontalAccuracyValue){
                    return LocationSourceLowAccuracy;
                }
                return LocationSourceGPX;
            }
            //外设判断
            if(horizontalAccuracy == 5 &&
               [self calculteDecimalPointWithArgument:verticalAccuracy] < 6 &&
               [self calculteDecimalPointWithArgument:altitude] < 6){
                return LocationSourceMFiOrCarPlay;
            }
            
            
        }
    
    return LocationSourceNormal;
    }
}

-(NSInteger)calculteDecimalPointWithArgument:(double)arg{
    NSString *oriString = [NSString stringWithFormat:@"%@",@(arg)];
    if(oriString){
        NSString *pointString = [[oriString componentsSeparatedByString:@"."] lastObject];
        return pointString.length;
    }
    return 0;
}

- (NSString *)locationSourceDescription{
    LocationSource source = [self locationSourceInfo];
    switch (source) {
        case LocationSourceNormal:
            return @"LocationSourceNormal";
        case LocationSourceMFiOrCarPlay:
            return @"LocationSourceMFiOrCarPlay";
        case LocationSourceGPX:
            return @"LocationDataSourceFromSoftware";
        case LocationSourceLowAccuracy:
            return @"LocationSourceLowAccuracy";
        default:
            return @"locationSourceDescription";
    }
}


//正常定位
//best                        ThreeKilometers
//纬度 39.78373813695559       纬度 39.78369484632358
//经度 116.555455814278        经度 116.5553610955373
//水平精度 135.3333333333333    水平精度 100.2310513937599
//垂直精度 18.42129516601562    垂直精度 20.32384872436523
//海拔 35.52008247375488       海拔 33.52424240112305
//course-1                    course-1
//速度-1                       速度-1
//楼层0                        楼层0

//虚拟定位
//xcode                  爱思助手修改
//纬度 39.66234234223424    纬度 39.949814033
//经度 118.555498451234     经度 116.338161039
//水平精度 5                 水平精度5
//垂直精度-1                 垂直精度-1
//海拔0                     海拔0
//course-1                 course-1
//速度-1                    速度-1
//楼层0                     楼层0

//外设
//纬度 39.63359781666666
//经度 118.1690819666667
//水平精度 5
//垂直精度 9.5
//海拔 69.8
//course26.1
//速度0
//楼层0

// !!!: 虚拟定位特点
// !!!: 1.水平精度都是5 暂时不能验证这个字段是否可以作为判断依据，目前简单使用
// !!!: 2.GPX虚拟定位垂直精度固定为-1，海拔固定为0，暂不确定gpx文件是否可以修改垂直精度和海拔，如果可以，此判断条件作废
// !!!: 3.虚拟定位的水平精度和垂直精度都不如实际定位的精度高，以此判断小数点后位数，可作为一个依据
// !!!: 4.如果正常坐标精度都是整数，此时可以判断其他参数

@end
