//
//  DetailForOrder.m
//  takeOut
//
//  Created by mac on 2018/4/8.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "DetailForOrder.h"
#import "CellForOrderDetail.h"
#define headViewHeight 90

#define moneyViewHeight 90
#define totitViewHeight 50
#define callToShopViewHeight 40
#define addressViewHeight 125
#define orderMassageViewHeight 90

@interface DetailForOrder ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UIView *naviView;
@property (nonatomic , strong)UITableView *tableView;

@property (nonatomic , strong)UIView *headBackView;
@property (nonatomic , strong)UILabel *orderNowType;
@property (nonatomic , strong)UILabel *shopNameLabel;
@property (nonatomic , strong)UIView *bottomView;
@property (nonatomic , strong)UILabel *psPicStr;
@property (nonatomic , strong)UILabel *yhPicStr;
@property (nonatomic , strong)UILabel *totleStr;
@property (nonatomic , strong)NSString *shopPhoneNo;
@property (nonatomic , strong)UILabel *userName;
@property (nonatomic , strong)UILabel *userAddress;

@property (nonatomic , strong)UILabel *orderNumLabel;
@property (nonatomic , strong)UILabel *orderDateLabel;
@property (nonatomic , strong)UILabel *orderPayType;

@property (nonatomic , strong)NSMutableArray *arrForOrerList;
@end

@implementation DetailForOrder
-(NSMutableArray *)arrForOrerList{
    if (_arrForOrerList == nil) {
        _arrForOrerList = [NSMutableArray array];
    }
    return _arrForOrerList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNaviView];
    [self createTabview];
    [self getNetWork];
    // Do any additional setup after loading the view.
}

-(void)getNetWork{
    NSString *Url = [NSString stringWithFormat:@"%@%@",BASEURL,getOrderDetailURL];
    NSDictionary *parameters = @{@"ordernum":self.orderID,
                                 };
    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
    [self.arrForOrerList removeAllObjects];
    [managers POST:Url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary *dicRes = responseObject;
        NSMutableDictionary *dic = dicRes[@"value"];
        NSArray *Arr = dic[@"oge"];

        NSString *orderNowType = [NSString stringWithFormat:@"%@",dic[@"ordertyppe"]];
        if ([orderNowType isEqualToString:@"2"]) {
            self.orderNowType.text = ZBLocalized(@"商家未接单", nil);
        }
        else if ([orderNowType isEqualToString:@"3"]){
            self.orderNowType.text = ZBLocalized(@"商家未接单", nil);
        }
        else if ([orderNowType isEqualToString:@"4"]){
            self.orderNowType.text = ZBLocalized(@"商家已接单", nil);
        }
        else if ([orderNowType isEqualToString:@"5"]){
            self.orderNowType.text = ZBLocalized(@"骑手未接单", nil);
        }
        else if ([orderNowType isEqualToString:@"6"]){
            self.orderNowType.text =ZBLocalized(@"商家已接单", nil);
        }
        else if ([orderNowType isEqualToString:@"7"]){
            self.orderNowType.text = ZBLocalized(@"骑手到店", nil);
        }
        else if ([orderNowType isEqualToString:@"8"]){
            self.orderNowType.text = ZBLocalized(@"骑手拿到东西", nil);
        }
        else if ([orderNowType isEqualToString:@"9"]){
            self.orderNowType.text = ZBLocalized(@"订单完成", nil);
        }
        else if ([orderNowType isEqualToString:@"10"]){
            self.orderNowType.text = ZBLocalized(@"未评价", nil);
        }
        else if ([orderNowType isEqualToString:@"11"]){
            self.orderNowType.text = ZBLocalized(@"已评价", nil);
        } else if ([orderNowType isEqualToString:@"12"]){
            self.orderNowType.text = ZBLocalized(@"商家已取消", nil);
        }
        NSString *shopNameStr =[NSString stringWithFormat:@"  %@",dic[@"shopname"]];
        self.shopNameLabel.text = shopNameStr;
        NSString *psStr = dic[@"orderpspic"];
        CGFloat psF = [psStr floatValue];
        NSString *yhStr = dic[@"yhpic"];
        CGFloat yhF = [yhStr floatValue];
        NSString *toStr = dic[@"totals"];
        CGFloat toF = [toStr floatValue];
        toF = toF - yhF;
        self.psPicStr.text = [NSString stringWithFormat:@"%@%.2f",ZBLocalized(@"￥", nil),psF];
        self.yhPicStr.text = [NSString stringWithFormat:@"%@%.2f",ZBLocalized(@"-￥", nil),yhF];
        self.totleStr.text = [NSString stringWithFormat:@"%@%.2f",ZBLocalized(@"￥", nil),toF];
        self.totleStr.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        self.shopPhoneNo = [NSString stringWithFormat:@"%@",dic[@"shopphone"]];
        self.userName.text = [NSString stringWithFormat:@"%@  %@",dic[@"uname"],dic[@"uphone"]] ;
        self.userAddress.text = dic[@"uaddr"];
        self.orderNumLabel.text = dic[@"ordernunm"];
        self.orderDateLabel.text = dic[@"orderdt"];
        NSString *orderPAY = dic[@"orderpay"];
        if ([orderPAY isEqualToString:@"1"]) {
            self.orderPayType.text = ZBLocalized(@"货到付款", nil);
        }else{
             self.orderPayType.text = ZBLocalized(@"在线支付", nil);
        }
        
        for (NSMutableDictionary *dicArr in Arr) {
            [self.arrForOrerList addObject:dicArr];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark - ui
-(void)createNaviView{
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
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
    titleLabel.text = ZBLocalized(@"订单详情", nil);
    titleLabel.textColor = [UIColor blackColor];
    [self.naviView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.centerY.equalTo(backImg);
    }];
}
-(void)createHeadView{
    self.headBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headViewHeight + 20 )];
    self.headBackView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    [self.view addSubview:self.headBackView];
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, headViewHeight)];
    backview.backgroundColor = [UIColor whiteColor];
    [self.headBackView addSubview:backview];
    
    self.orderNowType = [[UILabel alloc]init];
    self.orderNowType.textColor = [UIColor colorWithHexString:@"4b4b4b"];
    self.orderNowType.font = [UIFont systemFontOfSize:20];
    [backview addSubview:self.orderNowType];
    [self.orderNowType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backview);
        make.centerY.equalTo(backview.mas_centerY).offset(-headViewHeight/4 + 10);
    }];
    
    UILabel *WelcomeLabel = [[UILabel alloc]init];
    WelcomeLabel.font = [UIFont systemFontOfSize:14];
    WelcomeLabel.textColor = [UIColor colorWithHexString:@"4b4b4b"];
    WelcomeLabel.text = ZBLocalized(@"感谢您的支持，欢迎下次光临！", nil);
    [backview addSubview:WelcomeLabel];
    [WelcomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(backview);
        make.centerY.equalTo(backview.mas_centerY).offset(headViewHeight/4 );
    }];
    
