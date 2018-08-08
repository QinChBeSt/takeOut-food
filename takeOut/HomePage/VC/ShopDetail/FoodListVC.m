//
//  FoodListVC.m
//  takeOut
//
//  Created by mac on 2018/3/26.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "FoodListVC.h"
#import "ModelForFoodList.h"
#import "ModelForChooseSize.h"
#import "CellForShopFood.h"
#import "CellForChooseSize.h"
#import "CellForShopFoodChooseSize.h"
#import "CellForHadAddShopingCar.h"
#import "ModForHadAddShoppingCar.h"
#import "SubmitOrderVC.h"
#import "NewLoginByPhoneVC.h"
#import "CellForFoodListLeft.h"
#import "CellForBox.h"
#define shoppingCarViewHeight 50

@interface FoodListVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UITableView *leftTable;
@property (nonatomic,strong) UITableView *rightTable;
@property (nonatomic,assign) BOOL isSelected;

@property (nonatomic , strong)NSMutableArray *arrForType;
//@property (nonatomic , strong)NSMutableArray *arrForDetal;

//选择大小份View
@property (nonatomic , strong)UIView *chooseSizeBackgroundView;
@property (nonatomic , strong)UIView *chooseSizeView;
@property (nonatomic , strong)UILabel *chooesTitle;
@property (nonatomic , strong)UILabel *choosePrice;
@property (nonatomic , strong)UICollectionView *collectionView;
@property (nonatomic , strong)NSMutableArray *arrForChooseSize;
@property (nonatomic , strong)UIButton *addBuyCarBtn;
@property (nonatomic , assign)NSInteger *RightTableViewSelelctRow;
@property (nonatomic ,assign)NSInteger *RightCollectionViewSelectceRow;

//购物车
@property (nonatomic ,strong)UIView *buyCarView;
@property (nonatomic ,strong)UILabel *buyCarAddLabel;
@property (nonatomic , strong)UILabel *startToBuyLabel;
@property (nonatomic , strong)UIButton *addBuyCarViewAddBtn;
@property (nonatomic , strong)NSMutableArray *arrForAddShoppingCarList;
@property (nonatomic , strong)NSMutableArray *arrForDelShoppingCar;
@property (nonatomic , copy)NSString *isDeleArr;
@property (nonatomic , copy)NSString *isAddArr;

@property (nonatomic , copy)NSString *selectbuyCarMoncy;
@property (nonatomic , copy)NSString *selcetbuyCarId;
@property (nonatomic , assign)CGFloat addMoney;
@property (nonatomic , assign)CGFloat AllBoxAddMoney;
@property (nonatomic , assign)CGFloat newBoxMoney;
@property (nonatomic , strong)UIImageView *imgShoppingCar;
//----小红点
//左边购物车小圆点选择行数
@property (nonatomic ,assign)NSInteger leftTableViewSelectRow;
//下面购物车小红点
@property (nonatomic , strong)UILabel *ShoppingCarRedLabel;
//下面购物车小红点数字
@property (nonatomic , assign)NSInteger ShoppingCarRedNum;

//显示已经购买的列表
@property (nonatomic , strong)UITableView *haveBuyListTableview;
@property (nonatomic , strong)UIView *haveBuyBackView;
@property (nonatomic , strong)NSMutableArray *arrForHaveBuyList;
@property (nonatomic , strong)NSIndexPath *rightChooseIndex;
@property (nonatomic , strong)UIButton *chooseSizeBackBtn;
@property (nonatomic , assign)BOOL isFirstShow;
@property (nonatomic , assign)NSInteger FirstShowCount;
@end

