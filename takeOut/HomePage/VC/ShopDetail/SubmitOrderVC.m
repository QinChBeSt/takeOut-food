//
//  SubmitOrderVC.m
//  takeOut
//
//  Created by mac on 2018/4/4.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "SubmitOrderVC.h"
#import "CellForSubmitOrder.h"
#import "ModForHadAddShoppingCar.h"
#import "PayOrderChooseAddressVC.h"
#import "OrderSuccessfullVC.h"
#import "bzDetailVC.h"
#import "ChoosePayType.h"
#define topHieght 100
#define midHeight 120
#define bottomHeight 80
@interface SubmitOrderVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property (nonatomic , strong)UIView *naviView;
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)UILabel *loactinonStrLabel;
@property (nonatomic , strong)NSString *bz;
@property (nonatomic , strong)NSString *uaddrid;
@property (nonatomic , strong) UITextView *textView;
@property (nonatomic , assign)float FallPIC;
@property (nonatomic , assign)float FsavePic;
@property (nonatomic , assign)float FpsPic;
@property (nonatomic , assign)float FpayMoney;
@property (nonatomic , assign)float FBoxMoney;
@property (nonatomic , strong)UIView *SwipeView;
@property (nonatomic , strong)UILabel *bzLabSun;
@property (nonatomic , strong)UIImageView *bzRightIcon;
@property (nonatomic , strong)UILabel *CHOOSEPayLab;
@property (nonatomic , strong)NSString *payStr;

@end

@implementation SubmitOrderVC{
    NSString *remakeStr;
    UIButton *toPay;
    UIImageView *ICONloc;
    UILabel *uAddLab;
    UILabel *uNameLab;
}
-(void)dealloc{
    //第一种方法.这里可以移除该控制器下的所有通知
    // 移除当前所有通知
    NSLog(@"移除了所有的通知");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //第二种方法.这里可以移除该控制器下名称为tongzhi的通知
    //移除名称为tongzhi的那个通知
    NSLog(@"移除了名称为tongzhi的通知");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
     [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.FallPIC = [self.ypic floatValue];
    self.FpsPic = [self.pspic floatValue];
    self.FsavePic = [self.yhpic floatValue];
    self.FBoxMoney = [self.boxPic floatValue];
    self.view.backgroundColor = [UIColor colorWithHexString:@"E8E8E8"];
    [self createNaviView];
    [self setUpUI];
   // [self addNoticeForKeyboard];
}
- (void)addNoticeForKeyboard {
    
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view removeGestureRecognizer:singleTapGR];
                }];
}
- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    [self.view endEditing:YES];
}