//    self.shopNameLabel = [[UILabel alloc]init];
//    self.shopNameLabel.backgroundColor = [UIColor whiteColor];
//    self.shopNameLabel.textColor = [UIColor grayColor];
//    [self.headBackView addSubview:self.shopNameLabel];
//    [self.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(self.headBackView);
//        make.bottom.equalTo(self.headBackView.mas_bottom);
//        make.height.equalTo(@(35));
//        make.centerX.equalTo(self.headBackView);
//    }];
//
    
}
-(void)createBottonView{
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,  moneyViewHeight + totitViewHeight + callToShopViewHeight + addressViewHeight + orderMassageViewHeight + 10)];
    self.bottomView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    [self.view addSubview:self.bottomView];
    __weak typeof(self) ws = self;
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.bottomView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(ws.bottomView);
        make.centerX.and.centerY.equalTo(ws.bottomView);
        make.top.equalTo(ws.bottomView.mas_top).offset(0);
    }];
//金额
    
    UIView *moneyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH , moneyViewHeight)];
    [backView addSubview:moneyView];
    UIView *psLine = [[UIView alloc]init];
    psLine.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    [moneyView addSubview:psLine];
    [psLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moneyView.mas_left).offset(15);
        make.right.equalTo(moneyView);
        make.height.equalTo(@(1));
        make.top.equalTo(moneyView.mas_top);
    }];
    UIView *yhLine = [[UIView alloc]init];
    yhLine.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    [moneyView addSubview:yhLine];
    [yhLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moneyView.mas_left).offset(15);
        make.right.equalTo(moneyView);
        make.height.equalTo(@(1));
        make.top.equalTo(psLine.mas_bottom).offset(45);
    }];
    UILabel *psPictit = [[UILabel alloc]init];
    psPictit.text =[NSString stringWithFormat:@"%@",ZBLocalized(@"配送费", nil)];
    psPictit.font = [UIFont systemFontOfSize:16];
    psPictit.textColor = [UIColor colorWithHexString:@"222222"];
    [moneyView addSubview:psPictit];
    [psPictit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moneyView.mas_left).offset(30);
        make.centerY.equalTo(moneyView.mas_centerY).offset(-moneyViewHeight / 4);
    }];
    
    self.psPicStr = [[UILabel alloc]init];
    
    self.psPicStr.font = [UIFont systemFontOfSize:14];
    self.psPicStr.textColor = [UIColor redColor];
    [moneyView addSubview:self.psPicStr];
    [self.psPicStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(moneyView.mas_right).offset(-30);
        make.centerY.equalTo(moneyView.mas_centerY).offset(-moneyViewHeight / 4);
    }];
    
 
    UILabel *yhPictit = [[UILabel alloc]init];
    yhPictit.text =[NSString stringWithFormat:@"%@",ZBLocalized(@"优惠金额", nil)];
    yhPictit.font = [UIFont systemFontOfSize:16];
    yhPictit.textColor = [UIColor colorWithHexString:@"222222"];
    [moneyView addSubview:yhPictit];
    [yhPictit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moneyView.mas_left).offset(30);
        make.centerY.equalTo(moneyView.mas_centerY).offset(moneyViewHeight / 4);
    }];
    self.yhPicStr = [[UILabel alloc]init];
    self.yhPicStr.font = [UIFont systemFontOfSize:14];
    self.yhPicStr.textColor = [UIColor redColor];
    [moneyView addSubview:self.yhPicStr];
    [self.yhPicStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(moneyView.mas_right).offset(-30);
        make.centerY.equalTo(moneyView.mas_centerY).offset(moneyViewHeight / 4);
    }];
    
    UIView *topLine = [[UIView alloc]init];
    topLine.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    [self.bottomView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.bottomView.mas_left).offset(15);
        make.centerX.and.centerY.equalTo(ws.bottomView);
        make.bottom.equalTo(moneyView.mas_bottom).offset(-0.5);
        make.height.equalTo(@(1));
    }];
    
