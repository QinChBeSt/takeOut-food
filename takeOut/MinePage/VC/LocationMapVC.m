//
//  LocationMapVC.m
//  takeOut
//
//  Created by mac on 2018/4/3.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "LocationMapVC.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface LocationMapVC ()<MKMapViewDelegate>
@property (nonatomic , strong)UIView *naviView;
@end

@implementation LocationMapVC
{
    CLLocationManager *   locationManager;
    MKMapView         *   maMapView;
    NSString *currentCity;//当前城市
    NSString *locationStr;
    NSString *getlatitude;
    NSString *getlongitude;
    
    UILabel *cityName;
    UILabel *loactionLabel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNaviView];
    [self initMap];
}
#pragma mark - ui
-(void)createNaviView{
    self.naviView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SafeAreaTopHeight )];
    self.naviView.backgroundColor = [UIColor colorWithHexString:BaseYellow];
    [self.view addSubview:self.naviView];
    
    __weak typeof(self) ws = self;
    UIImageView *backImg = [[UIImageView alloc]init];
    [backImg setImage:[UIImage imageNamed:@"back_black"]];
    [self.naviView addSubview:backImg];
    [backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.naviView.mas_top).offset(SafeAreaStatsBarHeight + 5);
        make.left.equalTo(ws.naviView.mas_left).offset(15);
        make.width.equalTo(@(30));
        make.height.equalTo(@(30));
    }];
    
    UIButton *backBTN = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBTN addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.naviView addSubview:backBTN];
    [backBTN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.naviView.mas_top).offset(SafeAreaStatsBarHeight);
        make.left.equalTo(ws.naviView.mas_left).offset(10);
        make.width.equalTo(@(40));
        make.height.equalTo(@(SafeAreaTopHeight - SafeAreaStatsBarHeight));
    }];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:ZBLocalized(@"保存", nil) forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [self.naviView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backImg);
        make.right.equalTo(ws.naviView.mas_right).offset(-20);
    }];
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight , SCREEN_WIDTH, 50)];
    [self.view addSubview:titleView];
    
    UIImageView *locationIcon = [[UIImageView alloc]init];
    [locationIcon setImage:[UIImage imageNamed:@"ic_point"]];
    [titleView addSubview:locationIcon];
    [locationIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleView.mas_left).offset(10);
        make.centerY.equalTo(titleView);
        make.width.equalTo(@(10));
        make.height.equalTo(@(15));
    }];
    
    cityName = [[UILabel alloc]init];
    cityName.font = [UIFont systemFontOfSize:16];
    cityName.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:cityName];
    [cityName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(locationIcon.mas_right).offset(5);
        make.centerY.equalTo(titleView);
        make.width.equalTo(@(SCREEN_WIDTH / 5));
    }];
    
    loactionLabel = [[UILabel alloc]init];
    loactionLabel.font = [UIFont systemFontOfSize:12];
    loactionLabel.backgroundColor = [UIColor colorWithHexString:@"E8E8E8"];
    loactionLabel.textAlignment = NSTextAlignmentCenter;
    loactionLabel.numberOfLines = 2;
    [titleView addSubview:loactionLabel];
    [loactionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cityName.mas_right).offset(5);
        make.centerY.equalTo(titleView);
        make.right.equalTo(titleView.mas_right).offset(-10);
        make.height.equalTo(@(45));
    }];
    
}

-(void)initMap{
    maMapView=[[MKMapView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 50, SCREEN_WIDTH, SCREENH_HEIGHT-SafeAreaTopHeight - 50)];
    [self.view addSubview:maMapView];
    //设置代理
    maMapView.delegate=self;
    //请求定位服务
    locationManager=[[CLLocationManager alloc]init];
    if(![CLLocationManager locationServicesEnabled]||[CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedWhenInUse){
        [locationManager requestWhenInUseAuthorization];
    }
    //用户位置追踪(用户位置追踪用于标记用户当前位置，此时会调用定位服务)
    maMapView.userTrackingMode = MKUserTrackingModeFollow;
    //设置地图类型
    maMapView.mapType=MKMapTypeStandard;
    
    UIImageView *locIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"map_location"]];
    [maMapView addSubview:locIcon];
    [locIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(maMapView);
        make.bottom.equalTo(maMapView.mas_centerY);
        make.width.equalTo(@(20));
        make.height.equalTo(@(40));
    }];
};

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    MKCoordinateRegion region;
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    CLLocationCoordinate2D centerCoordinate = mapView.region.center;
    region.center= centerCoordinate;
    
    NSLog(@"====================== regionDidChangeAnimated %f,%f",centerCoordinate.latitude, centerCoordinate.longitude);
    
    CLLocation *location=[[CLLocation alloc]initWithLatitude:centerCoordinate.latitude longitude:centerCoordinate.longitude];
   
    getlatitude =[NSString stringWithFormat:@"%f",centerCoordinate.latitude];
    getlongitude = [NSString stringWithFormat:@"%f",centerCoordinate.longitude];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        //判断是否有错误或者placemarks是否为空
        if (error !=nil || placemarks.count==0) {
            NSLog(@"%@",error);
            [MBManager showBriefAlert:ZBLocalized(@"定位失败", nil)];
            return ;
        }
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            currentCity = placeMark.locality;
            if (!currentCity) {
                currentCity = ZBLocalized(@"未知城市", nil);
            }
    
            NSString *subLoc = placeMark.subLocality;
            NSString *locName = placeMark.name;
            if (subLoc == nil) {
                subLoc = @"";
            }
            if (locName == nil) {
                locName = @"";
            }
//            NSString *locStr = [NSString stringWithFormat:@"%@%@%@",currentCity,placeMark.subLocality,placeMark.name];

            locationStr = [NSString stringWithFormat:@"%@ %@%@",currentCity,subLoc,locName];
            NSLog(@"%@",locationStr);//具体地址
            cityName.text = currentCity;
            loactionLabel.text = locationStr;
            
        }
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 点击事件
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)save{
    if (self.returnValueBlock) {
        //将自己的值传出去，完成传值
        self.returnValueBlock(locationStr);
    }
    
    if (self.returnlatBlock) {
        self.returnlatBlock(getlatitude);
    }
    
    if (self.returnlongitBlock) {
        self.returnlongitBlock(getlongitude);
    }
    [self back];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
