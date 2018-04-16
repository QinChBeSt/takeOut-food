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
#define topHieght 100
#define midHeight 60
#define bottomHeight 170
@interface SubmitOrderVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property (nonatomic , strong)UIView *naviView;
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)UILabel *loactinonStrLabel;
@property (nonatomic , strong)NSString *bz;
@property (nonatomic , strong)NSString *uaddrid;
@end

@implementation SubmitOrderVC{
    NSString *remakeStr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"E8E8E8"];
    [self createNaviView];
    [self setUpUI];
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
    titleLabel.text = NSLocalizedString(@"提交订单", nil);
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
    addBanckgroundView.backgroundColor = [UIColor colorWithHexString:@"E8E8E8"];
    [self.view addSubview:addBanckgroundView];
    
    UIView *addView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 50)];
    addView.backgroundColor = [UIColor whiteColor];
    [addBanckgroundView addSubview:addView];
    
    UIImageView *addIcon = [[UIImageView alloc]init];
    addIcon.backgroundColor = [UIColor orangeColor];
    [addView addSubview:addIcon];
    [addIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(addBanckgroundView);
        make.left.equalTo(@(20));
        make.width.and.height.equalTo(@(20));
    }];
    self.loactinonStrLabel = [[UILabel alloc]init];
    self.loactinonStrLabel.textColor = [UIColor redColor];
    self.loactinonStrLabel.text = NSLocalizedString(@"选择收货地址", nil);
    [addView addSubview:self.loactinonStrLabel];
    [self.loactinonStrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(addIcon);
        make.left.equalTo(addIcon.mas_right).offset(20);
        make.right.equalTo(addBanckgroundView.mas_right).offset(-15);
    }];
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toChooseAddress)];
    
    [addView addGestureRecognizer:tapGesturRecognizer];