///键盘显示事件
- (void) keyboardWillShow:(NSNotification *)notification {
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    CGFloat offset ;
   
    offset =  kbHeight;
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //将视图上移计算好的偏移
    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
    UIWindow*keyWindow = [[UIApplication sharedApplication].windows lastObject];
    
   
    self.SwipeView = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREENH_HEIGHT - SafeAreaTopHeight - offset - 40)];
     [keyWindow addSubview:self.SwipeView];
    UISwipeGestureRecognizer *recognizer;
    
    
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    
    
    
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    
    
    
    [self.SwipeView addGestureRecognizer:recognizer];

  
}
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    // 键盘动画时间
    [self.view endEditing:YES];
    [self.SwipeView removeFromSuperview];
    //视图下沉恢复原状
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [self.SwipeView removeFromSuperview];
    }];
}
///键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
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
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = ZBLocalized(@"提交订单", nil);
    titleLabel.textColor = [UIColor blackColor];
    [self.naviView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.centerY.equalTo(backImg);
    }];
}
#pragma mark - UI
-(void)setUpUI{
//头视图
    UIView *addBanckgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, 90)];
    addBanckgroundView.backgroundColor = [UIColor colorWithHexString:@"F5F5F5"];
    [self.view addSubview:addBanckgroundView];
    
    UIView *addView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 70)];
    addView.backgroundColor = [UIColor whiteColor];
    [addBanckgroundView addSubview:addView];
    UIImageView *addIcon = [[UIImageView alloc]init];
    [addIcon setImage:[UIImage imageNamed:@"右箭头黑"]];
    [addView addSubview:addIcon];
    [addIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(addBanckgroundView);
        make.right.equalTo(addView.mas_right).offset(-15);
        make.width.and.height.equalTo(@(20));
    }];
    ICONloc = [[UIImageView alloc]init];
    ICONloc.image = [UIImage imageNamed:@"icon_dizhi11"];
    [addView addSubview:ICONloc];
    [ICONloc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(addIcon);
        make.left.equalTo(addView.mas_left).offset(20);
        make.height.equalTo(@(20));
        make.width.equalTo(@(16));
    }];
    self.loactinonStrLabel = [[UILabel alloc]init];
    self.loactinonStrLabel.textColor = [UIColor redColor];
    self.loactinonStrLabel.text = ZBLocalized(@"选择收货地址", nil);
    [addView addSubview:self.loactinonStrLabel];
    [self.loactinonStrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(addIcon);
        make.left.equalTo(ICONloc.mas_right).offset(10);
        make.right.equalTo(addIcon.mas_left).offset(-15);
    }];
    
    uAddLab = [[UILabel alloc]init];
    uAddLab.numberOfLines = 2;
    uAddLab.font = [UIFont systemFontOfSize:14];
    uAddLab.textColor = [UIColor colorWithHexString:@"222222"];
    [addView addSubview:uAddLab];
    [uAddLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(addIcon.mas_centerY);
        make.top.equalTo(addView);
        make.left.equalTo(addView.mas_left).offset(20);
        make.right.equalTo(addIcon.mas_left).offset(-15);
    }];
    
    uNameLab = [[UILabel alloc]init];
    uNameLab.numberOfLines = 2;
    uNameLab.font = [UIFont systemFontOfSize:14];
    uNameLab.textColor = [UIColor colorWithHexString:@"959595"];
    [addView addSubview:uNameLab];
    [uNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(uAddLab.mas_bottom);
        make.bottom.equalTo(addView);
        make.left.equalTo(addView.mas_left).offset(20);
        make.right.equalTo(addIcon.mas_left).offset(-15);
    }];
    
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toChooseAddress)];
    
    [addView addGestureRecognizer:tapGesturRecognizer];
//尾视图
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, midHeight + bottomHeight + 80)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
   
    
    UILabel *psMoney = [[UILabel alloc]init];
    psMoney.text = [NSString stringWithFormat:@"%@%.2f",ZBLocalized(@"฿", nil),self.FpsPic];
    psMoney.font = [UIFont systemFontOfSize:14];
    psMoney.textColor = [UIColor colorWithHexString:@"959595"];
    [bottomView addSubview:psMoney];
    [psMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView.mas_right).offset(-20);
        make.top.equalTo(bottomView.mas_top);
        make.height.equalTo(@(40));
    }];
    
    UILabel *psMoneyTitle = [[UILabel alloc]init];
    psMoneyTitle.font = [UIFont systemFontOfSize:14];
    psMoneyTitle.text = ZBLocalized(@"配送费", nil);
    psMoneyTitle.textColor = [UIColor colorWithHexString:@"4b4b4b"];
    [bottomView addSubview:psMoneyTitle];
    [psMoneyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(20);
        make.centerY.equalTo(psMoney);
    }];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(15, 40, SCREEN_WIDTH - 30, 0.5)];
    line1.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    [bottomView addSubview:line1];
    
    UILabel *boxMoney = [[UILabel alloc]init];
    boxMoney.text = [NSString stringWithFormat:@"%@%@",ZBLocalized(@"฿", nil),self.boxPic];
    boxMoney.font = [UIFont systemFontOfSize:14];
    boxMoney.textColor = [UIColor colorWithHexString:@"959595"];
    [bottomView addSubview:boxMoney];
    [boxMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView.mas_right).offset(-20);
        make.top.equalTo(psMoney.mas_bottom);
        make.height.equalTo(@(40));
    }];
    
    UILabel *boxMoneyTitle = [[UILabel alloc]init];
    boxMoneyTitle.font = [UIFont systemFontOfSize:14];
    boxMoneyTitle.text = ZBLocalized(@"餐盒费", nil);
    boxMoneyTitle.textColor = [UIColor colorWithHexString:@"4b4b4b"];
    [bottomView addSubview:boxMoneyTitle];
    [boxMoneyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(20);
        make.centerY.equalTo(boxMoney);
        make.height.equalTo(@(40));
    }];
    
    
    UILabel *ADDMoneyTitle = [[UILabel alloc]init];
    ADDMoneyTitle.text = ZBLocalized(@"原价", nil);
    ADDMoneyTitle.font = [UIFont systemFontOfSize:14];
    ADDMoneyTitle.textColor = [UIColor colorWithHexString:@"4b4b4b"];
    [bottomView addSubview:ADDMoneyTitle];
    [ADDMoneyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(20);
        make.top.equalTo(boxMoney.mas_bottom);
        make.height.equalTo(@(40));
    }];
    
    
    UILabel *ADDMoney = [[UILabel alloc]init];
    ADDMoney.font = [UIFont systemFontOfSize:14];
    ADDMoney.text = [NSString stringWithFormat:@"%@%.2f",ZBLocalized(@"฿", nil),self.FallPIC];
    ADDMoney.textColor = [UIColor colorWithHexString:@"959595"];
    [bottomView addSubview:ADDMoney];
    [ADDMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView.mas_right).offset(-20);
        make.centerY.equalTo(ADDMoneyTitle);
        make.height.equalTo(@(40));
    }];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0,midHeight, SCREEN_WIDTH , 1)];
    line2.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    [bottomView addSubview:line2];
    
    self.FpayMoney = self.FallPIC - self.FsavePic + self.FpsPic + self.FBoxMoney;
    if (self.FpayMoney < 0) {
        self.FpayMoney = 0.01;
    }
