//
//  ShopMapLoactionView.m
//  takeOut
//
//  Created by mac on 2018/4/19.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "ShopMapLoactionView.h"
#import <MapKit/MapKit.h>
@interface ShopMapLoactionView ()<MKMapViewDelegate>
@property (nonatomic , strong)UIView *naviView;
@end

@implementation ShopMapLoactionView{
    MKMapView *mapView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNaviView];
    
    mapView =[[MKMapView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREENH_HEIGHT - SafeAreaTopHeight)];
    //设置代理
    mapView.delegate=self;
    //设置位置
    double lo = [self.langStr doubleValue];
    double la = [self.latStr doubleValue];
    mapView.region=MKCoordinateRegionMake(CLLocationCoordinate2DMake(la, lo), MKCoordinateSpanMake(0.01, 0.01));
    mapView.mapType=MKMapTypeStandard;

    //初始化一个大头针类
    MKPointAnnotation * ann = [[MKPointAnnotation alloc]init];
    //设置大头针坐标
    ann.coordinate=CLLocationCoordinate2DMake(la, lo);
    ann.title=self.name;
    ann.subtitle=self.add;
    [mapView addAnnotation:ann];
    [self.view addSubview:mapView];
}
#pragma mark - ui
-(void)createNaviView{
    self.view.backgroundColor = [UIColor whiteColor];
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
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = NSLocalizedString(@"地址", nil);
    titleLabel.textColor = [UIColor blackColor];
    [self.naviView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.centerY.equalTo(backImg);
    }];
}
#pragma mark - 点击事件
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