@implementation FoodListVC{
    NSUserDefaults *defaults;
}
-(void)viewWillAppear:(BOOL)animated{
    [self cleanAllData];
}
-(NSMutableArray *)arrForType{
    if (_arrForType == nil ) {
        _arrForType = [NSMutableArray array];
    }
    return _arrForType;
}
//-(NSMutableArray *)arrForDetal{
//    if (_arrForDetal == nil) {
//        _arrForDetal = [NSMutableArray array];
//    }
//    return _arrForDetal;
//}
-(NSMutableArray *)arrForChooseSize{
    if (_arrForChooseSize == nil) {
        _arrForChooseSize = [NSMutableArray array];
    }
    return _arrForChooseSize;
}
-(NSMutableArray *)arrForAddShoppingCarList{
    if (_arrForAddShoppingCarList == nil) {
        _arrForAddShoppingCarList = [NSMutableArray array];
    }
    return _arrForAddShoppingCarList;
}
-(NSMutableArray *)arrForDelShoppingCar{
    if (_arrForDelShoppingCar == nil) {
        _arrForDelShoppingCar = [NSMutableArray array];
    }
    return _arrForDelShoppingCar;
}
-(NSMutableArray *)arrForHaveBuyList{
    if (_arrForHaveBuyList == nil) {
        _arrForHaveBuyList = [NSMutableArray array];
    }
    return _arrForHaveBuyList;
}
#pragma makr - NetWork
-(void)getNetWork{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,shopDatailUrl];
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    int strid =[_shopId intValue];
    NSNumber *numShopId =[NSNumber numberWithInt:strid];
    [par setValue:numShopId forKey:@"shopid"];
    [MHNetWorkTask getWithURL:url withParameter:par withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
              
        self.arrForType = result[@"value"];
     
    
        for (int i = 0; i < self.arrForType.count; i++) {
            NSString *value = [NSString stringWithFormat:@"LEFTTABLEVIEW%d",i];
            [defaults setObject:nil forKey:value];
            
        }
//        NSMutableArray *arrayForBig;
//        NSMutableArray *arrayForSM;
//        NSMutableArray *arrayForValue = result[@"value"];
//        for (NSDictionary *dic in arrayForValue) {
//             NSArray *arr = dic[@"goodsLists"];
//            for (int i = 0;i<arr.count;i++){
//                NSString *picStr= [NSString stringWithFormat:@"%@",arr[i][@"pic"]];
//                if (![picStr isEqualToString:@"0"]) {
//                    [arrayForSM addObject arr[i]];
//                }
//            }
//
//        }

//        for (NSDictionary *dic in self.arrForType) {
//            NSArray *arr = dic[@"goodsLists"];
//            for (NSDictionary *dic1 in arr) {
//                ModelForFoodList *mod = [[ModelForFoodList alloc]init];
//                mod.id = [dic1[@"id"] intValue];
//                mod.godsname = dic1[@"godsname"];
//                mod.godslog = [NSString stringWithFormat:@"%@",dic1[@"godslog"]];
//                mod.ys = dic1[@"ys"];
//                mod.pic = [dic1[@"pic"] floatValue];
//                NSArray *array = dic1[@"goodspic"];
//                if (array != nil && ![array isKindOfClass:[NSNull class]] && array.count != 0){
//
//                    mod.goodspic = dic1[@"goodspic"];
//                    [self.arrForDetal addObject:mod];
//                }
//
//
//
//            }
//        }
        [self.leftTable reloadData];
         [self.leftTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        [self.rightTable reloadData];
    } withFail:^(NSError *error) {
        
    }];
}
-(void)getNetWorkForAddShoppingCar{
    NSString *Url1 = [NSString stringWithFormat:@"%@%@",BASEURL,AddShoppingCarUlr];
    
    NSString *userID = [defaults objectForKey:UD_USERID];
    
    if (userID == nil) {
        NSLog(@"去登录！！！");
        NewLoginByPhoneVC *login = [[NewLoginByPhoneVC alloc]init];
        [self.navigationController pushViewController:login animated:YES];
        return;
    }
    __block NSString *carid;
    __block NSString *pspic;
    __block NSString *yhpic;
    __block NSString *ypic;
    __block NSString *yhName;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [MBManager showLoadingInView:self.view];
    NSURL* url = [NSURL URLWithString:Url1];
    // 请求
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    // 超时
    request.timeoutInterval = 5;
    // 请求方式
    request.HTTPMethod = @"POST";
    
    // 设置请求体和参数
    // 创建一个描述订单的JSON数据
    if (self.arrForAddShoppingCarList == nil) {
        return;
    }
    [self.arrForHaveBuyList removeAllObjects];
    for (int i = 0 ; i < self.arrForAddShoppingCarList.count; i++) {
        NSMutableDictionary *dic = [self.arrForAddShoppingCarList objectAtIndex:i];
        
        
        //private int count; private int g_id; //商品id private String g_name; private String g_pic; private String g_log; private int goodsBoxNum; //盒子数量 private double goodsBoxPic; //盒子价格 private long goodsId; //规格id private String goodsPicName; //规格名
        
        NSMutableDictionary *dicPIC = dic[@"goodsPIC"];
        
        NSString *newgoodsId = dicPIC[@"goodsId"];
        NSString *newgoodPicName = dicPIC[@"goodsPicName"];
        NSString *goodsBoxNum = dicPIC[@"goodsBoxNum"];
        NSString *goodsBoxPic = dicPIC[@"goodsBoxPic"];
        NSString *goodsPicPic = dicPIC[@"goodsPicPic"];
        [dic removeObjectForKey:@"goodsPIC"];
        
        [dic setObject:newgoodsId forKey:@"goodsId"];
        [dic setObject:newgoodPicName forKey:@"goodsPicName"];
        [dic setObject:goodsBoxPic forKey:@"goodsBoxPic"];
        [dic setObject:goodsBoxNum forKey:@"goodsBoxNum"];
        //[dicPIC setObject:newgoodsId forKey:@"goodsPicPic"];
        
        NSIndexPath *del = dic[@"selectIndex"];
        NSMutableDictionary *deleDic  =[NSMutableDictionary dictionary];
        [deleDic setObject:del forKey:@"selectIndex"];
        [self.arrForDelShoppingCar addObject:deleDic];
        [dic removeObjectForKey:@"selectIndex"];
        [self.arrForHaveBuyList addObject:dic];
   
    }
    
    NSDictionary* orderInfo = @{@"s_id":self.shopId,
                                @"u_id":userID,
                                @"goods":self.arrForHaveBuyList};
//     NSError *error;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:orderInfo options:NSJSONWritingPrettyPrinted error:&error];
//
//    NSString *jsonString;
//
//    if (!jsonData) {
//
//
//
//    }else{
//
//        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//    }
//
//    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
//
//    NSRange range = {0,jsonString.length};
//
//    //去掉字符串中的空格
//
//    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
//
//    NSRange range2 = {0,mutStr.length};
//
//    //去掉字符串中的换行符
//
//    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    
    // OC对象转JSON
    NSData* json = [NSJSONSerialization dataWithJSONObject:orderInfo options:NSJSONWritingPrettyPrinted error:nil];
    // 设置请求头
    request.HTTPBody = json;
    // 设置请求头类型 (因为发送给服务器的参数类型已经不是普通数据,而是JSON)
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // 错误判断
        if (data==nil||error)return;
        // 解析JSON
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSString* resultErro = dic[@"error"];
        if (resultErro)
        { [MBManager hideAlert];
            NSLog(@"错误信息:%@",resultErro);
        }else
        { [MBManager hideAlert];
            NSLog(@"结果信息:%@",dic);
            NSMutableDictionary *dicRes = dic[@"value"];
            carid = dicRes[@"carid"];
            pspic = dicRes[@"pspic"];
            yhpic = dicRes[@"yhpic"];
            ypic = dicRes[@"ypic"];
            yhName = [NSString stringWithFormat:@"%@",dicRes[@"yhname"]];
            //信号量+1
            dispatch_semaphore_signal(semaphore);
            
        
        }
    }];
   
    [task resume];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    SubmitOrderVC *order = [[SubmitOrderVC alloc]init];
    order.carid = carid;
    order.pspic = pspic;
    order.yhpic = yhpic;
    order.ypic =ypic;
    order.YhNameStr = yhName;
    
    order.boxPic = [NSString stringWithFormat:@"%.2f",self.AllBoxAddMoney];
    order.shopId = self.shopId;
    order.arrForOrder = self.arrForHaveBuyList;
    [self.navigationController pushViewController:order animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isFirstShow = YES;
    defaults = [NSUserDefaults standardUserDefaults];
    self.ShoppingCarRedNum = 0;
    self.FirstShowCount = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTableView];
    [self addChooseView];
    [self createShopingCarView];
    [self getNetWork];
}
#pragma mark - UI
static NSString *const resueIdleft = @"leftCell";
static NSString *const resueIdright = @"rightCell";
static NSString *const resueIdrightChooseSize = @"rightCellChooseSize";
- (void)initTableView {
    
    self.leftTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width / 4, self.view.frame.size.height - SafeAreaTopHeight - 100 -36 - SafeAreaTabbarHeight - shoppingCarViewHeight) style:UITableViewStylePlain];
    self.leftTable.delegate = self;
    self.leftTable.dataSource = self;
    self.leftTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.leftTable.backgroundColor = [UIColor colorWithHexString:BaseBackgroundGray];
    self.leftTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.leftTable];
   // [self.leftTable registerClass:[UITableViewCell class] forCellReuseIdentifier:resueIdleft];
    [self.leftTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    self.rightTable = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 4, 0, self.view.frame.size.width / 4 * 3, self.view.frame.size.height - SafeAreaTopHeight - 100 -36 - SafeAreaTabbarHeight - shoppingCarViewHeight) style:UITableViewStylePlain];
    self.rightTable.dataSource = self;
    self.rightTable.delegate = self;
    self.rightTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.rightTable];
   // [self.rightTable registerClass:[CellForShopFood class] forCellReuseIdentifier:resueIdright];
    //[self.rightTable registerClass:[CellForShopFoodChooseSize class] forCellReuseIdentifier:resueIdrightChooseSize];
}
-(void)addChooseView{
    self.chooseSizeBackgroundView = [[UIView alloc]initWithFrame:self.view.frame];
    self.chooseSizeBackgroundView.backgroundColor = [UIColor colorWithHexString:@"8E9294" alpha:0.4];
    UITapGestureRecognizer *tapChooseView=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removewChooseView)];
    [self.chooseSizeBackgroundView addGestureRecognizer:tapChooseView];
    [self.view addSubview:self.chooseSizeBackgroundView];
    __weak typeof(self) ws = self;
    self.chooseSizeView = [[UIView alloc]init];
    self.chooseSizeView.layer.cornerRadius=10;
    
    self.chooseSizeView.clipsToBounds = YES;
    self.chooseSizeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.chooseSizeView];
    [self.chooseSizeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view.mas_top).offset(30);
        make.left.equalTo(ws.view.mas_left).offset(30);
        make.centerX.equalTo(ws.view.mas_centerX);
        make.height.equalTo(@(190));
    }];
    
    self.chooseSizeBackBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    self.chooseSizeBackBtn.layer.cornerRadius=15;
    [self.chooseSizeBackBtn setImage:[UIImage imageNamed:@"icon_guanbianniu"] forState:UIControlStateNormal];
    [self.chooseSizeBackBtn addTarget:self action:@selector(removewChooseView) forControlEvents:UIControlEventTouchUpInside];
    self.chooseSizeBackBtn.backgroundColor = [UIColor colorWithHexString:BaseBackgroundGray];
    self.chooseSizeBackBtn.clipsToBounds = YES;
    [self.view addSubview:self.chooseSizeBackBtn];
    [self.chooseSizeBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.chooseSizeView.mas_right).offset(-5);
        make.centerY.equalTo(ws.chooseSizeView.mas_top).offset(5);
        make.width.and.height.equalTo(@(30));
    }];
    
    [self.chooseSizeBackgroundView setHidden:YES];
    [self.chooseSizeView setHidden:YES];
    [self.chooseSizeBackBtn setHidden:YES];
    
    self.chooesTitle = [[UILabel alloc]init];
    [self.chooseSizeView addSubview:self.chooesTitle];
    [self.chooesTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.chooseSizeView.mas_top).offset(10);
        make.centerX.equalTo(ws.chooseSizeView);
    }];
    UIView *line = [[UIView alloc]init];
    [self.chooseSizeView addSubview:line];
    line.backgroundColor = [UIColor colorWithHexString:BaseBackgroundGray];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.chooseSizeView);
        make.top.equalTo(ws.chooesTitle.mas_bottom).offset(10);
        make.left.equalTo(ws.chooseSizeView).offset(15);
        make.height.equalTo(@(1));
    }];
    
    UILabel *sizeTit = [[UILabel alloc]init];
    sizeTit.text = ZBLocalized(@"规格", nil);
    sizeTit.font = [UIFont systemFontOfSize:14];
    sizeTit.textColor = [UIColor colorWithHexString:@"4b4b4b"];
    [self.chooseSizeView addSubview:sizeTit];
    [sizeTit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(line);
        make.top.equalTo(line.mas_bottom).offset(10);
    }];
    
    CGFloat itemWidth = (SCREEN_WIDTH - 105 )/ 3;
    CGFloat itemHeight = 30;
    UICollectionViewFlowLayout *shareflowLayout = [[UICollectionViewFlowLayout alloc] init];
    shareflowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    shareflowLayout.sectionInset =UIEdgeInsetsMake(5, 15, 5, 15);
    shareflowLayout.itemSize =CGSizeMake(itemWidth, itemHeight);
    // 1.设置列间距
    shareflowLayout.minimumInteritemSpacing = 7.5;
    // 2.设置行间距
    shareflowLayout.minimumLineSpacing = 5;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:shareflowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.chooseSizeView addSubview:self.collectionView];
    [self.collectionView registerClass:[CellForChooseSize class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.delaysContentTouches = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sizeTit.mas_bottom).offset(10);
        make.width.equalTo(ws.chooseSizeView);
        make.centerX.equalTo(ws.chooseSizeView);
        make.bottom.equalTo(ws.chooseSizeView.mas_bottom).offset(-40);
    }];
    
    UIView *priceBakcground = [[UIView alloc]init];
    [priceBakcground setBackgroundColor:[UIColor colorWithHexString:@"e7e7e7"]];
    [self.chooseSizeView addSubview:priceBakcground];
    [priceBakcground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(ws.chooseSizeView.mas_width);
        make.centerX.equalTo(ws.chooseSizeView.mas_centerX);
        make.bottom.equalTo(ws.chooseSizeView.mas_bottom);
        make.height.equalTo(@(40));
    }];
    
    self.choosePrice = [[UILabel alloc]init];
    self.choosePrice.text = @"0 元";
    self.choosePrice.textColor = [UIColor redColor];
    self.choosePrice.font = [UIFont systemFontOfSize:22];
    [self.chooseSizeView addSubview:self.choosePrice];
    [self.choosePrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.chooseSizeView.mas_left).offset(15);
        make.centerY.equalTo(priceBakcground.mas_centerY).offset(0);
    }];
    
    self.addBuyCarBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBuyCarBtn.backgroundColor = [UIColor colorWithHexString:BaseYellow];
    self.addBuyCarBtn.layer.cornerRadius = 15;
    [self.addBuyCarBtn setTitle:ZBLocalized(@"加入购物车", nil) forState:UIControlStateNormal];
    [self.addBuyCarBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.addBuyCarBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [self.addBuyCarBtn addTarget:self action:@selector(addBuyCar) forControlEvents:UIControlEventTouchUpInside];
    
    [self.chooseSizeView addSubview:self.addBuyCarBtn];
    [self.addBuyCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.choosePrice);
        make.right.equalTo(ws.chooseSizeView.mas_right).offset(-10);
        make.bottom.equalTo(ws.chooseSizeView.mas_bottom).offset(-5);
        make.width.equalTo(@(100));
    }];
   
  
}
-(void)createShopingCarView{
  
    if ([_acTypeStr isEqualToString:@"2"]) {
        __weak typeof(self) ws = self;
        self.buyCarView = [[UIView alloc]init];
        self.buyCarView.backgroundColor = [UIColor colorWithHexString:@"3b3e47"];
        [self.view addSubview:self.buyCarView];
        [self.buyCarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(ws.view.mas_bottom);
            make.width.equalTo(ws.view.mas_width);
            make.height.equalTo(@(shoppingCarViewHeight + SafeAreaTabbarHeight));
            make.centerX.equalTo(ws.view);
        }];
        
        self.imgShoppingCar = [[UIImageView alloc]init];
        [self.imgShoppingCar setImage:[UIImage imageNamed:@"icon_shangjiaxiangqinggouwu"]];
        [self.buyCarView addSubview:self.imgShoppingCar];
        [self.imgShoppingCar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(20));
            make.top.equalTo(@(5));
            
            make.centerY.equalTo(ws.buyCarView.mas_top).offset(shoppingCarViewHeight/2);
            make.width.equalTo(@(40));
        }];
        
        self.ShoppingCarRedLabel = [[UILabel alloc]init];
        self.ShoppingCarRedLabel.hidden = YES;
        self.ShoppingCarRedLabel.layer.cornerRadius = 10;
        self.ShoppingCarRedLabel.clipsToBounds = YES;
        self.ShoppingCarRedLabel.font = [UIFont systemFontOfSize:12];
        self.ShoppingCarRedLabel.textAlignment = NSTextAlignmentCenter;
           [self.imgShoppingCar setImage:[UIImage imageNamed:@"icon_shangjiaxiangqinggouwu"]];
        self.ShoppingCarRedLabel.textColor = [UIColor whiteColor];
        self.ShoppingCarRedLabel.backgroundColor = [UIColor redColor];
        [self.imgShoppingCar addSubview:self.ShoppingCarRedLabel];
        [self.ShoppingCarRedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.imgShoppingCar.mas_right).offset(10);
            make.bottom.equalTo(self.imgShoppingCar.mas_bottom).offset(3);
            make.width.equalTo(@(20));
            make.height.equalTo(@(20));
        }];
        
        self.buyCarAddLabel = [[UILabel alloc]init];
        self.buyCarAddLabel.text = @"0 元";
        self.buyCarAddLabel.font = [UIFont systemFontOfSize:22];
        self.buyCarAddLabel.textColor = [UIColor whiteColor];
        [self.buyCarView addSubview:self.buyCarAddLabel];
        [self.buyCarAddLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(ws.buyCarView.mas_top).offset(shoppingCarViewHeight/2);
            make.left.equalTo(self.imgShoppingCar.mas_right).offset(20);
        }];
        
        
        
        self.addBuyCarViewAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.addBuyCarViewAddBtn.enabled = NO;
        self.addBuyCarViewAddBtn.backgroundColor = [UIColor colorWithHexString:@"3b3e47"];
        self.addBuyCarViewAddBtn.layer.cornerRadius = 0;
        NSString *startPayMoney = [NSString stringWithFormat:@"%@%@%@",self.upPayMoney,ZBLocalized(@"฿", nil),ZBLocalized(@"起送", nil)];
        [self.addBuyCarViewAddBtn setTitle:startPayMoney forState:UIControlStateNormal];
        [self.addBuyCarViewAddBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.addBuyCarViewAddBtn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
        [self.addBuyCarViewAddBtn addTarget:self action:@selector(addShoppongCarNetWord) forControlEvents:UIControlEventTouchUpInside];
        self.addBuyCarViewAddBtn.titleLabel.numberOfLines = 2;
        [self.buyCarView addSubview:self.addBuyCarViewAddBtn];
        [self.addBuyCarViewAddBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.buyCarAddLabel);
            make.right.equalTo(ws.buyCarView.mas_right).offset(0);
            make.top.equalTo(ws.buyCarView.mas_top).offset(0);
            make.width.equalTo(@(SCREEN_WIDTH * 0.4));
        }];
        
        UIButton *addShowHaveBuyList = [UIButton buttonWithType:UIButtonTypeCustom];
        [addShowHaveBuyList addTarget:self action:@selector(showHaveBuyList) forControlEvents:UIControlEventTouchUpInside];
        [self.buyCarView addSubview:addShowHaveBuyList];
        [addShowHaveBuyList mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.buyCarAddLabel);
            make.right.equalTo(self.addBuyCarViewAddBtn.mas_left).offset(0);
            make.top.equalTo(ws.buyCarView.mas_top).offset(0);
            make.left.equalTo(ws.buyCarView.mas_left);
        }];
        
    }else{
        
        __weak typeof(self) ws = self;
        self.buyCarView = [[UIView alloc]init];
        self.buyCarView.backgroundColor = [UIColor colorWithHexString:@"3b3e47"];
        [self.view addSubview:self.buyCarView];
        [self.buyCarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(ws.view.mas_bottom);
            make.width.equalTo(ws.view.mas_width);
            make.height.equalTo(@(shoppingCarViewHeight + SafeAreaTabbarHeight));
            make.centerX.equalTo(ws.view);
        }];
        
        UILabel *openLab = [[UILabel alloc]init];
        openLab.text = ZBLocalized(@"该商家已打烊", nil);
        openLab.font = [UIFont systemFontOfSize:22];
        openLab.textColor = [UIColor whiteColor];
        [self.buyCarView addSubview:openLab];
        [openLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(ws.buyCarView.mas_top).offset(shoppingCarViewHeight/2);
            make.centerX.equalTo(ws.view);
        }];
    }
   
   
   
}

