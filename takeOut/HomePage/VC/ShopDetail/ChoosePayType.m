//
//  ChoosePayType.m
//  takeOut
//
//  Created by mac on 2018/6/29.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "ChoosePayType.h"
#import "CellForPay.h"
@interface ChoosePayType ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UIView *naviView;
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)UIImageView *rightImg ;
@property (nonatomic , strong)NSString *payStr;
@end

@implementation ChoosePayType
-(void)createNaviView{
    self.view.backgroundColor = [UIColor colorWithHexString:BaseBackgroundGray];
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
    
    UIButton *saveBTN = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBTN addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [saveBTN setTitle:ZBLocalized(@"保存", nil) forState:UIControlStateNormal];
    [saveBTN setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.naviView addSubview:saveBTN];
    [saveBTN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.naviView.mas_top).offset(SafeAreaStatsBarHeight);
        make.right.equalTo(ws.naviView.mas_right).offset(-10);
        make.width.equalTo(@(80));
        make.height.equalTo(@(SafeAreaTopHeight - SafeAreaStatsBarHeight));
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = ZBLocalized(@"支付方式", nil);
    titleLabel.textColor = [UIColor blackColor];
    [self.naviView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.centerY.equalTo(backImg);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNaviView];
    [self createTableView];
}
-(void)createTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREENH_HEIGHT - SafeAreaTopHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithHexString:BaseBackgroundGray];
//    self.tableView.separatorStyle = UITableViewCellEditingStyleNone;
    UIView *foot = [[UIView alloc]init];
  
    self.tableView.tableFooterView = foot;
    [self.view addSubview:self.tableView];
}
#pragma mark- UITabelViewDataSource/delegat
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellForPay *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if(cell == nil)
    {
        cell = [[CellForPay alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
        
    }
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.iconImg.image = [UIImage imageNamed:@"icon_xingyongka"];
        cell.backgroundColor = [UIColor colorWithHexString:BaseBackgroundGray];
        cell.nameLab.text = ZBLocalized(@"信用卡", nil);
        
    }
    else if (indexPath.row == 1){
        cell.backgroundColor = [UIColor colorWithHexString:BaseBackgroundGray];
         cell.iconImg.image = [UIImage imageNamed:@"icon_erweima"];
        cell.nameLab.text = ZBLocalized(@"泰银二维码", nil);
    }
    else if (indexPath.row == 2){
        cell.backgroundColor = [UIColor colorWithHexString:BaseBackgroundGray];
         cell.iconImg.image = [UIImage imageNamed:@"icon_weixin"];
        cell.nameLab.text = ZBLocalized(@"微信", nil);
    }
    else if (indexPath.row == 3){
        cell.backgroundColor = [UIColor colorWithHexString:BaseBackgroundGray];
         cell.iconImg.image = [UIImage imageNamed:@"icon_zhifubao"];
        cell.nameLab.text = ZBLocalized(@"支付宝", nil);
    }
    else if (indexPath.row == 4){
        cell.iconImg.image = [UIImage imageNamed:@"icon_daofu"];
        
        cell.backgroundColor = [UIColor whiteColor];
        cell.nameLab.text = ZBLocalized(@"货到付款", nil);
        cell.nameLab.textColor = [UIColor colorWithHexString:BaseYellow];
        
        self.rightImg = [[UIImageView alloc]init];
        self.rightImg.image = [UIImage imageNamed:@"icon_xuankuang"];
        [cell.contentView addSubview: self.rightImg];
        [self.rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.contentView);
            make.right.equalTo(cell.contentView.mas_right).offset(-15);
            make.width.and.height.equalTo(@(20));
        }];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 4) {
        self.rightImg.image = [UIImage imageNamed:@"icon_duigoudown"];
        self.payStr = ZBLocalized(@"货到付款", nil);
    }
}
#pragma mark - 点击事件
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)save{
    if (self.payStr.length == 0) {
        [MBManager showBriefAlert:ZBLocalized(@"请选择支付方式", nil)];
    }else{
    if (self.blockChooseBz) {
        self.blockChooseBz(self.payStr);
    }
    [self back];
    }
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
