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
#import "Reachability.h"
//VC
#import "ShopDetailVC.h"
#import "HomeTypeVC.h"
#import "HomeDetailWebView.h"
//VIEW
#import "SortButton.h"
#import "CollectionViewCellForHomePageChoose.h"
#import "TableViewCellForHomepageList.h"

//model
#import "ModelForHomeType.h"
#import "ModelForShopList.h"

#define kHeadAdderssViewHeight 40
#define kHeadSelectViewHeight kWidthScale(345)
#define kHeadImageViewHeight kWidthScale(225)
#define kHeadCollectionViewHeight kWidthScale(310)
#define kHeadShortViewHeight kWidthScale(150)

@interface HomePageVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,CLLocationManagerDelegate,SDCycleScrollViewDelegate>
{
    UIView *headviewAddressView;
    UILabel *headviewAddressLabel;
    UIImageView *headviewImageView;
    UIView *headviewSelectView;
    UIButton *headviewSelectLeftView;
    UIButton *headviewSelectRightView;
    UIView *sortingView;
    SortButton *clickButton;
     NSMutableDictionary *dicForShow;//创建一个字典进行判断收缩还是展开
}
@property (strong,nonatomic)NSMutableArray *netImages;  //网络图片
@property (strong,nonatomic)SDCycleScrollView *cycleScrollView;//轮播器
@property (nonatomic , strong)UIView *headView;
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)UICollectionView *collectionView;
@property (nonatomic , strong)UIButton *replaceButton;

@property (nonatomic , strong)NSMutableArray *arrForHomePageTypeName;
@property (nonatomic , strong)NSMutableArray *arrForHomePageShopList;

@property (nonatomic , strong)NSMutableArray *arrForBannerDetail;

/**
 *   页数
 */
@property (nonatomic,assign) int pageIndex;
@property (nonatomic ,assign) int chooseType;
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
-(NSMutableArray *)arrForBannerDetail{
    if (!_arrForBannerDetail) {
        _arrForBannerDetail = [NSMutableArray array];
    }
    return _arrForBannerDetail;
}
-(NSMutableArray *)netImages{
    
    if (!_netImages) {
        _netImages = [NSMutableArray array];
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
    //[self getNetworkForType];
}
-(BOOL)isConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    
    Reachability *reach = [Reachability reachabilityWithHostName:BASEURL];
    
    switch ([reach currentReachabilityStatus]) {
            
        case NotReachable:
            
            isExistenceNetwork = NO;
            
            return isExistenceNetwork;
            
            //NSLog(@"notReachable");
            
            break;
            
        case ReachableViaWiFi:
            
            isExistenceNetwork = YES;
            
            return isExistenceNetwork;
            
            
            
            //NSLog(@"WIFI");
            
            break;
            
        case ReachableViaWWAN:
            
            isExistenceNetwork = YES;
            
            return isExistenceNetwork;
            
            
            
            //NSLog(@"3G");
            
            break;
            
    }
    
    return isExistenceNetwork;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self reachability];
     dicForShow = [NSMutableDictionary dictionary];
    self.view.backgroundColor = [UIColor colorWithHexString:BaseYellow];
    [self createTableView];
    // Do any additional setup after loading the view.
    
    //判断网络状态
    
    [self getNetWork];
    
}
- (void)reachability
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                NSLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                NSLog(@"没有网络(断网)");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                NSLog(@"手机自带网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                NSLog(@"WIFI");
                break;
        }
    }];
    // 3.开始监控
    [mgr startMonitoring];
}


