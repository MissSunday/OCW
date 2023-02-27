//
//  XRLocationVC.m
//  OCW
//
//  Created by ext.wangxiaoran3 on 2023/2/14.
//

#import "XRLocationVC.h"
#import <CoreLocation/CoreLocation.h>
#import "CLLocation+XRLocation.h"
#import "XRLocationHook.h"

#import "XRRunTime.h"
@interface XRLocationVC ()<CLLocationManagerDelegate>


@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UILabel *label2;
@property(nonatomic,strong)CLLocationManager *locationManager;
@end

@implementation XRLocationVC

- (void)viewDidLoad {
    [super viewDidLoad];

 
    NSArray *a = [XRLocationHook checkCLLocationDetectApis];
    NSArray *b = [XRLocationHook checkCLLocationManagerDetectApis];
    NSArray *c = [XRLocationHook checkCLLocationSourceInformationDetectApis];
    
    NSLog(@"%@ %@ %@",a,b,c);
    
    
    [self.view addSubview:self.label];
    [self.view addSubview:self.label2];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(66);
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
        
       self.label2.text =  [currentLocation locationSourceDescription];
        
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
        
        NSString *loca = [NSString stringWithFormat:@"纬度%@\n经度%@\n水平精度%@\n垂直精度%@\n海拔%@\n course%@\n速度%@\n楼层%ld\n时间%@",@(lat),@(log),@(horizontalAccuracy),@(verticalAccuracy),@(altitude),@(course),@(speed),floor,time];
        //位置来源
        if (@available(iOS 15.0, *)) {
            
            NSString *source1 = [NSString stringWithFormat:@"定位来源 %@ 由软件模拟器生成",currentLocation.sourceInformation.isSimulatedBySoftware ? @"是" : @"不是"];
            
            NSLog(@"%@",source1);
            
            NSString *source2 = [NSString stringWithFormat:@"定位来源 %@ CarPlay或MFi配件",currentLocation.sourceInformation.isProducedByAccessory ? @"是" : @"不是"];
            
            NSLog(@"%@",source2);
            
            loca = [loca stringByAppendingFormat:@"\n%@\n%@",source1,source2];
        }
        
        self.label.text = loca;
        
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [manager stopUpdatingLocation];
        });
        
    }
    
    
    
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    NSLog(@"定位失败了");
    self.label2.text = [manager.location locationSourceDescription];
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
- (UILabel *)label2{
    if(!_label2){
        _label2 = [UILabel new];
        _label2.textColor = UIColor.blackColor;
        _label2.font = [UIFont boldSystemFontOfSize:18];
        _label2.textAlignment = NSTextAlignmentCenter;
        _label2.numberOfLines = 0;
    }
    return _label2;
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
