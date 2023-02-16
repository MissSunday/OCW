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
        CLLocation *firstLoca = locations.firstObject;
        
        CLLocationDegrees lat =  firstLoca.coordinate.latitude;
        CLLocationDegrees log = firstLoca.coordinate.longitude;
        
        CLLocationAccuracy verticalAccuracy = firstLoca.verticalAccuracy;
        CLLocationAccuracy horizontalAccuracy = firstLoca.horizontalAccuracy;
        
        
        CLLocationDistance altitude = firstLoca.altitude;
        
        NSLog(@"%f\n%f\n%f\n海拔 %f",lat,log,verticalAccuracy,altitude);
        
        NSString *loca = [NSString stringWithFormat:@"%.14f\n%.14f\n%f\n%f\n%f",lat,log,horizontalAccuracy,verticalAccuracy,altitude];
        
        self.label.text = loca;
        
        
        [manager stopUpdatingLocation];
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