#pragma mark - 网络请求
-(void)getNetWork{
    
    if( ![self isConnectionAvailable]){
        
        [MBManager showBriefAlert:ZBLocalized(@"请检查网络", nil)];
        
    }else{
        [self isNeedUpdate];
        if (self.netImages.count == 0) {
            [self getNetWorkForBanner];
        }
        if (self.arrForHomePageTypeName.count == 0) {
            [self getNetworkForType];
        }
        
        [self.tableView reloadData];
    }
    
   
}
-(void)isNeedUpdate{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,isNeedUpDateURL];
    NSDictionary *parameters = @{@"flg":@"3",
                                 @"vnum":ICTYPE,
                                
                                 };
    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
    //请求的方式：POST
    [managers POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSString *code =[NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([code isEqualToString:@"2"]) {
            
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:ZBLocalized(@"发现新版本", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * ok = [UIAlertAction actionWithTitle:ZBLocalized(@"取消", nil) style:UIAlertActionStyleDefault handler:nil];
            UIAlertAction * update = [UIAlertAction actionWithTitle:ZBLocalized(@"去更新", nil)  style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //跳转到App Store
                NSString *urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/th/app/id1385904750?mt=8"];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
            }];
            [alert addAction:ok];
            [alert addAction:update];
            [self presentViewController:alert animated:YES completion:nil];
            
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      
    }];
    
}
//banner
-(void)getNetWorkForBanner{
        NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,LUNBOURL];
        //@"http://118.24.100.177:8080/spmvc/xmfapi/getCarousel";
        NSString *language=[[ZBLocalized sharedInstance]currentLanguage];
        NSLog(@"切换后的语言:%@",language);
        NSString *lauStr;
        if ([language isEqualToString:@"th"]) {
            lauStr = @"1";
        }
        else if ([language isEqualToString:@"en"]){
            lauStr = @"3";
        }
        else if ([language isEqualToString:@"zh-Hans"]){
            lauStr = @"2";
        }
    