#pragma mark - 滚动刷新
#pragma mark ~~~~~~~~~~ TableViewDataSource ~~~~~~~~~~
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.rightTable) {
        return 100;
    }else if (tableView == self.leftTable){
        return kWidthScale(80);
    }
    return 50;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.rightTable) {
        return self.arrForType.count;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTable) {
        return self.arrForType.count;
    }else if (tableView == self.haveBuyListTableview ){
        if (self.AllBoxAddMoney == 0) {
            return self.arrForAddShoppingCarList.count;
        }else{
             return self.arrForAddShoppingCarList.count + 1;
        }
       
    
    }else if(tableView == self.rightTable){
    
         NSDictionary *item = [self.arrForType objectAtIndex:section];
        NSArray *arr = item[@"goodsLists"];
        return arr.count;
   

    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//左边========
    if (tableView == self.leftTable) {
        
        NSString *CellIdentifier = [NSString stringWithFormat:@"cellleft%ld%ld",indexPath.section,indexPath.row];
        CellForFoodListLeft *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            
            cell = [[CellForFoodListLeft alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
       NSDictionary *dic = [self.arrForType objectAtIndex:indexPath.row];
        cell.typeName.text = dic[@"goodsTypeEntity"][@"goodsTypeName"];
       // cell.backgroundColor = [UIColor colorWithHexString:BaseBackgroundGray];
        NSInteger nowRow = indexPath.row + 1;
        NSString *value = [NSString stringWithFormat:@"LEFTTABLEVIEW%ld",(long)indexPath.row];
         NSString *COUNT = [defaults objectForKey:value];
        if (nowRow == self.leftTableViewSelectRow && self.leftTableViewSelectRow != nil) {
            
          

                cell.redIcon.hidden = NO;
                
                cell.redIcon.text = COUNT;

            if ([COUNT isEqualToString:@"0"] || !COUNT) {
                cell.redIcon.hidden = YES;
                
                cell.redIcon.text = @"";
            }

           
        }
        if (COUNT.length == 0) {
            cell.redIcon.hidden = YES;
            
            cell.redIcon.text = @"";
        }
        return cell;
    }
//右边==============
    
    else if (tableView == self.rightTable) {
        NSMutableArray *arrForDetal= [[NSMutableArray alloc]init];
       NSDictionary *item = [self.arrForType objectAtIndex:indexPath.section];
        NSArray *arritem = item[@"goodsLists"];
        for (NSDictionary *dic1 in arritem) {
            ModelForFoodList *mod = [[ModelForFoodList alloc]init];
            mod.id = [dic1[@"id"] intValue];
            mod.godsname = dic1[@"godsname"];
            mod.godslog = [NSString stringWithFormat:@"%@",dic1[@"godslog"]];
            mod.ys = dic1[@"ys"];
            mod.pic =[dic1[@"pic"] floatValue];
            NSArray *array = dic1[@"goodspic"];
            if ([dic1[@"goodspic"] isKindOfClass:[NSNull class]] || array.count == 0){
                mod.goodspic = @[@{@"goodsId":dic1[@"id"],@"goodsPicName":@"",@"goodsPicPic":@"0",@"id":@"0"}];
                [arrForDetal addObject:mod];
               
            }else{
                mod.goodspic = dic1[@"goodspic"];
                [arrForDetal addObject:mod];
            }
            
      
        }
        
        
        ModelForFoodList *modArr = [arrForDetal objectAtIndex:indexPath.row];
       
//需要选大小尺码==================
        if (modArr.goodspic.count > 1) {
          NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
            CellForShopFoodChooseSize *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            ModelForFoodList *mod = [arrForDetal objectAtIndex:indexPath.row];
            if (!cell1) {
                
                cell1 = [[CellForShopFoodChooseSize alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                for (int i = 0; i < mod.goodspic.count; i++) {
                    NSString *cellValue = [NSString stringWithFormat:@"RightTableViewsection%ldrow%ld",indexPath.section,indexPath.row];
                    [defaults setObject:nil forKey:cellValue];
                }
               
            }
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            cell1.mod = mod;
            //选大小后加购物车
            cell1.blockChooseSize = ^(ModelForFoodList *mod1) {
              
                NSLog(@"%f",mod1.pic);
                if (![self.acTypeStr isEqualToString:@"2"]) {
                    [MBManager showBriefAlert:ZBLocalized(@"该商家已打烊", nil)];
                    return ;
                }
                self.RightCollectionViewSelectceRow
                = 0;
                self.RightTableViewSelelctRow = indexPath.row;
                self.rightChooseIndex = indexPath;
                self.chooesTitle.text = mod1.godsname;
                self.arrForChooseSize = mod1.goodspic;
                [self.collectionView reloadData];
                self.chooseSizeBackgroundView.hidden = NO;
                self.chooseSizeBackBtn.hidden = NO;
                self.chooseSizeView.hidden = NO;
                self.leftTableViewSelectRow = indexPath.section + 1;
                if (self.leftTableViewSelectRow == nil) {
                    self.leftTableViewSelectRow = 1;
                }
            };
            
            return cell1;
            
        }
        //直接加购物车=======================
        else{
            
            NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
            CellForShopFood *cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
             ModelForFoodList *mod = [arrForDetal objectAtIndex:indexPath.row];
            
            if (!cell2) {
                
                cell2 = [[CellForShopFood alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
               
            }
            cell2.selectionStyle = UITableViewCellSelectionStyleNone;
            cell2.mod = mod;
            cell2.acType = _acTypeStr;
            NSString *cellValue = [NSString stringWithFormat:@"RightTableViewsection%ldrow%ld",indexPath.section,indexPath.row];
            if (self.arrForAddShoppingCarList.count == 0) {
            
                [defaults setObject:nil forKey:cellValue];
            }
            NSInteger rightCellCount;
            NSString *rightCellCountStr = [defaults objectForKey:cellValue];
                rightCellCount = [rightCellCountStr integerValue];
        
            if (rightCellCount != 0) {
                [cell2.chooseCountLabel setHidden:NO];
                [cell2.delectToShoppingCar setHidden:NO];
                cell2.ChooseCount = rightCellCount;
                cell2.chooseCountLabel.text = [NSString stringWithFormat:@" %ld ",(long)rightCellCount];
            }else{
                [cell2.chooseCountLabel setHidden:YES];
                [cell2.delectToShoppingCar setHidden:YES];
                cell2.chooseCountLabel.text = @"";
            }
            
            
//添加购物车+++++++++++++++++++++++++++++++++
            cell2.blockAddShopingCar = ^(ModelForFoodList *mod2) {
                if (![self.acTypeStr isEqualToString:@"2"]) {
                    [MBManager showBriefAlert:ZBLocalized(@"该商家已打烊", nil)];
                    return ;
                }
                
                NSArray *arr = mod2.goodspic;
                NSDictionary *dic = arr[0];
                self.selectbuyCarMoncy = dic[@"goodsPicPic"];
                self.selcetbuyCarId = dic[@"id"];
                
                NSArray *arrGoodsPic =mod.goodspic;
                NSDictionary *goodsPIC = arrGoodsPic[0];
                CGFloat boxPic =[goodsPIC[@"goodsBoxPic"] floatValue];
                NSInteger boxCOUNT =[goodsPIC[@"goodsBoxNum"] integerValue];
                self.newBoxMoney = boxPic * boxCOUNT;
                self.AllBoxAddMoney = self.AllBoxAddMoney + self.newBoxMoney;
                
                [self addBuyCarNoSize];
                ModelForFoodList *mod11 = [arrForDetal objectAtIndex:indexPath.row];
                NSInteger removeIndex = 0;
                for (int i = 0 ; i < self.arrForAddShoppingCarList.count; i++) {
                    NSMutableDictionary *dicForChoose = [NSMutableDictionary dictionary];
                    dicForChoose = [self.arrForAddShoppingCarList objectAtIndex:i];
                    NSNumber * getGoodsId =  [NSNumber numberWithInteger:mod11.id];
                    NSIndexPath *getIndexpath = dicForChoose[@"selectIndex"];
                    
                    if (dicForChoose[@"g_id"] == getGoodsId && getIndexpath == indexPath) {
                        //已经添加过此商品 增加数量即可
                        self.isDeleArr = @"yes";
                        removeIndex = i;
                    }
                }
                if ([self.isDeleArr isEqualToString:@"yes"]) {
                    //已经添加过此商品 增加数量即可
                    NSMutableDictionary *dicForChoose = [NSMutableDictionary dictionary];
                    dicForChoose = [self.arrForAddShoppingCarList objectAtIndex:removeIndex];
                    NSInteger  GetgoodsCount = [dicForChoose[@"count"] integerValue];
                    GetgoodsCount = GetgoodsCount + 1;
                    NSNumber * goodsCount = [NSNumber numberWithInteger:GetgoodsCount];
                    [self.arrForAddShoppingCarList removeObjectAtIndex:removeIndex];
                    NSNumber * good_Id =  [NSNumber numberWithInteger:mod11.id];
                    NSString *picStr = [NSString stringWithFormat:@"%.2f",mod11.pic];
                    [dicForChoose setObject:goodsCount forKey:@"count"];
                    [dicForChoose setObject:good_Id forKey:@"g_id"];
                    [dicForChoose setObject:mod.godsname forKey:@"g_name"];
                    [dicForChoose setObject:picStr forKey:@"g_pic"];
                    [dicForChoose setObject:mod.godslog forKey:@"g_log"];
                    [dicForChoose setObject:indexPath forKey:@"selectIndex"];
                    [dicForChoose setObject:goodsPIC forKey:@"goodsPIC"];
                    [self.arrForAddShoppingCarList addObject:dicForChoose];
                    self.isDeleArr = @"no";
                }else{
                    //新添加的商品
                    NSNumber * good_Id =  [NSNumber numberWithInteger:mod11.id];
                    NSString *picStr = [NSString stringWithFormat:@"%.2f",mod11.pic];
                    NSNumber * goodsCount = [NSNumber numberWithInteger:1];
                    NSMutableDictionary *dicForChoose = [NSMutableDictionary dictionary];
                    [dicForChoose setObject:goodsCount forKey:@"count"];
                    [dicForChoose setObject:good_Id forKey:@"g_id"];
                    [dicForChoose setObject:mod.godsname forKey:@"g_name"];
                    [dicForChoose setObject:picStr forKey:@"g_pic"];
                    [dicForChoose setObject:mod.godslog forKey:@"g_log"];
                     [dicForChoose setObject:indexPath forKey:@"selectIndex"];
                    [dicForChoose setObject:goodsPIC forKey:@"goodsPIC"];
                    [self.arrForAddShoppingCarList addObject:dicForChoose];
                }
                if (self.arrForAddShoppingCarList.count != 0) {
                    CGFloat upPayF = [self.upPayMoney floatValue];
                    if (_addMoney >= upPayF) {
                        self.addBuyCarViewAddBtn.enabled = YES;
                        self.addBuyCarViewAddBtn.backgroundColor = [UIColor colorWithHexString:BaseYellow];
                        [self.addBuyCarViewAddBtn setTitle:ZBLocalized(@"去结算", nil) forState:UIControlStateNormal];
                        self.addBuyCarViewAddBtn.titleLabel.font = [UIFont systemFontOfSize:20];
                        [self.addBuyCarViewAddBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    }
                    
                }
            //左边小红点
                self.leftTableViewSelectRow = indexPath.section + 1;
                if (self.leftTableViewSelectRow == nil) {
                    self.leftTableViewSelectRow = 1;
                }
                NSString *value = [NSString stringWithFormat:@"LEFTTABLEVIEW%ld",(long)indexPath.section];
                NSString *countStr = [defaults objectForKey:value];
                NSInteger count = [countStr integerValue];
                count++;
                countStr = [NSString stringWithFormat:@"%ld",(long)count];
                
                NSString *cellValue = [NSString stringWithFormat:@"RightTableViewsection%ldrow%ld",indexPath.section,indexPath.row];
                NSInteger rightCellCount;
                NSString *rightCellCountStr = [defaults objectForKey:cellValue];
                if (rightCellCountStr  == nil) {
                    rightCellCount = 1;
                }else{
                    rightCellCount = [rightCellCountStr integerValue];
                    rightCellCount++;
                }
                if (rightCellCount != 0) {
                    [cell2.chooseCountLabel setHidden:NO];
                    [cell2.delectToShoppingCar setHidden:NO];
                }
                cell2.ChooseCount = rightCellCount;
                cell2.chooseCountLabel.text = [NSString stringWithFormat:@" %ld ",(long)rightCellCount];
                rightCellCountStr = [NSString stringWithFormat:@"%ld",(long)rightCellCount];
                [defaults setObject:rightCellCountStr forKey:cellValue];
                [defaults setObject:countStr forKey:value];
                [defaults synchronize];
                [self.leftTable reloadData];
                 [self.leftTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.section inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
                self.ShoppingCarRedNum++;
                self.ShoppingCarRedLabel.hidden = NO;
                self.ShoppingCarRedLabel.text = [NSString stringWithFormat:@"%ld",(long)_ShoppingCarRedNum];
                
                [self.imgShoppingCar setImage:[UIImage imageNamed:@"icon_shangjiaxiangqinggouwudown"]];
            };
            //减少商品---------------------------
            cell2.blockDelShopingCar = ^(ModelForFoodList *mod3) {
                NSArray *arr = mod3.goodspic;
                NSDictionary *dic = arr[0];
                self.selectbuyCarMoncy = dic[@"goodsPicPic"];
                self.selcetbuyCarId = dic[@"id"];
                
                NSArray *arrGoodsPic =mod.goodspic;
                NSDictionary *goodsPIC = arrGoodsPic[0];
                CGFloat boxPic =[goodsPIC[@"goodsBoxPic"] floatValue];
                NSInteger boxCOUNT =[goodsPIC[@"goodsBoxNum"] integerValue];
                self.newBoxMoney = boxPic * boxCOUNT;
                self.AllBoxAddMoney = self.AllBoxAddMoney - self.newBoxMoney;
                
                [self delectBuyCarNoSize];

                NSInteger removeIndex = 0;
                for (int i = 0 ; i < self.arrForAddShoppingCarList.count; i++) {
                    NSMutableDictionary *dicForChoose = [NSMutableDictionary dictionary];
                    dicForChoose = [self.arrForAddShoppingCarList objectAtIndex:i];
                    NSNumber * getGoodsId =  [NSNumber numberWithInteger:mod3.id];
                    NSIndexPath *getIndexPath = dicForChoose[@"selectIndex"];
                    if (dicForChoose[@"g_id"] == getGoodsId && indexPath == getIndexPath) {
                        //已经添加过此商品 增加数量即可
                        self.isAddArr = @"yes";
                        removeIndex = i;
                    }
                }
                if ([self.isAddArr isEqualToString:@"yes"]) {
                    //已经添加过此商品 增加数量即可
                    NSMutableDictionary *dicForChoose = [NSMutableDictionary dictionary];
                    dicForChoose = [self.arrForAddShoppingCarList objectAtIndex:removeIndex];
                    NSInteger  GetgoodsCount = [dicForChoose[@"count"] integerValue];
                    GetgoodsCount = GetgoodsCount - 1;
                    //减少后已选数量为0
                    if (GetgoodsCount != 0) {
                        NSNumber * goodsCount = [NSNumber numberWithInteger:GetgoodsCount];
                        [self.arrForAddShoppingCarList removeObjectAtIndex:removeIndex];
                        NSNumber * good_Id =  [NSNumber numberWithInteger:mod3.id];
                        NSString *picStr = [NSString stringWithFormat:@"%.2f",mod3.pic];
                        [dicForChoose setObject:goodsCount forKey:@"count"];
                        [dicForChoose setObject:good_Id forKey:@"g_id"];
                        [dicForChoose setObject:mod.godsname forKey:@"g_name"];
                        [dicForChoose setObject:picStr forKey:@"g_pic"];
                        [dicForChoose setObject:mod.godslog forKey:@"g_log"];
                         [dicForChoose setObject:indexPath forKey:@"selectIndex"];
                        [dicForChoose setObject:goodsPIC forKey:@"goodsPIC"];
                        [self.arrForAddShoppingCarList addObject:dicForChoose];
                        self.isDeleArr = @"no";
                    }else{
                        [self.arrForAddShoppingCarList removeObjectAtIndex:removeIndex];
                        self.isDeleArr = @"no";
                    }
                   
                }else{
                    //新添加的商品
                    NSNumber * good_Id =  [NSNumber numberWithInteger:mod3.id];
                    NSString *picStr = [NSString stringWithFormat:@"%.2f",mod3.pic];
                    NSNumber * goodsCount = [NSNumber numberWithInteger:1];
                    NSMutableDictionary *dicForChoose = [NSMutableDictionary dictionary];
                    [dicForChoose setObject:goodsCount forKey:@"count"];
                    [dicForChoose setObject:good_Id forKey:@"g_id"];
                    [dicForChoose setObject:mod.godsname forKey:@"g_name"];
                    [dicForChoose setObject:picStr forKey:@"g_pic"];
                    [dicForChoose setObject:mod.godslog forKey:@"g_log"];
                     [dicForChoose setObject:indexPath forKey:@"selectIndex"];
                    [dicForChoose setObject:goodsPIC forKey:@"goodsPIC"];
                    [self.arrForAddShoppingCarList addObject:dicForChoose];
                }
            
                //左边小红点
                self.leftTableViewSelectRow = indexPath.section + 1;
                if (self.leftTableViewSelectRow == nil) {
                    self.leftTableViewSelectRow = 1;
                }
                NSString *value = [NSString stringWithFormat:@"LEFTTABLEVIEW%ld",(long)indexPath.section];
                NSString *countStr = [defaults objectForKey:value];
                NSInteger count = [countStr integerValue];
                count--;
                countStr = [NSString stringWithFormat:@"%ld",(long)count];
                
                NSString *cellValue = [NSString stringWithFormat:@"RightTableViewsection%ldrow%ld",indexPath.section,indexPath.row];
                NSInteger rightCellCount;
                NSString *rightCellCountStr = [defaults objectForKey:cellValue];
                if (rightCellCountStr  == nil) {
                    rightCellCount = 1;
                }else{
                    rightCellCount = [rightCellCountStr integerValue];
                    rightCellCount--;
                }
                
                cell2.ChooseCount = rightCellCount;
                cell2.chooseCountLabel.text = [NSString stringWithFormat:@" %ld ",(long)rightCellCount];
                rightCellCountStr = [NSString stringWithFormat:@"%ld",(long)rightCellCount];
                if (rightCellCount == 0) {
                    [cell2.chooseCountLabel setHidden:YES];
                    [cell2.delectToShoppingCar setHidden:YES];
                    
                }
                [defaults setObject:rightCellCountStr forKey:cellValue];
                [defaults setObject:countStr forKey:value];
                [defaults synchronize];
                [self.leftTable reloadData];
                [self.leftTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.section inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
                self.ShoppingCarRedNum--;
                if (self.ShoppingCarRedNum == 0) {
                    self.ShoppingCarRedNum = 0;
                    self.ShoppingCarRedLabel.hidden = YES;
                    self.ShoppingCarRedLabel.text = [NSString stringWithFormat:@"%ld",(long)_ShoppingCarRedNum];
                       [self.imgShoppingCar setImage:[UIImage imageNamed:@"icon_shangjiaxiangqinggouwu"]];
                }else{
                self.ShoppingCarRedLabel.hidden = NO;
                self.ShoppingCarRedLabel.text = [NSString stringWithFormat:@"%ld",(long)_ShoppingCarRedNum];
                [self.imgShoppingCar setImage:[UIImage imageNamed:@"icon_shangjiaxiangqinggouwudown"]];
                }
                CGFloat upPayF = [self.upPayMoney floatValue];
                if (_addMoney < upPayF) {
                    self.addBuyCarViewAddBtn.enabled = NO;
                    self.addBuyCarViewAddBtn.backgroundColor = [UIColor colorWithHexString:@"3b3e47"];
   NSString *startPayMoney = [NSString stringWithFormat:@"%@%@%@",self.upPayMoney,ZBLocalized(@"฿", nil),ZBLocalized(@"起送", nil)];
                    [self.addBuyCarViewAddBtn setTitle:startPayMoney forState:UIControlStateNormal];
                    self.addBuyCarViewAddBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                    [self.addBuyCarViewAddBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }
            
    
                
            };
           
            return cell2;
            
        }
    }else if (tableView == _haveBuyListTableview){
        
        if (indexPath.row != self.arrForAddShoppingCarList.count ) {
            NSString *CellIdentifier = [NSString stringWithFormat:@"cellShowHaveBuy%ld%ld",indexPath.section,indexPath.row];
            ModForHadAddShoppingCar *mod = [[ModForHadAddShoppingCar alloc]init];
            NSMutableDictionary *dic = [self.arrForAddShoppingCarList objectAtIndex:indexPath.row];
            mod.g_id = dic[@"g_id"];
            mod.count = dic[@"count"];
            mod.g_name = dic[@"g_name"];
            mod.g_pic = dic[@"g_pic"];
            mod.g_log = dic[@"g_log"];
            mod.g_chooseType = dic[@"g_typeName"];
            mod.seleIndex = dic[@"selectIndex"];
            mod.g_goodsPic = dic[@"goodsPIC"];
            CellForHadAddShopingCar *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell1) {
                cell1 = [[CellForHadAddShopingCar alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            }
            
            
//================增加
            cell1.blockAddHadShopingCar = ^(ModForHadAddShoppingCar *mod) {
                NSInteger removeIndex = 0;
                NSIndexPath *chooseIndex ;
                for (int i = 0 ; i < self.arrForAddShoppingCarList.count; i++) {
                    NSMutableDictionary *dicForChoose = [NSMutableDictionary dictionary];
                    dicForChoose = [self.arrForAddShoppingCarList objectAtIndex:i];
                    
                    if (dicForChoose[@"g_id"] == mod.g_id && dicForChoose[@"selectIndex"] == mod.seleIndex) {
                        //已经添加过此商品 增加数量即可
                        removeIndex = i;
                        chooseIndex = dicForChoose[@"selectIndex"];
                    }
                }
                NSMutableDictionary *dicForChoose = [NSMutableDictionary dictionary];
                dicForChoose = [self.arrForAddShoppingCarList objectAtIndex:removeIndex];
                NSInteger  GetgoodsCount = [dicForChoose[@"count"] integerValue];
                GetgoodsCount = GetgoodsCount + 1;
                cell1.goodsCount.text = [NSString stringWithFormat:@"%ld",(long)GetgoodsCount];
                cell1.removeBtn.hidden = NO;
                CGFloat price = [mod.g_pic floatValue];
                //price = price * GetgoodsCount;
                NSString *priceStr = [NSString stringWithFormat:@"฿%.2f",price];
                cell1.goodsMoney.text =ZBLocalized(priceStr, nil);
                NSNumber * goodsCount = [NSNumber numberWithInteger:GetgoodsCount];
                [self.arrForAddShoppingCarList removeObjectAtIndex:removeIndex];
                [dicForChoose setObject:goodsCount forKey:@"count"];
                [dicForChoose setObject:mod.g_id forKey:@"g_id"];
                [dicForChoose setObject:mod.g_name forKey:@"g_name"];
                [dicForChoose setObject:mod.g_pic forKey:@"g_pic"];
                [dicForChoose setObject:mod.g_log forKey:@"g_log"];
                [dicForChoose setObject:chooseIndex forKey:@"selectIndex"];
                [dicForChoose setObject:mod.g_goodsPic forKey:@"goodsPIC"];
                [self.arrForAddShoppingCarList addObject:dicForChoose];
                
                //左边小红点
                self.leftTableViewSelectRow = chooseIndex.section + 1;
                if (self.leftTableViewSelectRow == nil) {
                    self.leftTableViewSelectRow = 1;
                }
                NSString *value = [NSString stringWithFormat:@"LEFTTABLEVIEW%ld",(long)chooseIndex.section];
                NSString *countStr = [defaults objectForKey:value];
                NSInteger count = [countStr integerValue];
                count++;
                countStr = [NSString stringWithFormat:@"%ld",(long)count];
                
                NSString *cellValue = [NSString stringWithFormat:@"RightTableViewsection%ldrow%ld",chooseIndex.section,chooseIndex.row];
                NSInteger rightCellCount;
                NSString *rightCellCountStr = [defaults objectForKey:cellValue];
                if (rightCellCountStr  == nil) {
                    rightCellCount = 1;
                }else{
                    rightCellCount = [rightCellCountStr integerValue];
                    rightCellCount++;
                }
                rightCellCountStr = [NSString stringWithFormat:@"%ld",(long)rightCellCount];
                [defaults setObject:rightCellCountStr forKey:cellValue];
                [defaults setObject:countStr forKey:value];
                [defaults synchronize];
                [self.leftTable reloadData];
                [self.rightTable reloadData];
                
                //底部数据
                NSDictionary *goodsPIC = mod.g_goodsPic;
                CGFloat boxPic =[goodsPIC[@"goodsBoxPic"] floatValue];
                NSInteger boxCOUNT =[goodsPIC[@"goodsBoxNum"] integerValue];
                self.newBoxMoney = boxPic * boxCOUNT;
                self.AllBoxAddMoney = self.AllBoxAddMoney + self.newBoxMoney;
                
                self.addMoney = [mod.g_pic floatValue] + self.addMoney + self.newBoxMoney;
                self.buyCarAddLabel.text = [NSString stringWithFormat:@"%@ %.2f",ZBLocalized(@"฿", nil),self.addMoney];
                self.ShoppingCarRedNum++;
                self.ShoppingCarRedLabel.text = [NSString stringWithFormat:@"%ld",(long)self.ShoppingCarRedNum];
                [self.imgShoppingCar setImage:[UIImage imageNamed:@"icon_shangjiaxiangqinggouwudown"]];
                CGFloat upPayF = [self.upPayMoney floatValue];
                if (_addMoney >= upPayF) {
                    self.addBuyCarViewAddBtn.enabled = YES;
                    self.addBuyCarViewAddBtn.backgroundColor = [UIColor colorWithHexString:BaseYellow];
                    [self.addBuyCarViewAddBtn setTitle:ZBLocalized(@"去结算", nil) forState:UIControlStateNormal];
                    self.addBuyCarViewAddBtn.titleLabel.font = [UIFont systemFontOfSize:20];
                    [self.addBuyCarViewAddBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                }
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.arrForAddShoppingCarList.count inSection:0];
                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            };
            
            
            
//================减少
            cell1.blockDelHadShopingCar = ^(ModForHadAddShoppingCar *mod) {
                NSInteger removeIndex = 0;
                NSIndexPath *chooseIndex ;
                for (int i = 0 ; i < self.arrForAddShoppingCarList.count; i++) {
                    NSMutableDictionary *dicForChoose = [NSMutableDictionary dictionary];
                    dicForChoose = [self.arrForAddShoppingCarList objectAtIndex:i];
                    
                    if (dicForChoose[@"g_id"] == mod.g_id && dicForChoose[@"selectIndex"] == mod.seleIndex) {
                        //已经添加过此商品 增加数量即可
                        removeIndex = i;
                        chooseIndex = dicForChoose[@"selectIndex"];
                    }
                    
                }
                NSMutableDictionary *dicForChoose = [NSMutableDictionary dictionary];
                dicForChoose = [self.arrForAddShoppingCarList objectAtIndex:removeIndex];
                NSInteger  GetgoodsCount = [dicForChoose[@"count"] integerValue];
                GetgoodsCount = GetgoodsCount - 1;
                cell1.goodsCount.text = [NSString stringWithFormat:@"%ld",(long)GetgoodsCount];
                CGFloat price = [mod.g_pic floatValue];
               // price = price * GetgoodsCount;
                NSString *priceStr = [NSString stringWithFormat:@"฿%.2f",price];
                cell1.goodsMoney.text =ZBLocalized(priceStr, nil);
                NSNumber * goodsCount = [NSNumber numberWithInteger:GetgoodsCount];
                
                if (GetgoodsCount != 0) {
                    [self.arrForAddShoppingCarList removeObjectAtIndex:removeIndex];
                    [dicForChoose setObject:goodsCount forKey:@"count"];
                    [dicForChoose setObject:mod.g_id forKey:@"g_id"];
                    [dicForChoose setObject:mod.g_name forKey:@"g_name"];
                    [dicForChoose setObject:mod.g_pic forKey:@"g_pic"];
                    [dicForChoose setObject:mod.g_log forKey:@"g_log"];
                    [dicForChoose setObject:chooseIndex forKey:@"selectIndex"];
                    [self.arrForAddShoppingCarList addObject:dicForChoose];
                }else{
                    [self.arrForAddShoppingCarList removeObjectAtIndex:removeIndex];
                    if (self.arrForAddShoppingCarList.count == 0) {
                        [self cleanAllData];
                        return ;
                    }
                    [self.haveBuyListTableview reloadData];
                    [self.haveBuyListTableview mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self.buyCarView);
                        make.width.equalTo(self.view);
                        make.bottom.equalTo(self.buyCarView.mas_top);
                        make.height.equalTo(@(self.arrForAddShoppingCarList.count * 50 + 40 + 50));
                    }];
                    
                    if (self.arrForAddShoppingCarList.count == 0) {
                        
                        [self.haveBuyBackView  removeFromSuperview];
                        
                        self.addBuyCarViewAddBtn.backgroundColor = [UIColor colorWithHexString:@"3b3e47"];
                        self.addBuyCarViewAddBtn.enabled = NO;
                        NSString *startPayMoney = [NSString stringWithFormat:@"%@%@%@",self.upPayMoney,ZBLocalized(@"฿", nil),ZBLocalized(@"起送", nil)];
                        self.addBuyCarViewAddBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                        [self.addBuyCarViewAddBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        [self.addBuyCarViewAddBtn setTitle:startPayMoney forState:UIControlStateNormal];
                    }
                }
                
                
                //左边小红点
                self.leftTableViewSelectRow = chooseIndex.section + 1;
                if (self.leftTableViewSelectRow == nil) {
                    self.leftTableViewSelectRow = 1;
                }
                NSString *value = [NSString stringWithFormat:@"LEFTTABLEVIEW%ld",(long)chooseIndex.section];
                NSString *countStr = [defaults objectForKey:value];
                NSInteger count = [countStr integerValue];
                count--;
                countStr = [NSString stringWithFormat:@"%ld",(long)count];
                
                NSString *cellValue = [NSString stringWithFormat:@"RightTableViewsection%ldrow%ld",chooseIndex.section,chooseIndex.row];
                NSInteger rightCellCount;
                NSString *rightCellCountStr = [defaults objectForKey:cellValue];
                if (rightCellCountStr  == nil) {
                    rightCellCount = 1;
                }else{
                    rightCellCount = [rightCellCountStr integerValue];
                    rightCellCount--;
                }
                rightCellCountStr = [NSString stringWithFormat:@"%ld",(long)rightCellCount];
                [defaults setObject:rightCellCountStr forKey:cellValue];
                [defaults setObject:countStr forKey:value];
                [defaults synchronize];
                [self.leftTable reloadData];
                [self.rightTable reloadData];
                
                //底部数据
                NSDictionary *goodsPIC = mod.g_goodsPic;
                CGFloat boxPic =[goodsPIC[@"goodsBoxPic"] floatValue];
                NSInteger boxCOUNT =[goodsPIC[@"goodsBoxNum"] integerValue];
                self.newBoxMoney = boxPic * boxCOUNT;
                self.AllBoxAddMoney = self.AllBoxAddMoney - self.newBoxMoney;
                
                self.addMoney =  self.addMoney -[mod.g_pic floatValue] - self.newBoxMoney;
                self.buyCarAddLabel.text = [NSString stringWithFormat:@"%@ %.2f",ZBLocalized(@"฿", nil),self.addMoney];
                CGFloat upPayF = [self.upPayMoney floatValue];
                if (_addMoney < upPayF) {
                    self.addBuyCarViewAddBtn.enabled = NO;
                    self.addBuyCarViewAddBtn.backgroundColor = [UIColor colorWithHexString:@"3b3e47"];
                    NSString *startPayMoney = [NSString stringWithFormat:@"%@%@%@",self.upPayMoney,ZBLocalized(@"฿", nil),ZBLocalized(@"起送", nil)];
                    [self.addBuyCarViewAddBtn setTitle:startPayMoney forState:UIControlStateNormal];
                    self.addBuyCarViewAddBtn.titleLabel.font = [UIFont systemFontOfSize:14];
                    [self.addBuyCarViewAddBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.arrForAddShoppingCarList.count inSection:0];
                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
                
                self.ShoppingCarRedNum--;
                if (self.ShoppingCarRedNum == 0) {
                    self.ShoppingCarRedNum = 0;
                    self.ShoppingCarRedLabel.hidden = YES;
                    self.ShoppingCarRedLabel.text = [NSString stringWithFormat:@"%ld",(long)_ShoppingCarRedNum];
                    [self.imgShoppingCar setImage:[UIImage imageNamed:@"icon_shangjiaxiangqinggouwu"]];
                    
                }else{
                    self.ShoppingCarRedLabel.hidden = NO;
                    self.ShoppingCarRedLabel.text = [NSString stringWithFormat:@"%ld",(long)_ShoppingCarRedNum];
                    [self.imgShoppingCar setImage:[UIImage imageNamed:@"icon_shangjiaxiangqinggouwudown"]];
                }
                
            };
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            cell1.Mod = mod;
            return cell1;
        }
        
        //包装费CELL
        else{
            
            NSString *CellIdentifier = [NSString stringWithFormat:@"cellShowHaveBoxBuy%ld%ld",indexPath.section,indexPath.row];
            CellForBox *cellBOX = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cellBOX) {
                cellBOX = [[CellForBox alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            }
            cellBOX.goodsName.text = ZBLocalized(@"包装费", nil);
            cellBOX.goodsMoney.text = [NSString stringWithFormat:@"฿%.2f",self.AllBoxAddMoney];
            
            return cellBOX;
        }
      
    }
    return  nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == self.rightTable) {
       NSDictionary * dic = [self.arrForType objectAtIndex:section];
        NSString *tit = dic[@"goodsTypeEntity"][@"goodsTypeName"];
        
        return tit;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTable) {
        [self.rightTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        self.isSelected = YES;
        
    }
}

// 头部视图将要显示时调用
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (tableView == self.rightTable) {
        
        if ([view isKindOfClass: [UITableViewHeaderFooterView class]]) {
            UITableViewHeaderFooterView* castView = (UITableViewHeaderFooterView*) view;
            UIView* content = castView.contentView;
            UIColor* color = [UIColor whiteColor]; // substitute your color here
            content.backgroundColor = color;
        }
        
        // 判断，如果是左边点击触发的滚动，这不执行下面代码
        if (self.isSelected) {
            return;
        }
        self.FirstShowCount ++;
        if (self.FirstShowCount > self.arrForType.count) {
            self.isFirstShow = NO;
            
        }
        if (self.isFirstShow == YES) {
           
            
            return;
        }
        
        
        // 获取可见视图的第一个row
        //NSInteger currentSection = [[[self.rightTable indexPathsForVisibleRows] firstObject] section];
       // NSIndexPath *index = [NSIndexPath indexPathForRow:currentSection inSection:0];
        NSIndexPath *index = [NSIndexPath indexPathForRow:section inSection:0];
        // 点击左边对应区块
        [self.leftTable selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionTop];
        
    }
}

// 开始拖动赋值没有点击
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    // 当右边视图将要开始拖动时，则认为没有被点击了。
    self.isSelected = NO;
}

#pragma mark collectionView代理方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.arrForChooseSize.count == nil) {
        return 1;
    }
    return self.arrForChooseSize.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CellForChooseSize *cell = (CellForChooseSize *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithHexString:@"e7e7e7"];
    if (self.arrForChooseSize.count != 0) {
        NSDictionary *dic = [self.arrForChooseSize objectAtIndex:indexPath.row];
        cell.nameLabel.text = dic[@"goodsPicName"];
        NSString * pieceStr =[NSString stringWithFormat:@"%@",self.arrForChooseSize[0][@"goodsPicPic"]];
       
        NSString *piece = [NSString stringWithFormat:@"฿ %.2f",[pieceStr floatValue]];
        self.selectbuyCarMoncy =self.arrForChooseSize[0][@"goodsPicPic"];
        self.choosePrice.text = ZBLocalized(piece, nil) ;
  
        NSString *boxPicStr = [NSString stringWithFormat:@"%@",self.arrForChooseSize[0][@"goodsBoxPic"]];
        if ([IsStringNull isBlankString:boxPicStr]) {
            boxPicStr = @"0";
        }
        
        NSString *boxNumStr = [NSString stringWithFormat:@"%@",self.arrForChooseSize[0][@"goodsBoxNum"]];
        if ([IsStringNull isBlankString:boxNumStr]) {
            boxNumStr = @"0";
        }
        
        CGFloat boxPic =[boxPicStr floatValue];
        NSInteger boxCOUNT =[boxNumStr integerValue];
        self.newBoxMoney = boxPic * boxCOUNT;
       
   
    }
    
   [self.collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    self.RightCollectionViewSelectceRow = indexPath.row;
    NSDictionary *dic = [self.arrForChooseSize objectAtIndex:indexPath.row];
    NSString *strPic = dic[@"goodsPicPic"];
    self.selectbuyCarMoncy = dic[@"goodsPicPic"];
    self.selcetbuyCarId = dic[@"id"];
    
    
    
    NSString *boxPicStr = [NSString stringWithFormat:@"%@",self.arrForChooseSize[0][@"goodsBoxPic"]];
    if ([IsStringNull isBlankString:boxPicStr]) {
        boxPicStr = @"0";
    }
    
    NSString *boxNumStr = [NSString stringWithFormat:@"%@",self.arrForChooseSize[0][@"goodsBoxNum"]];
    if ([IsStringNull isBlankString:boxNumStr]) {
        boxNumStr = @"0";
    }
    
    CGFloat boxPic =[boxPicStr floatValue];
    NSInteger boxCOUNT =[boxNumStr integerValue];
   
    self.newBoxMoney = boxPic * boxCOUNT;

    NSString *piece = [NSString stringWithFormat:@"฿ %.2f",[strPic floatValue]];
    self.choosePrice.text = ZBLocalized(piece, nil) ;
    
}

#pragma mark - 点击事件
-(void)removewChooseView{
    [self.chooseSizeBackgroundView setHidden:YES];
    [self.chooseSizeView setHidden:YES];
    [self.chooseSizeBackBtn setHidden:YES];
}
-(void)addBuyCar{
    NSLog(@"%@,%f",self.selectbuyCarMoncy,self.addMoney);
    [self removewChooseView];
     self.AllBoxAddMoney = self.AllBoxAddMoney + self.newBoxMoney;
    self.addMoney = [self.selectbuyCarMoncy floatValue] + self.addMoney + self.newBoxMoney;
    self.buyCarAddLabel.text = [NSString stringWithFormat:@"%@ %.2f",ZBLocalized(@"฿", nil),self.addMoney];
    NSInteger row = self.leftTableViewSelectRow - 1;
    NSString *value = [NSString stringWithFormat:@"LEFTTABLEVIEW%ld",(long)row];
    NSString *countStr = [defaults objectForKey:value];
    NSInteger count = [countStr integerValue];
    count++;
    countStr = [NSString stringWithFormat:@"%ld",(long)count];
    [defaults setObject:countStr forKey:value];
    [defaults synchronize];
    [self.leftTable reloadData];
    [self.leftTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.leftTableViewSelectRow - 1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    self.ShoppingCarRedNum++;
    
    CGFloat upPayF = [self.upPayMoney floatValue];
    if (_addMoney >= upPayF) {
        
    }
    
    
    self.ShoppingCarRedLabel.hidden = NO;
    self.ShoppingCarRedLabel.text = [NSString stringWithFormat:@"%ld",(long)_ShoppingCarRedNum];
   [self.imgShoppingCar setImage:[UIImage imageNamed:@"icon_shangjiaxiangqinggouwudown"]];
    
    NSInteger removeIndex;
    
    if (self.RightCollectionViewSelectceRow == nil) {
        self.RightCollectionViewSelectceRow == 0;
    }
    NSInteger RightRow = self.RightCollectionViewSelectceRow;
    
    NSMutableArray *arrForDetal = [[NSMutableArray alloc]init];
    NSDictionary *item = [self.arrForType objectAtIndex:self.leftTableViewSelectRow - 1];
    NSArray *arritem = item[@"goodsLists"];
    for (NSDictionary *dic1 in arritem) {
        ModelForFoodList *mod = [[ModelForFoodList alloc]init];
        mod.id = [dic1[@"id"] intValue];
        mod.godsname = dic1[@"godsname"];
        mod.godslog = [NSString stringWithFormat:@"%@",dic1[@"godslog"]];
        mod.ys = dic1[@"ys"];
        mod.pic = [dic1[@"pic"] floatValue];
        NSArray *array = dic1[@"goodspic"];
        if (array != nil && ![array isKindOfClass:[NSNull class]] && array.count != 0){
            
            mod.goodspic = dic1[@"goodspic"];
            [arrForDetal addObject:mod];
        }
        
        
        
    }
    
     ModelForFoodList *mod = [arrForDetal objectAtIndex:self.RightTableViewSelelctRow];
   

    for (int i = 0 ; i < self.arrForAddShoppingCarList.count; i++) {
        NSMutableDictionary *dicFor = [NSMutableDictionary dictionary];
        dicFor = [self.arrForAddShoppingCarList objectAtIndex:i];
        NSUInteger getGoodId = dicFor[@"g_id"];//获取的数组存的ID
        NSIndexPath *getSelectIndexPath = dicFor[@"selectIndex"];
        
         NSArray *arr = mod.goodspic;//获取点击数据的ID
         NSDictionary *dic = [arr objectAtIndex:RightRow];
        NSInteger setGoodSID = dic[@"id"];
        NSIndexPath *setSelectIndexPath =self.rightChooseIndex;
        if (getGoodId == setGoodSID && getSelectIndexPath == setSelectIndexPath) {
            //已经添加过此商品 增加数量即可
            self.isDeleArr = @"yes";
            removeIndex = i;
        }
    }
    if ([self.isDeleArr isEqualToString:@"yes"]) {
        //已经添加过此商品 增加数量即可
        NSMutableDictionary *dicForChoose = [NSMutableDictionary dictionary];
        dicForChoose = [self.arrForAddShoppingCarList objectAtIndex:removeIndex];
        NSInteger  GetgoodsCount = [dicForChoose[@"count"] integerValue];
        GetgoodsCount = GetgoodsCount + 1;
        NSNumber * goodsCount = [NSNumber numberWithInteger:GetgoodsCount];
        [self.arrForAddShoppingCarList removeObjectAtIndex:removeIndex];
       
        NSArray *arr = mod.goodspic;//获取点击数据的ID
        NSDictionary *dic = [arr objectAtIndex:RightRow];
        //  NSString *setGoodSID =[NSString stringWithFormat:@"%@",dic[@"id"]] ;
        // NSNumber * good_Id =  [NSNumber numberWithInteger:setGoodSID];
        NSString *picStr = [NSString stringWithFormat:@"%@",dic[@"goodsPicPic"]];
        NSString *gName = [NSString stringWithFormat:@" %@",self.chooesTitle.text];
        [dicForChoose setObject:goodsCount forKey:@"count"];
        [dicForChoose setObject:dic[@"id"] forKey:@"g_id"];
        [dicForChoose setObject:gName forKey:@"g_name"];
        [dicForChoose setObject:picStr forKey:@"g_pic"];
        [dicForChoose setObject:mod.godslog forKey:@"g_log"];
        [dicForChoose setObject:self.chooesTitle.text forKey:@"g_typeName"];
        [dicForChoose setObject:self.rightChooseIndex forKey:@"selectIndex"];
        [dicForChoose setObject:dic forKey:@"goodsPIC"];
        [self.arrForAddShoppingCarList addObject:dicForChoose];
        self.isDeleArr = @"no";
    }else{
        //新添加的商品
        NSMutableDictionary *dicForChoose = [NSMutableDictionary dictionary];
        NSArray *arr = mod.goodspic;//获取点击数据的ID
        NSDictionary *dic = [arr objectAtIndex:RightRow];
      //  NSString *setGoodSID =[NSString stringWithFormat:@"%@",dic[@"id"]] ;
        NSInteger  GetgoodsCount = 1;
        NSNumber * goodsCount = [NSNumber numberWithInteger:GetgoodsCount];
       // NSNumber * good_Id =  [NSNumber numberWithInteger:setGoodSID];
        NSString *picStr = [NSString stringWithFormat:@"%@",dic[@"goodsPicPic"]];
         NSString *gName = [NSString stringWithFormat:@" %@",self.chooesTitle.text];
        [dicForChoose setObject:goodsCount forKey:@"count"];
        [dicForChoose setObject:dic[@"id"] forKey:@"g_id"];
        [dicForChoose setObject:gName forKey:@"g_name"];
        [dicForChoose setObject:picStr forKey:@"g_pic"];
        [dicForChoose setObject:mod.godslog forKey:@"g_log"];
        [dicForChoose setObject:self.chooesTitle.text forKey:@"g_typeName"];
         [dicForChoose setObject:self.rightChooseIndex forKey:@"selectIndex"];
        [dicForChoose setObject:dic forKey:@"goodsPIC"];
        [self.arrForAddShoppingCarList addObject:dicForChoose];
    
    }
    if (self.arrForAddShoppingCarList.count != 0) {
        CGFloat upPayF = [self.upPayMoney floatValue];
        if (_addMoney >= upPayF) {
            self.addBuyCarViewAddBtn.enabled = YES;
            self.addBuyCarViewAddBtn.backgroundColor = [UIColor colorWithHexString:BaseYellow];
            [self.addBuyCarViewAddBtn setTitle:ZBLocalized(@"去结算", nil) forState:UIControlStateNormal];
            self.addBuyCarViewAddBtn.titleLabel.font = [UIFont systemFontOfSize:20];
            [self.addBuyCarViewAddBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    
}
-(void)DelectBuyCar{
    
}
-(void)addBuyCarNoSize{
    NSLog(@"当前购物车%@,加上新的%f",self.selectbuyCarMoncy,self.addMoney);
    self.addMoney = [self.selectbuyCarMoncy floatValue] + self.addMoney + self.newBoxMoney;
    self.buyCarAddLabel.text = [NSString stringWithFormat:@"%@ %.2f",ZBLocalized(@"฿", nil),self.addMoney];
}
-(void)delectBuyCarNoSize{
    NSLog(@"当前购物车%@,减去取消的%f",self.selectbuyCarMoncy,self.addMoney);
    self.addMoney =   self.addMoney  - [self.selectbuyCarMoncy floatValue] - self.newBoxMoney;
    self.buyCarAddLabel.text = [NSString stringWithFormat:@"%@ %.2f",ZBLocalized(@"฿", nil),self.addMoney];
}

-(void)showHaveBuyList{
    if (self.arrForAddShoppingCarList.count == 0) {
        return;
    }else{
    self.haveBuyBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , SCREENH_HEIGHT)];
        self.haveBuyBackView.backgroundColor = [UIColor colorWithHexString:@"1C1C1C" alpha:0.6];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeHaveBuy)];
    [self.haveBuyBackView addGestureRecognizer:tapGesture];
     self.haveBuyBackView.backgroundColor = [UIColor colorWithHexString:@"9C9C9C" alpha:0.5];
     self.haveBuyBackView.backgroundColor = [UIColor clearColor];
    [self.view addSubview: self.haveBuyBackView];

    UIView *haveBuyToolBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    [self.view addSubview:haveBuyToolBar];
    haveBuyToolBar.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    
    UILabel *toolBatTitle = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 150, 40)];
        toolBatTitle.font = [UIFont systemFontOfSize:14];
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:ZBLocalized(@"BEEORDER配送", nil)];
        //获取要调整颜色的文字位置,调整颜色
    NSRange range1=[[hintString string]rangeOfString:ZBLocalized(@"BEEORDER", nil)];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:BaseYellow] range:range1];
   
    toolBatTitle.attributedText =hintString;
    [haveBuyToolBar addSubview:toolBatTitle];
    
    UIButton *CleanBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [CleanBtn setTitle:ZBLocalized(@"清空购物车", nil) forState:UIControlStateNormal];
        [CleanBtn setTitleColor:[UIColor colorWithHexString:@"4b4b4b"] forState:UIControlStateNormal];
        CleanBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [CleanBtn addTarget:self action:@selector(cleanAllData) forControlEvents:UIControlEventTouchUpInside];
    [haveBuyToolBar addSubview:CleanBtn];
    [CleanBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(haveBuyToolBar);
        make.right.equalTo(haveBuyToolBar.mas_right).offset(-10);
        make.height.equalTo(haveBuyToolBar);
        make.width.equalTo(@(SCREEN_WIDTH / 3));
    }];
        UIImageView *cleanImg = [[UIImageView alloc]init];
        [cleanImg setImage:[UIImage imageNamed:@"icon_shangjiaxiangqingli"]];
        [haveBuyToolBar addSubview:cleanImg];
        [cleanImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(CleanBtn);
            make.right.equalTo(CleanBtn.mas_left).offset(-5);
            make.width.and.height.equalTo(@(15));
        }];
    self.haveBuyListTableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.haveBuyListTableview.delegate = self;
    self.haveBuyListTableview.dataSource = self;
    self.haveBuyListTableview.tableHeaderView = haveBuyToolBar;
    [ self.haveBuyBackView addSubview:self.haveBuyListTableview];
        int lineCount ;
        if (self.AllBoxAddMoney == 0) {
            lineCount = self.arrForAddShoppingCarList.count;
            
        }else{
            lineCount = self.arrForAddShoppingCarList.count + 1;
        }
    [self.haveBuyListTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.buyCarView);
        make.width.equalTo(self.view);
        make.bottom.equalTo(self.buyCarView.mas_top);
        make.height.equalTo(@(lineCount * 50 + 40));
    }];
    }
}
-(void)removeHaveBuy{
    [self.haveBuyBackView  removeFromSuperview];
}
-(void)cleanAllData{
   self.addBuyCarViewAddBtn.enabled =NO;
    self.addBuyCarViewAddBtn.backgroundColor = [UIColor colorWithHexString:@"3b3e47"];
 
     NSString *startPayMoney = [NSString stringWithFormat:@"%@%@%@",self.upPayMoney,ZBLocalized(@"฿", nil),ZBLocalized(@"起送", nil)];
    [self.addBuyCarViewAddBtn setTitle:startPayMoney forState:UIControlStateNormal];
    self.addBuyCarViewAddBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.addBuyCarViewAddBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    for (int i = 0; i < self.arrForType.count; i++) {
        NSString *value = [NSString stringWithFormat:@"LEFTTABLEVIEW%d",i];
        [defaults setObject:nil forKey:value];
    }
    NSInteger removeIndex = 0;
    NSIndexPath *chooseIndex ;
    for (int i = 0; i < self.arrForDelShoppingCar.count; i++) {
        NSMutableDictionary *dicForChoose = [NSMutableDictionary dictionary];
        dicForChoose = [self.arrForDelShoppingCar objectAtIndex:i];
            removeIndex = i;
            chooseIndex = dicForChoose[@"selectIndex"];
        //左边小红点
        self.leftTableViewSelectRow = chooseIndex.section + 1;
        if (self.leftTableViewSelectRow == nil) {
            self.leftTableViewSelectRow = 1;
        }
        NSString *value = [NSString stringWithFormat:@"LEFTTABLEVIEW%ld",(long)chooseIndex.section];
        NSString *cellValue = [NSString stringWithFormat:@"RightTableViewsection%ldrow%ld",chooseIndex.section,chooseIndex.row];
        
        [defaults setObject:nil forKey:cellValue];
        [defaults setObject:nil forKey:value];
        
        for (int i = 0 ; i < 99; i++) {
            NSString *value = [NSString stringWithFormat:@"LEFTTABLEVIEW%d",i];
             [defaults setObject:nil forKey:value];
        }
        
        //[self.arrForAddShoppingCarList removeAllObjects];
        [self.arrForDelShoppingCar removeAllObjects];
        [defaults synchronize];
    }
    for (int i = 0; i < self.arrForAddShoppingCarList.count; i++) {
        NSMutableDictionary *dicForChoose = [NSMutableDictionary dictionary];
        dicForChoose = [self.arrForAddShoppingCarList objectAtIndex:i];
        removeIndex = i;
        chooseIndex = dicForChoose[@"selectIndex"];
        //左边小红点
        self.leftTableViewSelectRow = chooseIndex.section + 1;
        if (self.leftTableViewSelectRow == nil) {
            self.leftTableViewSelectRow = 1;
        }
        NSString *value = [NSString stringWithFormat:@"LEFTTABLEVIEW%ld",(long)chooseIndex.section];
        NSString *cellValue = [NSString stringWithFormat:@"RightTableViewsection%ldrow%ld",chooseIndex.section,chooseIndex.row];
        
        [defaults setObject:nil forKey:cellValue];
        [defaults setObject:nil forKey:value];
        
        for (int i = 0 ; i < 99; i++) {
            NSString *value = [NSString stringWithFormat:@"LEFTTABLEVIEW%d",i];
            [defaults setObject:nil forKey:value];
        }
        
        [self.arrForAddShoppingCarList removeAllObjects];
        [self.arrForDelShoppingCar removeAllObjects];
        [defaults synchronize];
    }
    
    self.AllBoxAddMoney = 0;
    self.newBoxMoney = 0;
    [self.haveBuyListTableview reloadData];
    [self.haveBuyBackView  removeFromSuperview];
    self.buyCarAddLabel.text = @"฿0";
   
    self.addMoney = 0;
    self.ShoppingCarRedNum = 0;
    self.ShoppingCarRedLabel.hidden = YES;
    self.ShoppingCarRedLabel.text = [NSString stringWithFormat:@"%ld",(long)_ShoppingCarRedNum];
    [self.imgShoppingCar setImage:[UIImage imageNamed:@"icon_shangjiaxiangqinggouwu"]];
    [self.leftTable reloadData];
    [self.rightTable reloadData];
   
}
-(void)addShoppongCarNetWord{
    if (self.arrForAddShoppingCarList.count == 0) {
        self.addBuyCarViewAddBtn.backgroundColor = [UIColor colorWithHexString:@"3b3e47"];
 self.addBuyCarViewAddBtn.enabled = NO;
      //  NSString *startPayMoney = [NSString stringWithFormat:@"%@%@%@",ZBLocalized(@"฿", nil),self.upPayMoney,ZBLocalized(@"起送", nil)];
    //[self.addBuyCarViewAddBtn setTitle:ZBLocalized(@"元起送", nil) forState:UIControlStateNormal];
    }else{
        
    [self getNetWorkForAddShoppingCar];
    }
}
-(void)back{
    NSLog(@"1111111111");
}
#pragma mark - 动效

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