//尾视图
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, midHeight + bottomHeight)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(15, 0.5, SCREEN_WIDTH - 30, 0.5)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [bottomView addSubview:line1];
    
    UILabel *psMoney = [[UILabel alloc]init];
    psMoney.text = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"￥", nil),self.pspic];
    psMoney.textColor = [UIColor grayColor];
    [bottomView addSubview:psMoney];
    [psMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView.mas_right).offset(-20);
        make.centerY.equalTo(bottomView.mas_top).offset(midHeight / 4);
    }];
    
    UILabel *psMoneyTitle = [[UILabel alloc]init];
    psMoneyTitle.text = NSLocalizedString(@"配送费", nil);
    psMoneyTitle.textColor = [UIColor grayColor];
    [bottomView addSubview:psMoneyTitle];
    [psMoneyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(20);
        make.centerY.equalTo(bottomView.mas_top).offset(midHeight / 4);
    }];
    
    UILabel *ADDMoneyTitle = [[UILabel alloc]init];
    ADDMoneyTitle.text = NSLocalizedString(@"原价", nil);
    ADDMoneyTitle.textColor = [UIColor grayColor];
    [bottomView addSubview:ADDMoneyTitle];
    [ADDMoneyTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(20);
        make.centerY.equalTo(bottomView.mas_top).offset(midHeight / 4 * 3);
    }];
    UILabel *ADDMoney = [[UILabel alloc]init];
    ADDMoney.text = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"￥", nil),self.yhpic];
    ADDMoney.textColor = [UIColor grayColor];
    [bottomView addSubview:ADDMoney];
    [ADDMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView.mas_right).offset(-20);
        make.centerY.equalTo(bottomView.mas_top).offset(midHeight / 4 * 3);
    }];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(15,midHeight, SCREEN_WIDTH - 30, 0.5)];
    line2.backgroundColor = [UIColor lightGrayColor];
    [bottomView addSubview:line2];
    
    UILabel *payMoney = [[UILabel alloc]init];
    payMoney.text = [NSString stringWithFormat:@"%@  %@%@",NSLocalizedString(@"小计", nil),NSLocalizedString(@"￥", nil),self.ypic];
    payMoney.textColor = [UIColor grayColor];
    [bottomView addSubview:payMoney];
    [payMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView.mas_right).offset(-20);
        make.top.equalTo(bottomView.mas_top).offset(midHeight + 20);
    }];
    
    UILabel *tipeTitle = [[UILabel alloc]init];
    tipeTitle.text = NSLocalizedString(@"备注", nil);
    tipeTitle.textColor = [UIColor grayColor];
    [bottomView addSubview:tipeTitle];
    [tipeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView.mas_left).offset(30);
        make.top.equalTo(payMoney.mas_bottom).offset(20);
    }];
    UITextView *textView = [[UITextView alloc]init];
    textView.delegate = self;
    textView.backgroundColor = [UIColor colorWithHexString:@"E8E8E8"];
    [bottomView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bottomView);
        make.left.equalTo(bottomView.mas_left).offset(20);
        make.top.equalTo(tipeTitle.mas_bottom).offset(10);
        make.bottom.equalTo(bottomView.mas_bottom).offset(-20);
    }];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight , SCREEN_WIDTH, SCREENH_HEIGHT - SafeAreaTopHeight -SafeAreaTabbarHeight - 40) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"E8E8E8"];
    self.tableView.tableHeaderView = addBanckgroundView;
    self.tableView.tableFooterView = bottomView;
    [self.tableView registerClass:[CellForSubmitOrder class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:self.tableView];
    
    UIView *totalMoneyBackgrounView = [[UIView alloc]initWithFrame:CGRectMake(0,SCREENH_HEIGHT  -SafeAreaTabbarHeight - 40,  SCREEN_WIDTH, 40 + SafeAreaTabbarHeight)];
    totalMoneyBackgrounView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:totalMoneyBackgrounView];
    
    UIView *totalMoneyView = [[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 40 )];
    totalMoneyView.backgroundColor = [UIColor whiteColor];
    [totalMoneyBackgrounView addSubview:totalMoneyView];
    
    UILabel *toPayTitle = [[UILabel alloc]init];
    toPayTitle.text = NSLocalizedString(@"合计:", nil);
    toPayTitle.textColor = [UIColor grayColor];
    [totalMoneyView addSubview:toPayTitle];
    [toPayTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(totalMoneyView.mas_left).offset(30);
        make.centerY.equalTo(totalMoneyView.mas_centerY);
    }];
    
    UILabel *toPayMoney = [[UILabel alloc]init];
    toPayMoney.text = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"￥:", nil),self.ypic];
    toPayMoney.textColor = [UIColor redColor];
    [totalMoneyView addSubview:toPayMoney];
    [toPayMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(toPayTitle.mas_right).offset(5);
        make.centerY.equalTo(totalMoneyView.mas_centerY);
    }];
    
    UILabel *toPaySaveMoney = [[UILabel alloc]init];
    toPaySaveMoney.text = [NSString stringWithFormat:@"%@%@)",NSLocalizedString(@"(已减￥", nil),self.yhpic];
    toPaySaveMoney.font = [UIFont systemFontOfSize:14];
    toPaySaveMoney.textColor = [UIColor grayColor];
    [totalMoneyView addSubview:toPaySaveMoney];
    [toPaySaveMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(toPayMoney.mas_right).offset(5);
        make.centerY.equalTo(totalMoneyView.mas_centerY);
    }];
    
    UIButton *toPay = [UIButton buttonWithType:UIButtonTypeCustom];
    toPay.frame = CGRectMake(SCREEN_WIDTH /3 *2, 0, SCREEN_WIDTH /3, 40);
    toPay.backgroundColor = [UIColor colorWithHexString:BaseYellow];
    [toPay setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [toPay addTarget:self action:@selector(toPay) forControlEvents:UIControlEventTouchUpInside];
    [toPay setTitle:NSLocalizedString(@"提交订单", nil) forState:UIControlStateNormal];
    toPay.titleLabel.font = [UIFont systemFontOfSize:14];
    [totalMoneyBackgrounView addSubview:toPay];
    
  
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
    cell.foodsName.text = dic[@"g_name"];;
    cell.foodsMoney.text = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"￥", nil),dic[@"g_pic"]];
    cell.foodsCount.text = [NSString stringWithFormat:@"× %@",dic[@"count"]];
   
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
-(void)textViewDidChange:(UITextView *)textView{
    self.bz = textView.text;
    
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
        [MBManager showBriefAlert:NSLocalizedString(@"选择收货地址", nil)];
        return;
    }else if(self.bz == nil){
        self.bz = @"";
    }
    NSString *Url = [NSString stringWithFormat:@"%@%@",BASEURL,setOrderToPayURL];
    NSDictionary *parameters = @{@"carid":self.carid,
                                 @"uaddrid":self.uaddrid,
                                 @"bz":self.bz,
                                 };
    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
    [managers POST:Url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"提交订单：：：：%@",responseObject);
        NSString *code =[NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([code isEqualToString:@"1"]) {
            [MBManager showBriefAlert:@"提交订单成功"];
            [self performSelector:@selector(toSusse) withObject:nil/*可传任意类型参数*/ afterDelay:2.0];
        }else{
            [MBManager showBriefAlert:@"提交订单失败"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)toChooseAddress{
    PayOrderChooseAddressVC *mineAddvc = [[PayOrderChooseAddressVC alloc]init];
    mineAddvc.blockchooseAddress = ^(ModelForGetAddress *mod) {
        self.uaddrid = [NSString stringWithFormat:@"%@",mod.id];
        self.loactinonStrLabel.text = [NSString stringWithFormat:@"%@ %@",mod.userAddrsAddr,mod.userAddrsAddrText];
        self.loactinonStrLabel.textColor = [UIColor blackColor];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