//        NSDictionary *parameters = @{//@"langet":lauStr,
//                                     @"language":@"1",
//                                     @"lat":@"13.744488",
//                                     @"lng":@"100.551866",
//                                     };
//
//    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
//    [managers POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//                    NSArray *dic = responseObject[@"value"];
//                    for (NSMutableDictionary *dicRes in dic) {
//                        NSString *urlS =[NSString stringWithFormat:@"%@%@",IMGBaesURL,dicRes[@"img"]];
//                        urlS = [urlS stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
//                        NSString *detailurl = [NSString stringWithFormat:@"%@",dicRes[@"bannerText"]];
//                        [self.netImages addObject:urlS];
//                        [self.arrForBannerDetail addObject:detailurl];
//                    }
//
//                    /** 测试本地图片数据*/
//                    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"logo"]];
//                    self.cycleScrollView.imageURLStringsGroup = self.netImages;
//                    //设置图片视图显示类型
//                    self.cycleScrollView.autoScrollTimeInterval = 5;
//                    self.cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
//                    //设置轮播视图的分页控件的显示
//                    self.cycleScrollView.showPageControl = YES;
//                    //设置轮播视图分也控件的位置
//                    self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
//                    //当前分页控件小圆标图片
//                    self.cycleScrollView.pageDotImage = [UIImage imageNamed:@"normal"];
//                    //其他分页控件小圆标图片
//                    self.cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"lighted"];
//
//                    [self.tableView addSubview:self.cycleScrollView];
//                    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//                        make.top.equalTo(headviewAddressView.mas_bottom).offset(kWidthScale(18)) ;
//                        make.width.equalTo(headviewAddressView).offset(-kWidthScale(36));
//                        make.centerX.equalTo(headviewAddressView);
//                        make.height.equalTo(@(kHeadImageViewHeight - kWidthScale(36)));
//                    }];
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//    }];
    
    NSDictionary *parameters = @{@"langet":lauStr};

        [MHNetWorkTask getWithURL:url withParameter:parameters withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {

            NSArray *dic = result[@"value"];
            for (NSMutableDictionary *dicRes in dic) {
                NSString *urlS =[NSString stringWithFormat:@"%@%@",IMGBaesURL,dicRes[@"img"]];
                urlS = [urlS stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
                NSString *detailurl = [NSString stringWithFormat:@"%@",dicRes[@"bannerText"]];
                [self.netImages addObject:urlS];
                [self.arrForBannerDetail addObject:detailurl];
            }

            /** 测试本地图片数据*/
            self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"logo"]];
            self.cycleScrollView.imageURLStringsGroup = self.netImages;
            //设置图片视图显示类型
            self.cycleScrollView.autoScrollTimeInterval = 5;
            self.cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
            //设置轮播视图的分页控件的显示
            self.cycleScrollView.showPageControl = YES;
            //设置轮播视图分也控件的位置
            self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
            //当前分页控件小圆标图片
            self.cycleScrollView.pageDotImage = [UIImage imageNamed:@"normal"];
            //其他分页控件小圆标图片
            self.cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"lighted"];

            [self.tableView addSubview:self.cycleScrollView];
            [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(headviewAddressView.mas_bottom).offset(kWidthScale(18)) ;
                make.width.equalTo(headviewAddressView).offset(-kWidthScale(36));
                make.centerX.equalTo(headviewAddressView);
                make.height.equalTo(@(kHeadImageViewHeight - kWidthScale(36)));
            }];


        } withFail:^(NSError *error) {
            self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"logo"]];
            self.cycleScrollView.imageURLStringsGroup = self.netImages;
            //设置图片视图显示类型
            self.cycleScrollView.autoScrollTimeInterval = 5;
            self.cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
            //设置轮播视图的分页控件的显示
            self.cycleScrollView.showPageControl = YES;
            //设置轮播视图分也控件的位置
            self.cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
            //当前分页控件小圆标图片
            self.cycleScrollView.pageDotImage = [UIImage imageNamed:@"normal"];
            //其他分页控件小圆标图片
            self.cycleScrollView.currentPageDotImage = [UIImage imageNamed:@"lighted"];

            [self.tableView addSubview:self.cycleScrollView];
            [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(headviewAddressView.mas_bottom).offset(kWidthScale(18)) ;
                make.width.equalTo(headviewAddressView).offset(-kWidthScale(36));
                make.centerX.equalTo(headviewAddressView);
                make.height.equalTo(@(kHeadImageViewHeight - kWidthScale(36)));
            }];
            NSLog(@"轮播图请求错误：%@,",error);
        }];
    
}
//选择分类
-(void)getNetworkForType{
    NSString *language=[[ZBLocalized sharedInstance]currentLanguage];
    NSLog(@"切换后的语言:%@",language);
    NSString *URL = [NSString stringWithFormat:@"%@%@",BASEURL,homeTypeURL];
    [self.arrForHomePageTypeName removeAllObjects];
    [MHNetWorkTask getWithURL:URL withParameter:nil withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
        NSArray *arr = result[@"value"];
        for (NSDictionary *dic in arr) {
            ModelForHomeType *mod = [[ModelForHomeType alloc]init];
            mod.id = dic[@"id"];
            if ([language isEqualToString:@"en"]) {
                NSString *strshopTypeName =dic[@"shopTypeNameEn"];
                if ([strshopTypeName isEqual:[NSNull null]]||strshopTypeName.length == 0)
                {
                    strshopTypeName =dic[@"shopTypeName"];
                }
                 mod.shopTypeName = strshopTypeName;
            }
            else if ([language isEqualToString:@"th"]){
                NSString *strshopTypeName =dic[@"shopTypeNameTh"];
                if ([strshopTypeName isEqual:[NSNull null]]||strshopTypeName.length == 0)
                {
                    strshopTypeName =dic[@"shopTypeName"];
                }
                mod.shopTypeName = strshopTypeName;
            }
            else{
                mod.shopTypeName = dic[@"shopTypeName"];
            }
           
            
            [self.arrForHomePageTypeName addObject:mod];
        }
        [self.collectionView reloadData];
    } withFail:^(NSError *error) {
        
    }];
}
-(void)loadMoreBills:(NSInteger)tag{
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
    
    
    
    NSInteger strFlgid =self.chooseType + 1;
    NSNumber *numFlg =[NSNumber numberWithInteger:strFlgid];
    
    NSString * strTypeFlg =@"0";
    int strTypeFlgid =[strTypeFlg intValue];
    NSNumber *numTypeFlg =[NSNumber numberWithInt:strTypeFlgid];
    _pageIndex++;

    NSNumber *numPage =[NSNumber numberWithInt:_pageIndex];
    [par setValue:numFlg forKey:@"flg"];
    [par setValue:numTypeFlg forKey:@"typeflg"];
    [par setValue:numPage forKey:@"page"];

    [MHNetWorkTask getWithURL:url withParameter:par withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
        
        NSArray *arr = result[@"value"];
        if (arr.count == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
        for (NSDictionary *dic in arr) {
            ModelForShopList *mod = [[ModelForShopList alloc]init];
            mod.per_mean = dic[@"per_mean"];
            mod.send_dis = dic[@"send_dis"];
            mod.send_time = dic[@"send_time"];
            mod.send_pic = dic[@"send_pic"];
            mod.store_id = dic[@"store_id"];
            NSString *storeImgStr =[NSString stringWithFormat:@"%@%@",IMGBaesURL,dic[@"store_img"]];
            storeImgStr =  [storeImgStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            mod.store_img =storeImgStr;;
            mod.store_name = dic[@"store_name"];
            mod.up_pic = dic[@"up_pic"];
            mod.act_list = dic[@"act_list"];
             mod.notice  = dic[@"shop_notice"];
            mod.opentime = dic[@"opentime"];
             mod.acTypeStr = [NSString stringWithFormat:@"%@",dic[@"shop_ac_type"]];
            mod.bussinesstime = dic[@"bussinesstime"];
            [self.arrForHomePageShopList addObject:mod];
        }
            [self.tableView.mj_footer endRefreshing];
            [self.tableView reloadData];
        }
        
    } withFail:^(NSError *error) {
        
    }];
}
//推荐列表
-(void)netWorkForShopList:(NSInteger )tag{
    if( ![self isConnectionAvailable]){
        
        [MBManager showBriefAlert:ZBLocalized(@"请检查网络", nil)];
        
    }else{
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
        
        
        
        NSInteger strFlgid =self.chooseType + 1;
        NSNumber *numFlg =[NSNumber numberWithInteger:strFlgid];
        
        NSString * strTypeFlg =@"0";
        int strTypeFlgid =[strTypeFlg intValue];
        NSNumber *numTypeFlg =[NSNumber numberWithInt:strTypeFlgid];
        _pageIndex = 1;
        NSString * strPage =@"1";
        int strPageid =[strPage intValue];
        NSNumber *numPage =[NSNumber numberWithInt:strPageid];
        [par setValue:numFlg forKey:@"flg"];
        [par setValue:numTypeFlg forKey:@"typeflg"];
        [par setValue:numPage forKey:@"page"];
        
        //[self.tableView.mj_header setHidden:NO];
        //  [self.tableView reloadData];
        [MHNetWorkTask getWithURL:url withParameter:par withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
            
            NSArray *arr = result[@"value"];
            [self.arrForHomePageShopList removeAllObjects];
            for (NSDictionary *dic in arr) {
                ModelForShopList *mod = [[ModelForShopList alloc]init];
                mod.per_mean = dic[@"per_mean"];
                mod.send_dis = dic[@"send_dis"];
                mod.send_time = dic[@"send_time"];
                mod.send_pic = dic[@"send_pic"];
                mod.store_id = dic[@"store_id"];
                NSString *storeImgStr =[NSString stringWithFormat:@"%@%@",IMGBaesURL,dic[@"store_img"]];
                storeImgStr =  [storeImgStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                mod.store_img =storeImgStr;
                mod.store_name = dic[@"store_name"];
                mod.up_pic = dic[@"up_pic"];
                mod.act_list = dic[@"act_list"];
                mod.opentime = dic[@"opentime"];
                mod.notice  = dic[@"shop_notice"];
                mod.acTypeStr = [NSString stringWithFormat:@"%@",dic[@"shop_ac_type"]];
                mod.bussinesstime = dic[@"bussinesstime"];
                NSInteger acType = dic[@"shop_ac_type"];
                [self.arrForHomePageShopList addObject:mod];
                
                if (acType == 2) {
                    
                    
                }else{
                    
                    //NSLog(@"该商家已打烊");
                }
                
                
            }
            
            [self.tableView.mj_footer resetNoMoreData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        } withFail:^(NSError *error) {
           
        }];
        
    }
    
}
#pragma mark - 创建透视图
-(void)createHeadView{
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeadAdderssViewHeight + kHeadImageViewHeight + kHeadCollectionViewHeight + kHeadSelectViewHeight + kHeadShortViewHeight + SafeAreaStatsBarHeight)];
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
    UIView *safeTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SafeAreaStatsBarHeight)];
    safeTop.backgroundColor = [UIColor colorWithHexString:BaseYellow];
    [self.headView addSubview:safeTop];
    headviewAddressView = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaStatsBarHeight, SCREEN_WIDTH, kHeadAdderssViewHeight)];
    headviewAddressView.backgroundColor = [UIColor colorWithHexString:BaseYellow];
    [self.headView addSubview:headviewAddressView];
    
    //icon
    UIImageView *locationIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 15, 20)];
    
    [locationIcon setImage:[UIImage imageNamed:@"icon_dizhi"]];
    [headviewAddressView addSubview:locationIcon];
    
    //地址
    headviewAddressLabel = [[UILabel alloc]init];
    headviewAddressLabel.text = ZBLocalized(@"获取位置中....", nil);
    [headviewAddressView addSubview:headviewAddressLabel];
    headviewAddressLabel.numberOfLines = 2;
    [headviewAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(locationIcon.mas_right).offset(5);
        make.centerY.equalTo(locationIcon);
        make.right.equalTo(safeTop.mas_right).offset(-10);
    }];
 
}
//头视图
-(void)createHeadviewImageView{
    headviewImageView = [[UIImageView alloc]init];
   
    [self.headView addSubview:headviewImageView];
    [headviewImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headviewAddressView.mas_bottom) ;
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
        make.top.equalTo(self.collectionView.mas_bottom) ;
        make.width.equalTo(headviewImageView);
        make.centerX.equalTo(headviewImageView);
        make.height.equalTo(@(kHeadSelectViewHeight));
    }];
    
