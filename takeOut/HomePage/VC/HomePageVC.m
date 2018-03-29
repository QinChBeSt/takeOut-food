//
//  HomePageVC.m
//  takeOut
//
//  Created by mac on 2018/3/23.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "HomePageVC.h"
#import <CoreLocation/CoreLocation.h>
#import <SDCycleScrollView.h>

//VC
#import "ShopDetailVC.h"
#import "HomeTypeVC.h"

//VIEW
#import "SortButton.h"
#import "CollectionViewCellForHomePageChoose.h"
#import "TableViewCellForHomepageList.h"

//model
#import "ModelForHomeType.h"
#import "ModelForShopList.h"

#define kHeadAdderssViewHeight 40
#define kHeadSelectViewHeight 150
#define kHeadImageViewHeight 100
#define kHeadCollectionViewHeight SCREEN_WIDTH / 5 * 2

@interface HomePageVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,CLLocationManagerDelegate,SDCycleScrollViewDelegate>
{
    UIView *headviewAddressView;
    UILabel *headviewAddressLabel;
    UIImageView *headviewImageView;
    UIView *headviewSelectView;
    UIImageView *headviewSelectLeftView;
    UIImageView *headviewSelectRightView;
    UIView *sortingView;
    SortButton *clickButton;
}
@property (strong,nonatomic)NSArray *netImages;  //网络图片
@property (strong,nonatomic)SDCycleScrollView *cycleScrollView;//轮播器
@property (nonatomic , strong)UIView *headView;
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)UICollectionView *collectionView;
@property (nonatomic , strong)UIButton *replaceButton;

@property (nonatomic , strong)NSMutableArray *arrForHomePageTypeName;
@property (nonatomic , strong)NSMutableArray *arrForHomePageShopList;
@end

@implementation HomePageVC{
    CLLocationManager *locationmanager;//定位服务
    NSString *currentCity;//当前城市
    NSString *strlatitude;//经度
    NSString *strlongitude;//纬度
}
/**
 *  懒加载网络图片数据
 */
-(NSArray *)netImages{
    
    if (!_netImages) {
        _netImages = [NSArray array];
    }
    return _netImages;
}
-(NSMutableArray *)arrForHomePageTypeName{
    if (_arrForHomePageTypeName == nil) {
        _arrForHomePageTypeName = [NSMutableArray array];
    }
    return _arrForHomePageTypeName;
}
-(NSMutableArray *)arrForHomePageShopList{
    if (_arrForHomePageShopList == nil) {
        _arrForHomePageShopList = [NSMutableArray array];
    }
    return _arrForHomePageShopList;
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:YES];
    [self.tabBarController.tabBar setHidden:NO];
    [self getLocation];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:BaseYellow];
    [self createTableView];
    // Do any additional setup after loading the view.
    [self getNetWork];
}