//    UILabel *payMoney = [[UILabel alloc]init];
//    payMoney.text = [NSString stringWithFormat:@"%@  %@%.2f",ZBLocalized(@"小计", nil),ZBLocalized(@"￥", nil),self.FpayMoney];
//    payMoney.textColor = [UIColor grayColor];
//    [bottomView addSubview:payMoney];
//    [payMoney mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(bottomView.mas_right).offset(-20);
//        make.top.equalTo(bottomView.mas_top).offset(midHeight + 20);
//    }];
    
    UILabel *tipeTitle = [[UILabel alloc]init];
    tipeTitle.text = ZBLocalized(@"备注", nil);
    tipeTitle.font = [UIFont systemFontOfSize:14];
    tipeTitle.textColor = [UIColor colorWithHexString:@"4b4b4b"];
    [bottomView addSubview:tipeTitle];
    [tipeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(20);
        make.top.equalTo(line2.mas_bottom).offset(0);
        make.height.equalTo(@(40));
    }];
    
    self.bzRightIcon = [[UIImageView alloc]init];
    self.bzRightIcon.image = [UIImage imageNamed:@"右箭头黑"];
    [bottomView addSubview:self.bzRightIcon];
    [self.bzRightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView.mas_right).offset(-15);
        make.width.and.height.equalTo(@(15));
        make.centerY.equalTo(tipeTitle);
    }];
    
    self.bzLabSun = [[UILabel alloc]init];
    self.bzLabSun.textAlignment = NSTextAlignmentRight;
    self.bzLabSun.text = ZBLocalized(@"口味、偏好等要求", nil);
    self.bzLabSun.font = [UIFont systemFontOfSize:14];
    [bottomView addSubview:self.bzLabSun];
    self.bzLabSun.textColor = [UIColor colorWithHexString:@"959595"];
    [self.bzLabSun mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bzRightIcon);
        make.right.equalTo(self.bzRightIcon.mas_left).offset(-5);
        make.left.equalTo(tipeTitle.mas_right).offset(20);
    }];
    UIButton *tobzBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [tobzBtn addTarget:self action:@selector(toBzView) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:tobzBtn];
    [tobzBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bzRightIcon);
        make.right.equalTo(self.bzRightIcon.mas_left).offset(-5);
        make.left.equalTo(tipeTitle.mas_right).offset(20);
        make.height.equalTo(@(40));
    }];