//    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
//    line.backgroundColor = [UIColor grayColor];
//    [self.headView addSubview:line];
    
    UIImageView *selectImage = [[UIImageView alloc]init];
    [selectImage setImage:[UIImage imageNamed:ZBLocalized(@"zhongwengyouhuizhuanqu", nil)]];
//    selectImage.text = ZBLocalized(@"吃货福利", nil);
//    selectImage.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [headviewSelectView addSubview:selectImage];
    [selectImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headviewSelectView.mas_top).offset(kWidthScale(40));
        make.left.equalTo(headviewSelectView.mas_left).offset(kWidthScale(20));
        make.height.equalTo(@(kWidthScale(48)));
        make.width.equalTo(@(kWidthScale(275)));
        
    }];
    
    headviewSelectLeftView = [UIButton buttonWithType:UIButtonTypeCustom];
    [headviewSelectLeftView setImage:[UIImage imageNamed:ZBLocalized(@"chihuozhongwen", nil)] forState:UIControlStateNormal];
    [headviewSelectLeftView addTarget:self action:@selector(tapSelectLeft) forControlEvents:UIControlEventTouchUpInside];
    [headviewSelectView addSubview:headviewSelectLeftView];
    
    [headviewSelectLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headviewSelectView.mas_left).offset(kWidthScale(18));
        make.top.equalTo(selectImage.mas_bottom).offset(kWidthScale(20));
        make.bottom.equalTo(headviewSelectView.mas_bottom).offset(-kWidthScale(5));
        make.right.equalTo(headviewSelectView.mas_centerX).offset(-kWidthScale(5));
    }];

   
    headviewSelectRightView = [UIButton buttonWithType:UIButtonTypeCustom];
    [headviewSelectRightView setImage:[UIImage imageNamed:ZBLocalized(@"hongbaozhongwen", nil) ] forState:UIControlStateNormal];
    [headviewSelectRightView addTarget:self action:@selector(tapSelectRight) forControlEvents:UIControlEventTouchUpInside];
    [headviewSelectView addSubview:headviewSelectRightView];
    [headviewSelectRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headviewSelectView.mas_right).offset(-kWidthScale(18));
        make.top.equalTo(selectImage.mas_bottom).offset(kWidthScale(20));
        make.bottom.equalTo(headviewSelectView.mas_bottom).offset(-kWidthScale(5));
        make.left.equalTo(headviewSelectView.mas_centerX).offset(kWidthScale(5));
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
        make.height.equalTo(@(kHeadShortViewHeight));
    }];
    