#pragma mark - 网络请求
-(void)getNetWork{
    [self getNetWorkForBanner];
    [self getNetworkForType];
    
    [self.tableView reloadData];
}
//banner
-(void)getNetWorkForBanner{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,LUNBOURL];
    //@"http://118.24.100.177:8080/spmvc/xmfapi/getCarousel";
    [MHNetWorkTask getWithURL:url withParameter:nil withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
        
        NSArray *dic = result[@"value"];
        NSString *bannerImg = dic[0][@"img"];
        
        _netImages = @[
                       @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1522041362507&di=a89e4dd6395100b8e799271448685c35&imgtype=0&src=http%3A%2F%2Fpic36.nipic.com%2F20131203%2F3822951_101052690000_2.jpg",
                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1522041362507&di=a89e4dd6395100b8e799271448685c35&imgtype=0&src=http%3A%2F%2Fpic36.nipic.com%2F20131203%2F3822951_101052690000_2.jpg"
                      
                       ];
        /** 测试本地图片数据*/
        self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"PlacehoderImage.png"]];
         self.cycleScrollView.imageURLStringsGroup = self.netImages;
        //设置图片视图显示类型
        self.cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
        //设置轮播视图的分页控件的显示
        self.cycleScrollView.showPageControl = YES;
        //设置轮播视图分也控件的位置
        self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        //当前分页控件小圆标图片
        self.cycleScrollView.pageDotImage = [UIImage imageNamed:@"normal"];
        //其他分页控件小圆标图片
        self.cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"lighted"];
        
        [headviewImageView addSubview:self.cycleScrollView];
        [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headviewAddressView.mas_bottom);
            make.width.equalTo(headviewAddressView);
            make.centerX.equalTo(headviewAddressView);
            make.height.equalTo(@(kHeadImageViewHeight));
        }];
       
        
    } withFail:^(NSError *error) {
        NSLog(@"轮播图请求错误：%@,",error);
    }];
    
}
//选择分类
-(void)getNetworkForType{
    NSString *URL = [NSString stringWithFormat:@"%@%@",BASEURL,homeTypeURL];
    [self.arrForHomePageTypeName removeAllObjects];
    [MHNetWorkTask getWithURL:URL withParameter:nil withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
        NSArray *arr = result[@"value"];
        for (NSDictionary *dic in arr) {
            ModelForHomeType *mod = [[ModelForHomeType alloc]init];
            mod.id = dic[@"id"];
            mod.shopTypeName = dic[@"shopTypeName"];
            [self.arrForHomePageTypeName addObject:mod];
        }
        [self.collectionView reloadData];
    } withFail:^(NSError *error) {
        
    }];
}
//推荐列表
-(void)netWorkForShopList:(NSInteger )tag{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,homeshopRecommendList];
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    if (!strlongitude) {
        strlongitude = @"0";
    }
    if (!strlatitude) {
        strlatitude = @"0";
    }
    [par setValue:strlongitude forKey:@"lonng"];
    [par setValue:strlatitude forKey:@"lat"];
    
    NSInteger strFlgid =tag + 1;
    NSNumber *numFlg =[NSNumber numberWithInteger:strFlgid];
    
    NSString * strTypeFlg =@"1";
    int strTypeFlgid =[strTypeFlg intValue];
    NSNumber *numTypeFlg =[NSNumber numberWithInt:strTypeFlgid];
    
    NSString * strPage =@"1";
    int strPageid =[strPage intValue];
    NSNumber *numPage =[NSNumber numberWithInt:strPageid];
    [par setValue:numFlg forKey:@"flg"];
    [par setValue:numTypeFlg forKey:@"typeflg"];
    [par setValue:numPage forKey:@"page"];
    [self.arrForHomePageShopList removeAllObjects];
    [MHNetWorkTask getWithURL:url withParameter:par withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
    
        NSArray *arr = result[@"value"];
        for (NSDictionary *dic in arr) {
            ModelForShopList *mod = [[ModelForShopList alloc]init];
            mod.per_mean = dic[@"per_mean"];
            mod.send_dis = dic[@"send_dis"];
            mod.send_time = dic[@"send_time"];
            mod.send_pic = dic[@"send_pic"];
            mod.store_id = dic[@"store_id"];
            mod.store_img = dic[@"store_img"];
            mod.store_name = dic[@"store_name"];
            mod.up_pic = dic[@"up_pic"];
            mod.act_list = dic[@"act_list"];
            [self.arrForHomePageShopList addObject:mod];
        }
        [self.tableView reloadData];
    } withFail:^(NSError *error) {
        
    }];
}
#pragma mark - 创建透视图
-(void)createHeadView{
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeadAdderssViewHeight + kHeadImageViewHeight + kHeadCollectionViewHeight + kHeadSelectViewHeight + 65)];
    self.headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headView];
    [self createHeadViewAddressView];
    [self createHeadviewImageView];
    [self createCollectionView];
    [self createHeadviewSelectView];
    [self createSortingView];
}
//地址栏
-(void)createHeadViewAddressView{
    headviewAddressView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeadAdderssViewHeight)];
    headviewAddressView.backgroundColor = [UIColor colorWithHexString:BaseYellow];
    [self.headView addSubview:headviewAddressView];
    
    //icon
    UIImageView *locationIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 15, 20)];
    
    [locationIcon setImage:[UIImage imageNamed:@"ic_point"]];
    [headviewAddressView addSubview:locationIcon];
    
    //地址
    headviewAddressLabel = [[UILabel alloc]init];
    headviewAddressLabel.text = @"获取位置中....";
    [headviewAddressView addSubview:headviewAddressLabel];
    [headviewAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(locationIcon.mas_right).offset(5);
        make.centerY.equalTo(locationIcon);
    }];
 
}
//头视图
-(void)createHeadviewImageView{
    headviewImageView = [[UIImageView alloc]init];
    headviewImageView.backgroundColor = [UIColor orangeColor];
    [self.headView addSubview:headviewImageView];
    [headviewImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headviewAddressView.mas_bottom);
        make.width.equalTo(headviewAddressView);
        make.centerX.equalTo(headviewAddressView);
        make.height.equalTo(@(kHeadImageViewHeight));
    }];
    
    
}