//   self.textView = [[UITextView alloc]init];
//    self.textView.font = [UIFont systemFontOfSize:16];
//    self.textView.delegate = self;
//    self.textView.layer.cornerRadius=10;
//
//    self.textView.clipsToBounds = YES;
//    self.textView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
//    [bottomView addSubview:self.textView];
//    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(bottomView);
//        make.left.equalTo(bottomView.mas_left).offset(20);
//        make.top.equalTo(tipeTitle.mas_bottom).offset(10);
//        make.bottom.equalTo(bottomView.mas_bottom).offset(-70);
//    }];
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0,midHeight + bottomHeight - 40, SCREEN_WIDTH , 1)];
    line3.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    [bottomView addSubview:line3];
    UILabel *yhMoneyTitle = [[UILabel alloc]init];
    yhMoneyTitle.text = ZBLocalized(@"优惠满减", nil);
    yhMoneyTitle.font = [UIFont systemFontOfSize:14];
    yhMoneyTitle.textColor = [UIColor colorWithHexString:@"4b4b4b"];
    [bottomView addSubview:yhMoneyTitle];
    [yhMoneyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(20);
        make.top.equalTo(line3.mas_bottom);
       make.height.equalTo(@(40));
    }];
    
    
    UILabel *yhMoney = [[UILabel alloc]init];
    yhMoney.font = [UIFont systemFontOfSize:14];
    yhMoney.text = [NSString stringWithFormat:@"-%@%.2f",ZBLocalized(@"฿", nil),self.FsavePic];
    yhMoney.textColor = [UIColor redColor];
    [bottomView addSubview:yhMoney];
    [yhMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView.mas_right).offset(-20);
        make.centerY.equalTo(yhMoneyTitle.mas_centerY);
    }];
    
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(0,midHeight + bottomHeight , SCREEN_WIDTH , 1)];
    line4.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    [bottomView addSubview:line4];
    UILabel *payTypeTitle = [[UILabel alloc]init];
    payTypeTitle.text = ZBLocalized(@"支付方式", nil);
    payTypeTitle.font = [UIFont systemFontOfSize:14];
    payTypeTitle.textColor = [UIColor colorWithHexString:@"4b4b4b"];
    [bottomView addSubview:payTypeTitle];
    [payTypeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(20);
        make.top.equalTo(line4.mas_bottom);
        make.bottom.equalTo(bottomView);
    }];
    
    UIImageView *imgPay = [[UIImageView alloc]init];
    imgPay.image = [UIImage imageNamed:@"右箭头黑"];
    [bottomView addSubview:imgPay];
    [imgPay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView.mas_right).offset(-15);
        make.width.and.height.equalTo(@(15));
        make.centerY.equalTo(payTypeTitle);
    }];
    self.CHOOSEPayLab = [[UILabel alloc]init];
    self.CHOOSEPayLab.textAlignment = NSTextAlignmentRight;
    self.CHOOSEPayLab.text = ZBLocalized(@"请选择支付方式", nil);
    self.CHOOSEPayLab.font = [UIFont systemFontOfSize:14];
    [bottomView addSubview:self.CHOOSEPayLab];
    self.CHOOSEPayLab.textColor = [UIColor colorWithHexString:@"959595"];
    [self.CHOOSEPayLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(payTypeTitle);
        make.right.equalTo(self.bzRightIcon.mas_left).offset(-5);
        make.left.equalTo(tipeTitle.mas_right).offset(20);
    }];
    UIButton *topayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [topayBtn addTarget:self action:@selector(toPayView) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:topayBtn];
    [topayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(payTypeTitle);
        make.right.equalTo(self.bzRightIcon.mas_left).offset(-5);
        make.left.equalTo(tipeTitle.mas_right).offset(20);
        make.height.equalTo(@(40));
    }];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight , SCREEN_WIDTH, SCREENH_HEIGHT - SafeAreaTopHeight -SafeAreaTabbarHeight - 40) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"F5F5F5"];
    self.tableView.tableHeaderView = addBanckgroundView;
    self.tableView.tableFooterView = bottomView;
    [self.tableView registerClass:[CellForSubmitOrder class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:self.tableView];
    
    UIView *totalMoneyBackgrounView = [[UIView alloc]initWithFrame:CGRectMake(0,SCREENH_HEIGHT  -SafeAreaTabbarHeight - 50,  SCREEN_WIDTH, 50 + SafeAreaTabbarHeight)];
    totalMoneyBackgrounView.backgroundColor = [UIColor colorWithHexString:@"3b3e47"];
    [self.view addSubview:totalMoneyBackgrounView];
    
    UIView *totalMoneyView = [[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 50 )];
    totalMoneyView.backgroundColor = [UIColor colorWithHexString:@"3b3e47"];
    [totalMoneyBackgrounView addSubview:totalMoneyView];
    
    UILabel *toPayTitle = [[UILabel alloc]init];
    toPayTitle.text = ZBLocalized(@"合计:", nil);
    toPayTitle.textColor = [UIColor whiteColor];
    [totalMoneyView addSubview:toPayTitle];
    [toPayTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(totalMoneyView.mas_left).offset(20);
        make.centerY.equalTo(totalMoneyView.mas_centerY);
    }];
    [toPayTitle setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                           forAxis:UILayoutConstraintAxisHorizontal];
   
  
   
    toPay = [UIButton buttonWithType:UIButtonTypeCustom];
    toPay.frame = CGRectMake(SCREEN_WIDTH* 0.717, 0, SCREEN_WIDTH* 0.283, 50);
    toPay.backgroundColor = [UIColor colorWithHexString:BaseYellow];
    [toPay setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [toPay addTarget:self action:@selector(toPay) forControlEvents:UIControlEventTouchUpInside];
    [toPay setTitle:ZBLocalized(@"提交订单", nil) forState:UIControlStateNormal];
    
    toPay.titleLabel.font = [UIFont systemFontOfSize:14];
    [totalMoneyBackgrounView addSubview:toPay];
   
//    UILabel *toPaySaveMoney = [[UILabel alloc]init];
//    toPaySaveMoney.text = [NSString stringWithFormat:@"%@%@)",ZBLocalized(@"(已减￥", nil),self.yhpic];
//    toPaySaveMoney.font = [UIFont systemFontOfSize:14];
//    toPaySaveMoney.adjustsFontSizeToFitWidth = YES;
//    toPaySaveMoney.textColor = [UIColor grayColor];
//    //[totalMoneyView addSubview:toPaySaveMoney];
//    [toPaySaveMoney mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(totalMoneyView.mas_centerY);
//        make.right.equalTo(toPay.mas_left).offset(-3);
//    }];
//    [toPaySaveMoney setContentCompressionResistancePriority:UILayoutPriorityRequired
//                                                      forAxis:UILayoutConstraintAxisHorizontal];
//
    
    
    UILabel *toPayMoney = [[UILabel alloc]init];
    toPayMoney.text = [NSString stringWithFormat:@"%@%.2f",ZBLocalized(@"฿", nil),self.FpayMoney];
    toPayMoney.textColor = [UIColor whiteColor];
    toPayMoney.font = [UIFont systemFontOfSize:22];
    toPayMoney.textAlignment = NSTextAlignmentLeft;
    toPayMoney.adjustsFontSizeToFitWidth = YES;
    [totalMoneyView addSubview:toPayMoney];
    [toPayMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(toPayTitle.mas_right).offset(2);
        make.centerY.equalTo(totalMoneyView.mas_centerY);
        //make.right.equalTo(toPay.mas_left).offset(-5);
        
    }];
    
    
  
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrForOrder.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellForSubmitOrder *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    if(cell == nil)
    {
        cell = [[CellForSubmitOrder alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
   
    NSDictionary *dic = [self.arrForOrder objectAtIndex:indexPath.row];
    cell.foodsName.text = dic[@"g_name"];
    float g_picF = [dic[@"g_pic"] floatValue];
    cell.foodsMoney.text = [NSString stringWithFormat:@"%@%.2f",ZBLocalized(@"฿", nil),g_picF];
    cell.foodsCount.text = [NSString stringWithFormat:@"× %@",dic[@"count"]];
    NSString *ImgUrl = [NSString stringWithFormat:@"%@/%@",IMGBaesURL,dic[@"g_log"]];
    [cell.shopIcon sd_setImageWithURL:[NSURL URLWithString:ImgUrl] placeholderImage:[UIImage imageNamed:@"logo"]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
-(void)textViewDidChange:(UITextView *)textView{
    self.bz = textView.text;
    if (textView.text.length > 0) {
        // 禁止系统表情的输入
        NSString *text = [self disable_emoji:[textView text]];
        if (![text isEqualToString:textView.text]) {
            NSRange textRange = [textView selectedRange];
            textView.text = text;
            [textView setSelectedRange:textRange];
        }
    }
    
}
- (NSString *)disable_emoji:(NSString *)text{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}


#pragma mark - 点击事件
-(void)back{
   
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)toPay{
    if (self.uaddrid == nil) {
        [MBManager showBriefAlert:ZBLocalized(@"选择收货地址", nil)];
        return;
    }else if(self.payStr.length == 0){
        [MBManager showBriefAlert:ZBLocalized(@"请选择支付方式", nil)];
        return;
    }
    else if(self.bz == nil){
        self.bz = @"";
    }
    NSString *Url = [NSString stringWithFormat:@"%@%@",BASEURL,setOrderToPayURL];
    NSDictionary *parameters = @{@"carid":self.carid,
                                 @"uaddrid":self.uaddrid,
                                 @"bz":self.bz,
                                 };
    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
    
    toPay.enabled = NO;
    [MBManager showLoadingInView:self.view];
    [managers POST:Url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"提交订单：：：：%@",responseObject);
        NSString *code =[NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([code isEqualToString:@"1"]) {
            [MBManager hideAlert];
            toPay.enabled = YES;
            [MBManager showBriefAlert:ZBLocalized(@"提交订单成功", nil)];
            [self performSelector:@selector(toSusse) withObject:nil/*可传任意类型参数*/ afterDelay:2.0];
        }else{
            [MBManager hideAlert];
            toPay.enabled = YES;
            [MBManager showBriefAlert:ZBLocalized(@"提交订单失败", nil) ];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBManager hideAlert];
        toPay.enabled = YES;
        [MBManager showBriefAlert:ZBLocalized(@"提交订单失败", nil) ];
    }];
}
-(void)toChooseAddress{
    PayOrderChooseAddressVC *mineAddvc = [[PayOrderChooseAddressVC alloc]init];
    mineAddvc.shopId = self.shopId;
    mineAddvc.blockchooseAddress = ^(ModelForGetAddress *mod) {
        self.uaddrid = [NSString stringWithFormat:@"%@",mod.id];
        uAddLab.text = [NSString stringWithFormat:@"%@ %@",mod.userAddrsAddr,mod.userAddrsAddrText];
        uNameLab.text = [NSString stringWithFormat:@"%@   %@",mod.userAddrsUname,mod.userAddrsUphone];
        self.loactinonStrLabel.hidden = YES;
        ICONloc.hidden = YES;
    };
    [self.navigationController pushViewController:mineAddvc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)toSusse{
    OrderSuccessfullVC *SUCCESSVC = [[OrderSuccessfullVC alloc]init];

    [self.navigationController pushViewController:SUCCESSVC animated:YES];
    
}
-(void)toBzView{
    bzDetailVC *BZ = [[bzDetailVC alloc]init];
    BZ.blockChooseBz = ^(NSString *bzStr) {
        self.bz =bzStr;
        self.bzLabSun.text = bzStr;
    };
    if (self.bz.length != 0) {
        BZ.bzStr = self.bz;
    }
    [self.navigationController pushViewController:BZ animated:YES];
}

-(void)toPayView{
    ChoosePayType *pay = [[ChoosePayType alloc]init];
    pay.blockChooseBz = ^(NSString *payStr) {
        self.payStr = payStr;
        self.CHOOSEPayLab.text = payStr;
    };
    [self.navigationController pushViewController:pay animated:YES];
    
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