//    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
//    line.backgroundColor = [UIColor lightGrayColor];
//    [sortingView addSubview:line];
    
    UIImageView *selectImage = [[UIImageView alloc]init];
    [selectImage setImage:[UIImage imageNamed:ZBLocalized(@"zhongwengfujingshangjia", nil)]];
    [sortingView addSubview:selectImage];
    [selectImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sortingView.mas_top).offset(kWidthScale(50)) ;
        make.left.equalTo(sortingView.mas_left).offset(kWidthScale(20));
        make.height.equalTo(@(kWidthScale(48)));
        make.width.equalTo(@(kWidthScale(275)));
        
    }];

     NSArray *arrButtonTitle = @[ZBLocalized(@"综合排序", nil),ZBLocalized(@"销量最高", nil),ZBLocalized(@"距离最近", nil)];
    CGFloat buttonW = (SCREEN_WIDTH - kWidthScale(18) )/ arrButtonTitle.count; //按钮的宽度和高度
    CGFloat buttonH = kWidthScale(60);
    for (int i=0; i<arrButtonTitle.count; i++) {  // 循环创建3个按钮
        clickButton=[[SortButton alloc]initWithFrame:CGRectMake(kWidthScale(18) +  buttonW*i, kWidthScale(100), buttonW, buttonH)];
        if(i==0){
            clickButton.selected=YES;  // 设置第一个为默认值
            self.replaceButton=clickButton;
        }
        
        clickButton.tag=i;
        clickButton.titleLabel.font=[UIFont systemFontOfSize:14.0];
        [clickButton setTitleColor:[UIColor lightGrayColor]forState:UIControlStateNormal];
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
    CGFloat itemHeight = kWidthScale(155);
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
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,-SafeAreaStatsBarHeight , self.view.frame.size.width, SCREENH_HEIGHT - 29  ) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self createHeadView];
    self.tableView.tableHeaderView = self.headView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if( ![self isConnectionAvailable]){
            [self.tableView.mj_footer endRefreshing];

            [self.tableView.mj_header endRefreshing];
            [MBManager showBriefAlert:ZBLocalized(@"请检查网络", nil)];
            
        }else{
            [self getNetWork];
        [self netWorkForShopList:self.chooseType];
        }
    }];
    
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if( ![self isConnectionAvailable]){
            [self.tableView.mj_footer endRefreshing];

            [self.tableView.mj_header endRefreshing];
            [MBManager showBriefAlert:ZBLocalized(@"请检查网络", nil)];
            
        }else{
        [self loadMoreBills:self.chooseType];
        }
    }];
    self.tableView.mj_footer = footer;
    
    /** 注册cell. */