//小计
    UIView *totleView = [[UIView alloc]initWithFrame:CGRectMake(0, moneyViewHeight, SCREEN_WIDTH, totitViewHeight)];
    totleView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:totleView];
    
    UILabel *totletit = [[UILabel alloc]init];
    totletit.text =[NSString stringWithFormat:@"%@",ZBLocalized(@"小计", nil)];
    totletit.font = [UIFont systemFontOfSize:16];
    totletit.textColor = [UIColor colorWithHexString:@"222222"];
    [totleView addSubview:totletit];
    [totletit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(totleView.mas_left).offset(30);
        make.centerY.equalTo(totleView);
    }];
    
    self.totleStr = [[UILabel alloc]init];
    self.totleStr.font = [UIFont systemFontOfSize:16];
    self.totleStr.textColor = [UIColor redColor];
    [totleView addSubview:self.totleStr];
    [self.totleStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(totleView.mas_right).offset(-30);
        make.centerY.equalTo(totleView);
    }];
    
    UIView *midLine = [[UIView alloc]init];
    midLine.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    [self.bottomView addSubview:midLine];
    [midLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.bottomView.mas_left).offset(15);
        make.centerX.and.centerY.equalTo(ws.bottomView);
        make.bottom.equalTo(totleView.mas_bottom).offset(-0.5);
        make.height.equalTo(@(0.5));
    }];
