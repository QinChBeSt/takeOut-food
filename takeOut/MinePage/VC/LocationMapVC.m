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
#import "ZHPlaceInfoModel.h"
#import "CellForMyNearSpace.h"
@interface LocationMapVC ()<MKMapViewDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate>
@property (nonatomic , strong)UIView *naviView;
@property(nonatomic,strong) NSMutableArray *searchResultArray;
@property(nonatomic,strong) NSMutableArray *nearSpaceArray;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UITableView *nearTableView;
@property (nonatomic , strong)UIView *grayView;
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
    UITextField *loactionLabel;
}
-(NSMutableArray *)nearSpaceArray{
    if (_nearSpaceArray == nil) {
        _nearSpaceArray = [NSMutableArray array];
    }
    return _nearSpaceArray;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    _returnKeyHander = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
//    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNaviView];
    [self initMap];
    [self initTableView];
    [self crateTableViewNeat];
    
    

}

#pragma mark - ui
-(void)initTableView
{
     __weak typeof(self) ws = self;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.hidden = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = YES;
    self.tableView.backgroundColor = [UIColor whiteColor];
    UIView *tableFootView = [[UIView alloc]init];
    self.tableView.tableFooterView = tableFootView;
    tableFootView.backgroundColor = [UIColor orangeColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(maMapView);
        make.top.equalTo(maMapView) ;
        make.left.equalTo(maMapView);
        make.bottom.equalTo(self.view);
    }];

    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    tapGesturRecognizer.delegate = self;
    [self.tableView addGestureRecognizer:tapGesturRecognizer];
}

-(void)crateTableViewNeat{
    self.nearTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.nearTableView.hidden = NO;
    self.nearTableView.delegate = self;
    self.nearTableView.dataSource = self;
    self.nearTableView.scrollEnabled = YES;
    self.nearTableView.backgroundColor = [UIColor whiteColor];
    UIView *tableFootView = [[UIView alloc]init];
    self.nearTableView.tableFooterView = tableFootView;
    tableFootView.backgroundColor = [UIColor orangeColor];

    [self.view addSubview:self.nearTableView];
    [self.nearTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(maMapView);
        make.height.equalTo(@(SCREENH_HEIGHT * 0.4)) ;
        make.left.equalTo(maMapView);
        make.bottom.equalTo(self.view);
    }];
}
-(void)tapAction