//    [self.tableView registerClass:[TableViewCellForHomepageList class] forCellReuseIdentifier:@"pool1"];
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
  
    ModelForShopList *mod =[[ModelForShopList alloc]init];
    mod = [self.arrForHomePageShopList objectAtIndex:indexPath.row];
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld%@",indexPath.section,indexPath.row,mod.store_id];
    
    TableViewCellForHomepageList *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[TableViewCellForHomepageList alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.isShowLong =dicForShow[indexPath];
    cell.mod = [self.arrForHomePageShopList objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.blockChooseShow = ^(NSString *isShow) {
         dicForShow[indexPath] = [NSNumber numberWithBool:![dicForShow[indexPath] boolValue]];
             [self.tableView reloadData];
            
    };

    return cell;
        
   
}
/* 行高 **/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

       return [self cellHeightForIndexPath:indexPath cellContentViewWidth:SCREEN_WIDTH tableView:self.tableView];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ModelForShopList *mod =[[ModelForShopList alloc]init];
    mod = [self.arrForHomePageShopList objectAtIndex:indexPath.row];
    NSString *acType = mod.acTypeStr;
    //如果反的ACtype = 2 则营业，再判断时间
    if ([acType isEqualToString:@"2"]) {
        NSString *cyType = [self isACType:mod.opentime];
        //如果cytype为2 则打烊
        if ([cyType isEqualToString:@"2"]) {
           
            [MBManager showBriefAlert:ZBLocalized(@"该商店已打样", nil)];
            return;
        }
    }else{
        [MBManager showBriefAlert:ZBLocalized(@"该商店已打样", nil)];
        return;
    }
    
    
    
    
    ShopDetailVC *shopDetailVC = [[ShopDetailVC alloc]init];
    shopDetailVC.modShopList = [self.arrForHomePageShopList objectAtIndex:indexPath.row];

       
        shopDetailVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:shopDetailVC animated:YES];
  
   
    
}
-(NSString *)isACType:(NSString *)optime{
    NSArray *arrayTime = [optime componentsSeparatedByString:@"-"];
    NSString *openTime = arrayTime[0];
    if ([IsStringNull isBlankString:openTime]) {
        return @"2";
    }
    NSArray *openTimeArr = [openTime componentsSeparatedByString:@":"];
    NSInteger openTimeHour = [openTimeArr[0] integerValue];
    NSInteger openTimeMin =[openTimeArr[1] integerValue];
    
    NSString *closeTime = arrayTime[1];
    NSArray *closeTimeArr = [closeTime componentsSeparatedByString:@":"];
    NSInteger closeTimeHour = [closeTimeArr[0] integerValue];;
    NSInteger closeTimeMin =[closeTimeArr[1] integerValue];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSDate *data =[NSDate date];
    NSString *nowDate = [dateFormatter stringFromDate:data];
    NSArray *nowTimeArr = [nowDate componentsSeparatedByString:@":"];
    NSInteger nowTimeHour = [nowTimeArr[0] integerValue];;
    NSInteger nowTimeMin =[nowTimeArr[1] integerValue];
    
    if (nowTimeHour < openTimeHour) {
        return @"2";
        
    }
    if (nowTimeHour > closeTimeHour) {
        return @"2";
    }
    
    //开门小时一样 分钟符合
    else if (nowTimeHour == openTimeHour && nowTimeMin <openTimeMin){
        return @"2";
    }
    else if (nowTimeHour == closeTimeHour && nowTimeHour >closeTimeHour){
        return @"2";
    }
    
    
    
    return @"1";
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
    shop.hidesBottomBarWhenPushed = YES;
   [self.navigationController pushViewController:shop animated:YES];
    NSLog(@"%@",indexPath);
    
}