//选择
-(void)createHeadviewSelectView{
    headviewSelectView = [[UIView alloc]init];
    headviewSelectView.backgroundColor = [UIColor whiteColor];
    [self.headView addSubview:headviewSelectView];
    [headviewSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView.mas_bottom);
        make.width.equalTo(headviewImageView);
        make.centerX.equalTo(headviewImageView);
        make.height.equalTo(@(kHeadSelectViewHeight));
    }];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = [UIColor grayColor];
    [self.headView addSubview:line];
    
    UIImageView *selectImage = [[UIImageView alloc]init];
    [selectImage setImage:[UIImage imageNamed:@"yhhd"]];
    [headviewSelectView addSubview:selectImage];
    [selectImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headviewSelectView.mas_top).offset(10);
        make.left.equalTo(headviewSelectView.mas_left).offset(20);
        make.height.equalTo(@(20));
        make.width.equalTo(@(80));
    }];
    
    headviewSelectLeftView = [[UIImageView alloc]init];
    [headviewSelectLeftView setImage:[UIImage imageNamed:@"left"]];
    [headviewSelectView addSubview:headviewSelectLeftView];
    //添加手势
    UITapGestureRecognizer * tapGestureLeft = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelectLeft)];
    [headviewSelectLeftView addGestureRecognizer:tapGestureLeft];
    [headviewSelectLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headviewSelectView.mas_left).offset(15);
        make.top.equalTo(selectImage.mas_bottom).offset(5);
        make.bottom.equalTo(headviewSelectView.mas_bottom).offset(-5);
        make.right.equalTo(headviewSelectView.mas_centerX).offset(-5);
    }];
    
    headviewSelectRightView = [[UIImageView alloc]init];
    [headviewSelectRightView setImage:[UIImage imageNamed:@"right"]];
    [headviewSelectView addSubview:headviewSelectRightView];
    //添加手势
    UITapGestureRecognizer * tapGestureRight = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelectRight)];
    [headviewSelectLeftView addGestureRecognizer:tapGestureRight];
    [headviewSelectRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headviewSelectView.mas_right).offset(-15);
        make.top.equalTo(selectImage.mas_bottom).offset(5);
        make.bottom.equalTo(headviewSelectView.mas_bottom).offset(-5);
        make.left.equalTo(headviewSelectView.mas_centerX).offset(5);
    }];
 
}
//筛选排序
-(void)createSortingView{
  
    sortingView = [[UIView alloc]init];
    [sortingView setBackgroundColor:[UIColor whiteColor]];
    [_headView addSubview:sortingView];
    [sortingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headviewSelectView.mas_bottom);
        make.width.equalTo(headviewImageView);
        make.centerX.equalTo(headviewImageView);
        make.height.equalTo(@(65));
    }];
    
     UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    line.backgroundColor = [UIColor lightGrayColor];
    [sortingView addSubview:line];
    
    UIImageView *selectImage = [[UIImageView alloc]init];
    [selectImage setImage:[UIImage imageNamed:@"tjsj"]];
    [sortingView addSubview:selectImage];
    [selectImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(5);
        make.left.equalTo(sortingView.mas_left).offset(20);
        make.height.equalTo(@(20));
        make.width.equalTo(@(80));
    }];

    NSArray *arrButtonTitle = @[@"综合排序",@"销量最高",@"距离最近"];
    CGFloat buttonW = SCREEN_WIDTH / arrButtonTitle.count; //按钮的宽度和高度
    CGFloat buttonH = 30;
    for (int i=0; i<arrButtonTitle.count; i++) {  // 循环创建3个按钮
        clickButton=[[SortButton alloc]initWithFrame:CGRectMake(buttonW*i, 15 + 20, buttonW, buttonH)];
        if(i==0){
            clickButton.selected=YES;  // 设置第一个为默认值
            self.replaceButton=clickButton;
        }
        
        clickButton.tag=i;
        clickButton.titleLabel.font=[UIFont systemFontOfSize:14.0];
        [clickButton setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
        [clickButton setTitleColor:[UIColor blackColor]forState:UIControlStateSelected];
        [clickButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [clickButton setImage:[UIImage imageNamed:@"ic_pulldown"] forState:UIControlStateSelected];
        [clickButton setTitle:arrButtonTitle[i] forState:UIControlStateNormal];
        [clickButton addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [sortingView addSubview:clickButton];
        
        
    }
}

#pragma mark - 创建collecttionView
-(void)createCollectionView{
    CGFloat itemWidth = (SCREEN_WIDTH - 5 )/ 5;
    CGFloat itemHeight = (SCREEN_WIDTH - 5 ) / 5;
    UICollectionViewFlowLayout *shareflowLayout = [[UICollectionViewFlowLayout alloc] init];
    shareflowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    shareflowLayout.sectionInset = UIEdgeInsetsMake(1, 1, 1,1);
    shareflowLayout.itemSize =CGSizeMake(itemWidth, itemHeight);
    // 1.设置列间距
    shareflowLayout.minimumInteritemSpacing = 0;
    // 2.设置行间距
    shareflowLayout.minimumLineSpacing = 0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:shareflowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.headView addSubview:self.collectionView];
    [self.collectionView registerClass:[CollectionViewCellForHomePageChoose class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.delaysContentTouches = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headviewImageView.mas_bottom);
        make.width.equalTo(headviewImageView);
        make.centerX.equalTo(headviewImageView);
        make.height.equalTo(@(kHeadCollectionViewHeight));
    }];
}

