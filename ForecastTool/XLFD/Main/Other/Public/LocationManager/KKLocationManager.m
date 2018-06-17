//
//  KKLocationManager.m
//  Kingkong_ios
//
//  Created by hello on 2018/4/12.
//  Copyright © 2018年 MC. All rights reserved.
//

#import "KKLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface KKLocationManager()<CLLocationManagerDelegate>

@property (nonatomic,strong ) CLLocationManager *locationManager;//定位服务
@property (nonatomic,copy)    NSString *currentCity;//城市
@property (nonatomic,copy)    NSString *strLatitude;//经度
@property (nonatomic,copy)    NSString *strLongitude;//维度
@property (nonatomic,assign)  BOOL alreadyGetLocation;
@property(nonatomic,strong) UIAlertController *alert;

@end

@implementation KKLocationManager

+(instancetype)shareManager{
    
    static dispatch_once_t onceToken;
    static KKLocationManager *manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

-(void)setAlertStausWhenAppBecomeActivie{
    
}

-(void)getLocationInfor{
    if(self.alert){
        [self.alert dismissViewControllerAnimated:NO completion:nil];
        self.alert = nil;
        _alreadyGetLocation = NO;
    }
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        [_locationManager requestAlwaysAuthorization];
        _currentCity = [[NSString alloc]init];
        [_locationManager requestWhenInUseAuthorization];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 5.0;
        [_locationManager startUpdatingLocation];
    }else{
        [self getLocationFailureAction];
    }
}

#pragma mark - 定位失败
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
//    [manager stopUpdatingLocation];
//    NSLog(@"定位错误: %@",[error localizedDescription]);
    [self getLocationFailureAction];
}

-(void)getLocationFailureAction{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"根据相关法律规定您需要打开[定位服务]来确定您的位置是否在中国境内" message:@"请在系统设置中开启定位服务(设置>隐私>定位服务>开启)" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication]openURL:settingURL];
        _alreadyGetLocation = NO;
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self getLocationInfor];
        _alreadyGetLocation = NO;
    }];
    _alert = alert;
    [alert addAction:cancel];
    [alert addAction:ok];
    if(!_alreadyGetLocation){
        [[MCTool getCurrentVC] presentViewController:alert animated:YES completion:nil];
        _alreadyGetLocation = YES;
    }
    
}


#pragma mark - 定位成功
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    [_locationManager stopUpdatingLocation];
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    //当前的经纬度
    NSLog(@"当前的经纬度 %f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    //这里的代码是为了判断didUpdateLocations调用了几次 有可能会出现多次调用 为了避免不必要的麻烦 在这里加个if判断 如果大于1.0就return
    NSTimeInterval locationAge = -[currentLocation.timestamp timeIntervalSinceNow];
    if (locationAge > 1.0){//如果调用已经一次，不再执行
        
        //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
        [manager stopUpdatingLocation];
    }
    
    
    //地理反编码 可以根据坐标(经纬度)确定位置信息(街道 门牌等)
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count >0) {
            
            for (CLPlacemark * placemark in placemarks) {
                
                NSString *city = placemark.locality;
                if (!city) {
                    //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                    city = placemark.administrativeArea;
                }
                NSLog(@"address = %@\n",placemark.name);
                //                NSDictionary *dictionary = [placemark addressDictionary];
                //  Country(国家)  State(省) locality（市） SubLocality(区)
                
                NSString *message = [NSString stringWithFormat:@"%@,%@,%@,%@,%@",placemark.country,city,placemark.subLocality,placemark.thoroughfare,placemark.name];
                NSLog(@"%@",message);
                
                if(!([placemark.country isEqualToString:@"中国"] || [placemark.country isEqualToString:@"China"] || [placemark.country isEqualToString:@"中華人民共和國"])){
                     [self getLocationFailureAction];
                }
                
//                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
//                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//                }];
//                [alert addAction:ok];
//                if(!_alreadyGetLocation){
//                    [[MCTool getCurrentVC] presentViewController:alert animated:YES completion:nil];
//                    _alreadyGetLocation = YES;
//                }
            }
        }else if (error == nil && placemarks.count){
            
            NSLog(@"NO location and error return");
        }else if (error){
            
            NSLog(@"loction error:%@",error);
        }
    }];
    

}

@end