{
    
    
    [self.view endEditing:YES];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UITableView class]]) {
        return YES;
    }
    
    return  NO;
}
#pragma mark- UITabelViewDataSource/delegat
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.nearTableView) {
        return self.nearSpaceArray.count;
    }else{
        return self.searchResultArray.count;
    }
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.nearTableView) {
        CellForMyNearSpace *cell1 = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell1"];
        if(cell1 == nil)
        {
            cell1 = [[CellForMyNearSpace alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell1"];
        }
        ZHPlaceInfoModel *model = [self.nearSpaceArray objectAtIndex:indexPath.row];
        cell1.titLab.text = [ NSString stringWithFormat:@"%@",model.name];
        if (indexPath.row == 0) {
            cell1.titLab.textColor = [UIColor colorWithHexString:BaseYellow];
        }
        cell1.subLab.text = [ NSString stringWithFormat:@"%@",model.thoroughfare];
        
        cell1.selectionStyle =UITableViewCellSelectionStyleNone;
        
        
        return cell1;

    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if(cell == nil)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        }
        CLPlacemark *placemark = [self.searchResultArray objectAtIndex:indexPath.row];
        NSLog(@",地名：%@",placemark.name);
        cell.textLabel.text = placemark.name;
        
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }
    
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.nearTableView) {
        ZHPlaceInfoModel *model = [self.nearSpaceArray objectAtIndex:indexPath.row];
        
        locationStr = [NSString stringWithFormat:@"%@,%@",model.name,model.thoroughfare];
        [self save];
        
    }else{
        CLPlacemark *placemark = [self.searchResultArray objectAtIndex:indexPath.row];
        loactionLabel.text =placemark.name;
        locationStr =placemark.name;
        [self save];
        self.tableView.hidden = YES;
        self.nearTableView.hidden = NO; maMapView.region=MKCoordinateRegionMake(CLLocationCoordinate2DMake(placemark.location.coordinate.latitude, placemark.location.coordinate.longitude), MKCoordinateSpanMake(0.01, 0.01));
    }
    
   
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
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
    titleView.backgroundColor = [UIColor colorWithHexString:BaseBackgroundGray];
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
    cityName.numberOfLines = 2;
    cityName.font = [UIFont systemFontOfSize:16];
    cityName.textAlignment = NSTextAlignmentCenter;
    [titleView addSubview:cityName];
    [cityName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(locationIcon.mas_right).offset(5);
        make.centerY.equalTo(titleView);
        make.width.equalTo(@(SCREEN_WIDTH / 5));
    }];
    
    UIView *loactionBackView = [[UIView alloc]init];
    loactionBackView.backgroundColor = [UIColor colorWithHexString:@"E8E8E8"];
    [titleView addSubview:loactionBackView];
    [loactionBackView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cityName.mas_right).offset(5);
        make.centerY.equalTo(titleView);
        make.right.equalTo(titleView.mas_right).offset(-10);
        make.height.equalTo(@(40));
    }];
   
    
    loactionLabel = [[UITextField alloc]init];
    loactionLabel.font = [UIFont systemFontOfSize:12];
    loactionLabel.backgroundColor = [UIColor colorWithHexString:@"E8E8E8"];
    loactionLabel.textAlignment = NSTextAlignmentLeft;
    //loactionLabel.numberOfLines = 2;
    [loactionLabel addTarget:self action:@selector(loactionLabelDidChange:) forControlEvents:UIControlEventEditingChanged];
    loactionLabel.placeholder = ZBLocalized(@"请输入您的地址", nil);
    loactionLabel.delegate = self;
    [titleView addSubview:loactionLabel];
    [loactionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cityName.mas_right).offset(10);
        make.centerY.equalTo(titleView);
        make.right.equalTo(titleView.mas_right).offset(-15);
        make.height.equalTo(@(40));
    }];
    
}
-(void)loactionLabelDidChange :(UITextField *)theTextField{
    if (theTextField.text.length > 0) {
        self.tableView.hidden = NO;
        self.nearTableView.hidden = YES;
        CLGeocoder *geocoder=[[CLGeocoder alloc]init];
        
        NSString *addressStr = [NSString stringWithFormat:@"%@%@",currentCity,theTextField.text];//位置信息
        
        [geocoder geocodeAddressString:addressStr completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (error!=nil || placemarks.count==0) {
                return ;
            }
            
            self.searchResultArray = [[NSMutableArray alloc]initWithArray:placemarks];
            [self.tableView reloadData];
           
            //        //创建placemark对象
            //        CLPlacemark *placemark=[placemarks firstObject];
            //        //经度
            //        NSString *longitude =[NSString stringWithFormat:@"%f",placemark.location.coordinate.longitude];
            //        //纬度
            //        NSString *latitude =[NSString stringWithFormat:@"%f",placemark.location.coordinate.latitude];
            //
            //
            //        NSLog(@"经度：%@，纬度：%@,地名：%@",longitude,latitude,placemark.name);
            //        NSLog(@"详细地址1：%@",addressStr);
            //        NSLog(@"详细地址2：%@",placemark.addressDictionary);
            //        NSLog(@"详细地址3：%@",placemark.locality);
            //
        }];
    }else {
        self.tableView.hidden = YES;
        self.nearTableView.hidden = NO;
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.grayView.hidden = NO;
    
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.grayView.hidden = YES;
}
-(void)initMap{
    maMapView=[[MKMapView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 50, SCREEN_WIDTH, SCREENH_HEIGHT-SafeAreaTopHeight - 50 - SCREENH_HEIGHT * 0.4)];
    [self.view addSubview:maMapView];
    //设置代理
    maMapView.delegate=self;
    //请求定位服务
    locationManager=[[CLLocationManager alloc]init];
    if(![CLLocationManager locationServicesEnabled]||[CLLocationManager authorizationStatus]!=kCLAuthorizationStatusAuthorizedWhenInUse){
        [locationManager requestWhenInUseAuthorization];
    }
    locationManager.desiredAccuracy = 100;
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
    
    self.grayView = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 50, SCREEN_WIDTH, SCREENH_HEIGHT-SafeAreaTopHeight - 50 - SCREENH_HEIGHT * 0.4)];
    self.grayView.backgroundColor = [UIColor colorWithHexString:BaseTextGrayColor alpha:0.5];
    [self.view addSubview:self.grayView];
    
    self.grayView.hidden = YES;
};

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    MKCoordinateRegion region;
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    CLLocationCoordinate2D centerCoordinate = mapView.region.center;
    region.center= centerCoordinate;
    
    NSLog(@"====================== regionDidChangeAnimated %f,%f",centerCoordinate.latitude, centerCoordinate.longitude);
    
    CLLocation *location=[[CLLocation alloc]initWithLatitude:centerCoordinate.latitude longitude:centerCoordinate.longitude];
   
    MKCoordinateRegion regionaaa = MKCoordinateRegionMakeWithDistance(centerCoordinate,100, 100);
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc]init];
    request.region = regionaaa;
    request.naturalLanguageQuery = @"Restaurants";
    MKLocalSearch *localSearch = [[MKLocalSearch alloc]initWithRequest:request];
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error){
        if (!error) {
            [self getAroundInfomation:response.mapItems];
            
        }else{
            //do something.
        }
    }];
    
    
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
           // loactionLabel.text = locationStr;
            
        }
        
    }];
    
}
-(void)getAroundInfomation:(NSArray *)array
{
    [self.nearSpaceArray removeAllObjects];
    for (MKMapItem *item in array) {
        MKPlacemark * placemark = item.placemark;
        ZHPlaceInfoModel *model = [[ZHPlaceInfoModel alloc]init];
        model.name = placemark.name;
        model.thoroughfare = placemark.thoroughfare;
        model.subThoroughfare = placemark.subThoroughfare;
        model.city = placemark.locality;
        model.coordinate = placemark.location.coordinate;
        [self.nearSpaceArray addObject:model];
      
    }
    [self.nearTableView reloadData];
}


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:locationStr]) {
        
        textView.text = @"";
        maMapView.userTrackingMode=MKUserTrackingModeNone;
        
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length <1) {
        textView.text = locationStr;
    }
    
    
}
- (void)textViewDidChange:(UITextView *)textView
{
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    
    NSString *addressStr = textView.text;//位置信息
    
    [geocoder geocodeAddressString:addressStr completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error!=nil || placemarks.count==0) {
            return ;
        }
        
        self.searchResultArray = [[NSMutableArray alloc]initWithArray:placemarks];
        [self.tableView reloadData];
        if (self.searchResultArray.count != 0) {
            self.tableView.hidden = NO;
        }else{
            self.tableView.hidden = YES;
        }
//        //创建placemark对象
//        CLPlacemark *placemark=[placemarks firstObject];
//        //经度
//        NSString *longitude =[NSString stringWithFormat:@"%f",placemark.location.coordinate.longitude];
//        //纬度
//        NSString *latitude =[NSString stringWithFormat:@"%f",placemark.location.coordinate.latitude];
//
//
//        NSLog(@"经度：%@，纬度：%@,地名：%@",longitude,latitude,placemark.name);
//        NSLog(@"详细地址1：%@",addressStr);
//        NSLog(@"详细地址2：%@",placemark.addressDictionary);
//        NSLog(@"详细地址3：%@",placemark.locality);
//
    }];
}
//- (void)fetchNearbyInfo:(CLLocationDegrees )latitude andT:(CLLocationDegrees )longitude
//
//{
//
//    CLLocationCoordinate2D location=CLLocationCoordinate2DMake(latitude, longitude);
//
//    MKCoordinateRegion region=MKCoordinateRegionMakeWithDistance(location, 1 ,1 );
//
//    MKLocalSearchRequest *requst = [[MKLocalSearchRequest alloc] init];
//    requst.region = region;
//    requst.naturalLanguageQuery = @"place"; //想要的信息
//    MKLocalSearch *localSearch = [[MKLocalSearch alloc] initWithRequest:requst];
//   // [self.dataRrray removeAllObjects];
//    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error){
//        if (!error)
//        {
//
//            for (MKMapItem *map in response.mapItems) {
//                NSLog(@"%@",map.name);
//            }
////            [self.dataRrray addObjectsFromArray:response.mapItems];
////            [self.tableView reloadData];
//            //
//        }
//        else
//        {
//            //
//        }
//    }];
//}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
   
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