#pragma mark - 轮播图代理方法
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSString *detail = [self.arrForBannerDetail objectAtIndex:index];
    
    if ([detail containsString:@"http"]) {
        HomeDetailWebView *webView = [[HomeDetailWebView alloc]init];
        webView.urlStr = detail;
        webView.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webView animated:YES];
        
    }
    NSLog(@"%ld",index);
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
    NSLog(@"%ld",index);
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
        
        // 设置定位的精确度，误差不超过10米,定位越精确，越耗电
        locationmanager.desiredAccuracy = 10;

        //设置寻址精度
        locationmanager.desiredAccuracy = kCLLocationAccuracyBest;
        locationmanager.distanceFilter = 5.0;
        [locationmanager startUpdatingLocation];
        
        // ios8要定位，要请求定位的权限
        if ([[UIDevice  currentDevice].systemVersion doubleValue] >= 8.0) {
            [locationmanager requestWhenInUseAuthorization];
        }
        
    }
}
#pragma mark CoreLocation delegate (定位失败)
//定位失败后调用此代理方法
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([CLLocationManager locationServicesEnabled])
    {
        //  判断用户是否允许程序获取位置权限
        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse||[CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedAlways)
        {
            //用户允许获取位置权限
        }else
        {
            //用户拒绝开启用户权限
            [self alertToOpenLocation];
           
        }
    
    }
    else
    {
        [self alertToOpenLocation];
    }

    NSLog(@"location Fail");
}
-(void)alertToOpenLocation{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"允许定位提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction =[UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if( [[UIApplication sharedApplication]canOpenURL:url] ) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark 定位成功后则执行此代理方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
   
   
    //旧址
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    //打印当前的经度与纬度
    NSLog(@"%f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    //反地理编码
    if (!strlatitude) {
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5/*延迟执行时间*/ * NSEC_PER_SEC));
        
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
             [self netWorkForShopList:0];
        });
   
    }
    strlatitude = [NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
    strlongitude = [NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:strlatitude forKey:UD_lat];
    [defaults setObject:strlongitude forKey:UD_long];
    //[defaults setObject:userPhone forKey:UD_USERPHONE];
    
    [defaults synchronize];
    
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (error !=nil || placemarks.count==0) {
            NSLog(@"%@",error);
            currentCity = ZBLocalized(@"未知城市", nil);
            headviewAddressLabel.text =currentCity;
            return ;
        }
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            currentCity = placeMark.locality;
            if (!currentCity) {
                currentCity = ZBLocalized(@"未知城市", nil);;
            }
            
            NSString *subLoc = placeMark.subLocality;
            NSString *locName = placeMark.name;
            if (subLoc == nil) {
                subLoc = @"";
            }
            if (locName == nil) {
                locName = @"";
            }
             NSString *locStr = [NSString stringWithFormat:@"%@ %@%@",currentCity,subLoc,locName];
            
             NSLog(@"%@",locStr);//具体地址
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:locName forKey:UD_AddR];
           // [defaults setObject:strlongitude forKey:UD_long];
            //[defaults setObject:userPhone forKey:UD_USERPHONE];
            
            [defaults synchronize];
            headviewAddressLabel.text = locName;
            
        }
        else{
           currentCity = ZBLocalized(@"未知城市", nil);;
             headviewAddressLabel.text =currentCity;
        }
    }];
    
     [locationmanager stopUpdatingHeading];
}

#pragma mark - 点击事件
-(void)tapSelectLeft{
    HomeTypeVC *shop = [[HomeTypeVC alloc]init];
    shop.typeName = ZBLocalized(@"优惠专区", nil);
    shop.TypeFlgStr = @"2";
    shop.strlatitude = strlatitude;
    shop.strlongitude = strlongitude;
    shop.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:shop animated:YES];
}
-(void)tapSelectRight{
    HomeTypeVC *shop = [[HomeTypeVC alloc]init];
    shop.typeName = ZBLocalized(@"优惠专区", nil);
    shop.TypeFlgStr = @"3";
    shop.strlatitude = strlatitude;
    shop.strlongitude = strlongitude;
    shop.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:shop animated:YES];
}
//点击了对应的筛选条件按钮操作
-(void)clickAction:(UIButton *)sender{
    NSLog(@"%ld",(long)sender.tag);
    self.chooseType = (int)sender.tag;
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