#pragma mark - 创建tableView
-(void)createTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaStatsBarHeight, self.view.frame.size.width, self.view.frame.size.height - SafeAreaStatsBarHeight) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self createHeadView];
    self.tableView.tableHeaderView = self.headView;
    
    /** 注册cell. */
    [self.tableView registerClass:[TableViewCellForHomepageList class] forCellReuseIdentifier:@"pool1"];
    [self.view addSubview:self.tableView];
}

#pragma mark - tableView DataSouce
/**** 行数 ****/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrForHomePageShopList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    TableViewCellForHomepageList *cell = [tableView dequeueReusableCellWithIdentifier:@"pool1"];
    cell.mod = [self.arrForHomePageShopList objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
        
   
}
/* 行高 **/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
       return 110;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopDetailVC *shopDetailVC = [[ShopDetailVC alloc]init];
    shopDetailVC.modShopList = [self.arrForHomePageShopList objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:shopDetailVC animated:YES];
    
}

#pragma mark collectionView代理方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.arrForHomePageTypeName.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCellForHomePageChoose *cell = (CollectionViewCellForHomePageChoose *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //设置数据
    cell.mod = [self.arrForHomePageTypeName objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
   
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeTypeVC *shop = [[HomeTypeVC alloc]init];
    ModelForHomeType *mod = [self.arrForHomePageTypeName objectAtIndex:indexPath.row];
    shop.typeName = mod.shopTypeName;
    shop.shopTypeId = mod.id;
    shop.strlatitude = strlatitude;
    shop.strlongitude = strlongitude;
   [self.navigationController pushViewController:shop animated:YES];
    NSLog(@"%@",indexPath);
    
}

#pragma mark - 轮播图代理方法
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    //NSLog(@"%ld",index);
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
    //NSLog(@"%ld",index);
}

#pragma mark - 定位
-(void)getLocation
{
    //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        locationmanager = [[CLLocationManager alloc]init];
        locationmanager.delegate = self;
        [locationmanager requestAlwaysAuthorization];
        currentCity = [NSString new];
        [locationmanager requestWhenInUseAuthorization];
        
        //设置寻址精度
        locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
        locationmanager.distanceFilter = 5.0;
        [locationmanager startUpdatingLocation];
    }
}
#pragma mark CoreLocation delegate (定位失败)
//定位失败后调用此代理方法
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
//    //设置提示提醒用户打开定位服务
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"允许定位提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:nil];
//
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//    [alert addAction:okAction];
//    [alert addAction:cancelAction];
//    [self presentViewController:alert animated:YES completion:nil];
    NSLog(@"location Fail");
}
#pragma mark 定位成功后则执行此代理方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    [locationmanager stopUpdatingHeading];
    if (!strlatitude) {
        [self netWorkForShopList:0];
    }
    //旧址
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    //打印当前的经度与纬度
    NSLog(@"%f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    //反地理编码
    strlatitude = [NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
    strlongitude = [NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
   
    
    
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            currentCity = placeMark.locality;
            if (!currentCity) {
                currentCity = @"无法定位当前城市";
            }
            
            
           
            NSString *locStr = [NSString stringWithFormat:@"%@%@%@",currentCity,placeMark.subLocality,placeMark.name];
             NSLog(@"%@",locStr);//具体地址
            headviewAddressLabel.text = locStr;
            
        }
    }];
    
    
}

#pragma mark - 点击事件
-(void)tapSelectLeft{
    
}
-(void)tapSelectRight{
    
}
//点击了对应的筛选条件按钮操作
-(void)clickAction:(UIButton *)sender{
    NSLog(@"%ld",(long)sender.tag);
    self.replaceButton.selected=NO;  // 改变箭头的方向
    sender.selected=YES;
    self.replaceButton=sender;
    
    [self loadData:sender.tag]; // 重新加载数据,刷新表
    
}
//加载模型数据数组
-(void)loadData:(NSInteger)tagNum{
    [self netWorkForShopList:tagNum];
}
@end