//电话
    UIView *shopPhoneView = [[UIView alloc]initWithFrame:CGRectMake(0, moneyViewHeight + totitViewHeight, SCREEN_WIDTH,callToShopViewHeight)];
    shopPhoneView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:shopPhoneView];
    UIView *btnView = [[UIView alloc]init];
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(callShop)];
    [btnView addGestureRecognizer:tapGesturRecognizer];
    [shopPhoneView addSubview:btnView];
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(shopPhoneView);
        make.centerX.equalTo(shopPhoneView);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.centerY.equalTo(shopPhoneView);
    }];
    UIImageView *phoneICon = [[UIImageView alloc]init];
    [phoneICon setImage:[UIImage imageNamed:@"icon_xingqingdianhua"]];
    [btnView addSubview:phoneICon];
    [phoneICon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btnView);
        make.right.equalTo(btnView).offset(-40);
        make.width.and.height.equalTo(@(callToShopViewHeight * 0.7));
    }];
    UILabel *callShop = [[UILabel alloc]init];
    callShop.text = ZBLocalized(@"商家电话", nil);
    callShop.font = [UIFont systemFontOfSize:16];
    callShop.textColor = [UIColor colorWithHexString:@"222222"];
    [btnView addSubview:callShop];
    [callShop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(btnView);
        make.left.equalTo(btnView).offset(30);
    }];
    
