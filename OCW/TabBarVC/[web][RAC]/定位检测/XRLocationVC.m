//
//  XRLocationVC.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2023/2/14.
//

#import "XRLocationVC.h"
#import <CoreLocation/CoreLocation.h>
#import <ExternalAccessory/ExternalAccessory.h>
@interface XRLocationVC ()<CLLocationManagerDelegate>


@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)CLLocationManager *locationManager;
@end

@implementation XRLocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //是否有外接设备
    if([EAAccessoryManager sharedAccessoryManager].connectedAccessories.count>0){
        
    }
    
    [self.view addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.locationManager requestWhenInUseAuthorization];
    
    //[self.locationManager requestLocation];
    
    [self.locationManager startUpdatingLocation];
    

    
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    //暂不讨论hook此代理方法的方案
    //判断location是否真实可用
    
    
    NSLog(@"---- %@",locations);
    
    if (locations.count) {
        CLLocation *currentLocation = locations.firstObject;
        
        //纬度
        CLLocationDegrees  lat                = currentLocation.coordinate.latitude;
        //经度
        CLLocationDegrees  log                = currentLocation.coordinate.longitude;
        //海拔
        CLLocationDistance altitude           = currentLocation.altitude;
        //垂直精度
        CLLocationAccuracy verticalAccuracy   = currentLocation.verticalAccuracy;
        //水平精度
        CLLocationAccuracy horizontalAccuracy = currentLocation.horizontalAccuracy;
        //时间
        NSDate             *time              = currentLocation.timestamp;
        //楼层
        NSInteger          floor              = currentLocation.floor.level;
        
        
        //方向
        CLLocationDirection course = currentLocation.course;
        if (@available(iOS 13.4, *)) {
            //CLLocationDirectionAccuracy courseAccuracy = currentLocation.courseAccuracy;
        }
        //速度
        CLLocationSpeed speed = currentLocation.speed;
        if (@available(iOS 13.0, *)) {
            //CLLocationSpeedAccuracy speedAccuracy = currentLocation.speedAccuracy;
        }
        
        //位置来源
        if (@available(iOS 15.0, *)) {
            NSLog(@"定位来源 %@ 由软件模拟器生成",currentLocation.sourceInformation.isSimulatedBySoftware ? @"是" : @"不是");
            NSLog(@"定位来源 %@ CarPlay或MFi配件",currentLocation.sourceInformation.isProducedByAccessory ? @"是" : @"不是");
        }
        
        
        NSString *loca = [NSString stringWithFormat:@"纬度%.14f\n经度%.14f\n水平精度%f\n垂直精度%f\n海拔%f\n course%f\n速度%f\n楼层%ld\n时间%@",lat,log,horizontalAccuracy,verticalAccuracy,altitude,course,speed,floor,time];
        
        self.label.text = loca;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [manager stopUpdatingLocation];
        });
        
    }
    
    
    
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    NSLog(@"定位失败了");
}

- (CLLocationManager *)locationManager{
    if(!_locationManager){
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return _locationManager;
}
- (UILabel *)label{
    if(!_label){
        _label = [UILabel new];
        _label.textColor = UIColor.blackColor;
        _label.font = [UIFont boldSystemFontOfSize:18];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.numberOfLines = 0;
    }
    return _label;
}


//hook工具的一种
+(NSInteger)hasDobby{
    NSInteger ret = 0;
#if __has_include(<Dobby/dobby.h>)
    ret = 1;
#endif
    Class cls = NSClassFromString(@"dobby");
    if(cls){
        ret = 1;
    }
    return ret;
}



@end