//地址
    UIView *addressView = [[UIView alloc]initWithFrame:CGRectMake(0, moneyViewHeight + totitViewHeight + callToShopViewHeight, SCREEN_WIDTH,addressViewHeight)];
    addressView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    [backView addSubview:addressView];
    UIView *addressbackview = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH , addressViewHeight - 20)];
    addressbackview.backgroundColor = [UIColor whiteColor];
    [addressView addSubview:addressbackview];
    
    UILabel *psAddressTitle = [[UILabel alloc]init];
    [addressbackview addSubview:psAddressTitle];
    psAddressTitle.text = ZBLocalized(@"配送地址", nil);
    psAddressTitle.font = [UIFont systemFontOfSize:14];
    psAddressTitle.textColor = [UIColor colorWithHexString:@"959595"];
    [psAddressTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addressbackview.mas_left).offset(30);
       make.top.equalTo(addressbackview.mas_top).offset(10);
        make.height.equalTo(@(20));
    }];
    
   self.userName = [[UILabel alloc]init];
    [addressbackview addSubview: self.userName];
     self.userName.font = [UIFont systemFontOfSize:14];
     self.userName.textColor = [UIColor colorWithHexString:@"222222"];
    [ self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(psAddressTitle.mas_right).offset(20);
       make.top.equalTo(psAddressTitle.mas_top);
    }];
    
    self.userAddress = [[UILabel alloc]init];
    self.userAddress.numberOfLines = 3;
    [addressbackview addSubview: self.userAddress];
    self.userAddress.font = [UIFont systemFontOfSize:14];
    self.userAddress.textColor = [UIColor colorWithHexString:@"222222"];
    [ self.userAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(psAddressTitle.mas_right).offset(20);
        make.right.equalTo(addressbackview.mas_right).offset(-10);
        make.top.equalTo(ws.userName.mas_bottom);
    }];
    
    UILabel *pscomp = [[UILabel alloc]init];
    [addressbackview addSubview:pscomp];
    pscomp.text = ZBLocalized(@"配送服务", nil);
    pscomp.font = [UIFont systemFontOfSize:14];
    pscomp.textColor = [UIColor colorWithHexString:@"959595"];
    [pscomp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addressbackview.mas_left).offset(30);
        make.bottom.equalTo(addressbackview.mas_bottom).offset(-10);
        make.height.equalTo(@(30));
    }];
    
    UILabel *compName = [[UILabel alloc]init];
    [addressbackview addSubview:compName];
    compName.text = @"Beeorder";
    compName.font = [UIFont systemFontOfSize:14];
    compName.textColor = [UIColor colorWithHexString:BaseYellow];
    [compName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(psAddressTitle.mas_right).offset(20);
        make.centerY.equalTo(pscomp);
    }];
    UILabel *compStr = [[UILabel alloc]init];
    [addressbackview addSubview:compStr];
    compStr.text =[NSString stringWithFormat:@"%@",ZBLocalized(@"提供商品高品质配送服务", nil)];
    compStr.font = [UIFont systemFontOfSize:14];
    compStr.textColor = [UIColor colorWithHexString:@"222222"];
    [compStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(compName.mas_right);
        make.centerY.equalTo(compName);
        make.right.equalTo(ws.view.mas_right).offset(-5);
    }];
    
    UIView *orderMassageView = [[UIView alloc]initWithFrame:CGRectMake(0, moneyViewHeight + totitViewHeight + callToShopViewHeight + addressViewHeight, SCREEN_WIDTH,orderMassageViewHeight)];
    orderMassageView.backgroundColor = [UIColor whiteColor];
    [backView addSubview:orderMassageView];
    
    UILabel *orderNumTitle = [[UILabel alloc]init];
    [orderMassageView addSubview:orderNumTitle];
    orderNumTitle.text = ZBLocalized(@"订单号码", nil);
    orderNumTitle.numberOfLines = 2;
    orderNumTitle.font = [UIFont systemFontOfSize:14];
    orderNumTitle.textColor = [UIColor colorWithHexString:@"959595"];
    [orderNumTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addressbackview.mas_left).offset(30);
        make.centerY.equalTo(orderMassageView.mas_top).offset(orderMassageViewHeight / 6);
        make.right.equalTo(psAddressTitle.mas_right).offset(20);
    }];
    
    
    self.orderNumLabel = [[UILabel alloc]init];
    [orderMassageView addSubview: self.orderNumLabel];
    self.orderNumLabel.font = [UIFont systemFontOfSize:14];
    self.orderNumLabel.textColor = [UIColor blackColor];
    [ self.orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(psAddressTitle.mas_right).offset(20);
        make.centerY.equalTo(orderMassageView.mas_top).offset(orderMassageViewHeight / 6);
    }];
    
    UILabel *orderdateTitle = [[UILabel alloc]init];
    [orderMassageView addSubview:orderdateTitle];
    orderdateTitle.text = ZBLocalized(@"订单日期", nil);
    orderdateTitle.numberOfLines = 2;
    orderdateTitle.font = [UIFont systemFontOfSize:14];
    orderdateTitle.textColor = [UIColor colorWithHexString:@"959595"];
    [orderdateTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addressbackview.mas_left).offset(30);
        make.centerY.equalTo(orderMassageView.mas_top).offset(orderMassageViewHeight / 6 * 3);
        make.right.equalTo(psAddressTitle.mas_right).offset(20);
    }];
    
    
    self.orderDateLabel = [[UILabel alloc]init];
    [orderMassageView addSubview: self.orderDateLabel];
    self.orderDateLabel.font = [UIFont systemFontOfSize:14];
    self.orderDateLabel.textColor = [UIColor blackColor];
    [ self.orderDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(psAddressTitle.mas_right).offset(20);
        make.centerY.equalTo(orderMassageView.mas_top).offset(orderMassageViewHeight / 6 * 3);
    }];
    
    UILabel *orderPayTypeTitle = [[UILabel alloc]init];
    [orderMassageView addSubview:orderPayTypeTitle];
    orderPayTypeTitle.text = ZBLocalized(@"支付方式", nil);
    orderPayTypeTitle.font = [UIFont systemFontOfSize:14];
    orderPayTypeTitle.textColor = [UIColor colorWithHexString:@"959595"];
    [orderPayTypeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addressbackview.mas_left).offset(30);
        make.centerY.equalTo(orderMassageView.mas_top).offset(orderMassageViewHeight / 6 * 5);
    }];
    
    
    self.orderPayType = [[UILabel alloc]init];
    [orderMassageView addSubview: self.orderPayType];
    self.orderPayType.font = [UIFont systemFontOfSize:14];
    self.orderPayType.textColor = [UIColor blackColor];
    [ self.orderPayType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(psAddressTitle.mas_right).offset(20);
        make.centerY.equalTo(orderMassageView.mas_top).offset(orderMassageViewHeight / 6 * 5);
    }];
    
    
    
}
-(void)createTabview{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREENH_HEIGHT - SafeAreaTopHeight )];
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"E8E8E8"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self createHeadView];
    [self createBottonView];
    self.tableView.tableHeaderView = self.headBackView;
    self.tableView.tableFooterView = self.bottomView;
     [self.tableView registerClass:[CellForOrderDetail class] forCellReuseIdentifier:@"pool1"];
    [self.view addSubview:self.tableView];
}
#pragma mark - tableView DataSouce
/**** 行数 ****/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrForOrerList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.arrForOrerList.count > 0) {
        CellForOrderDetail *cell = [tableView dequeueReusableCellWithIdentifier:@"pool1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dic = [self.arrForOrerList objectAtIndex:indexPath.row];
        return cell;
    }
    return nil;
    
}
/* 行高 **/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 105;
    
    
}

#pragma mark - 点击事件
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)callShop{
    NSLog(@"打电话：%@",self.shopPhoneNo);
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",self.shopPhoneNo];
    UIWebView * webview = [[UIWebView alloc] init];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:webview];
  
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
