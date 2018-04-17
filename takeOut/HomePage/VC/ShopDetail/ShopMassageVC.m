//
//  ShopMassageVC.m
//  takeOut
//
//  Created by mac on 2018/3/26.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "ShopMassageVC.h"

@interface ShopMassageVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)NSString *openTime;

@property (nonatomic , strong)UIView *headView;
@property (nonatomic , strong)UILabel *addressLab;
@property (nonatomic , strong)UIImageView *shopIcon;
@property (nonatomic , strong)NSString *shopPhoneNo;

@property (nonatomic , strong)UIView *footView;
@property (nonatomic , strong)UIImageView *yhIcon;
@property (nonatomic , strong)NSMutableArray *arrForSAVE;

@end

@implementation ShopMassageVC
-(NSMutableArray *)arrForSAVE{
    if (_arrForSAVE == nil) {
        _arrForSAVE = [NSMutableArray array];
    }
    return _arrForSAVE;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    [self getNet];
    // Do any additional setup after loading the view.
}
-(void)getNet{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,getShopShopDeatailURL];
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    [par setValue:self.shopId forKey:@"shopid"];
    [MHNetWorkTask getWithURL:url withParameter:par withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
        NSMutableDictionary *resDic = result[@"value"];
        self.openTime = [NSString stringWithFormat:@"%@:%@",ZBLocalized(@"营业时间", nil),resDic[@"opentime"]];
        self.addressLab.text = resDic[@"shopad"];
        self.shopPhoneNo = resDic[@"shopphone"];
        [self.tableView reloadData];
    } withFail:^(NSError *error) {
        
    }];
}
-(void)CreateheadView{
    __weak typeof(self) ws = self;
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 130)];
    [self.view addSubview:self.headView];
    UIImageView *addIcon =[[UIImageView alloc]init];
    [addIcon setImage:[UIImage imageNamed:@"ic_point"]];
    [self.headView addSubview:addIcon];
    [addIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.headView.mas_top).offset(25);
        make.left.equalTo(ws.headView.mas_left).offset(15);
        make.width.equalTo(@(10));
        make.height.equalTo(@(15));
    }];
    
    self.addressLab = [[UILabel alloc]init];
    self.addressLab.numberOfLines = 2;
    self.addressLab.font = [UIFont systemFontOfSize:14];
    [self.headView addSubview:self.addressLab];
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addIcon.mas_right).offset(15);
        make.centerY.equalTo(addIcon);
        make.right.equalTo(ws.headView.mas_right).offset(-SCREEN_WIDTH / 5);
    }];
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
    [self.headView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.addressLab.mas_right).offset(15);
        make.centerY.equalTo(ws.addressLab);
        make.width.equalTo(@(1));
        make.top.equalTo(ws.headView.mas_top).offset(10);
    }];
    
    UIButton *telBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.headView addSubview:telBtn];
    [telBtn addTarget:self action:@selector(callAction) forControlEvents:UIControlEventTouchUpInside];
    [telBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(line);
        make.left.equalTo(line.mas_right);
        make.top.equalTo(ws.headView);
        make.right.equalTo(ws.headView);
    }];
    
    UIImageView *phoneIcon = [[UIImageView alloc]init];
    [phoneIcon setImage:[UIImage imageNamed:@"电话"]];
    [self.headView addSubview:phoneIcon];
    [phoneIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(telBtn);
        make.centerY.equalTo(telBtn);
        make.width.and.height.equalTo(@(30));
    }];
    
    self.shopIcon = [[UIImageView alloc]init];
    [self.shopIcon setImage:[UIImage imageNamed:@"logo"]];
    [self.headView addSubview:self.shopIcon];
    [self.shopIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.headView.mas_left).offset(15);
        make.top.equalTo(ws.headView.mas_top).offset(50);
        make.bottom.equalTo(ws.headView.mas_bottom).offset(-15);
        make.width.equalTo(ws.shopIcon.mas_height);
    }];
}
-(void)createFootView{
    __weak typeof(self) ws = self;
    NSInteger coount = self.arrForSAVE.count;
    self.footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, coount *30 + 60)];
    [self.view addSubview:self.footView];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    line.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
    [self.footView addSubview:line];
    UIImageView *saveTitIocn = [[UIImageView alloc]init];
    [saveTitIocn setImage:[UIImage imageNamed:@"活动"]];
    [self.footView addSubview:saveTitIocn];
    [saveTitIocn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.footView.mas_left).offset(10);
        make.centerY.equalTo(ws.footView.mas_top).offset(30);
        make.width.and.height.equalTo(@(20));
    }];
    UILabel *saveTit = [[UILabel alloc]init];
    saveTit.text = ZBLocalized(@"优惠活动", nil);
    [self.footView addSubview:saveTit];
    [saveTit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(saveTitIocn);
        make.left.equalTo(saveTitIocn.mas_right).offset(20);
    }];
    
    if (self.arrForSAVE.count != 0) {
        for (int i = 0 ; i < self.arrForSAVE.count; i++) {
            UIImageView *saveIcon = [[UIImageView alloc]initWithFrame:CGRectMake(30, 60 +  i * 30, 15, 15)];
            NSString *shopSaveStr = [NSString stringWithFormat:@"%@/%@",BASEURL,self.arrForSAVE[i][@"img"]];
            [saveIcon sd_setImageWithURL:[NSURL URLWithString:shopSaveStr]];
            [self.footView addSubview:saveIcon];
            
            
            UILabel *saveLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 60 +  i * 30, 150, 15)];
            saveLabel.font = [UIFont systemFontOfSize:14];
            saveLabel.text = [NSString stringWithFormat:@"%@",self.arrForSAVE[i][@"content"]];
            [self.footView addSubview:saveLabel];
            
        }
    }
}
#pragma mark - 创建tableView
-(void)createTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self CreateheadView];
    [self createFootView];
    self.tableView.tableHeaderView = self.headView;
    self.tableView.tableFooterView = self.footView;
    /** 注册cell. */
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"pool1"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.top.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}
#pragma mark - tableView DataSouce
/**** 行数 ****/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pool1"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView *topLine = [[UIView alloc]init];
    topLine.backgroundColor = [UIColor colorWithHexString:@"E8E8E8"];
    [cell addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(cell);
        make.top.equalTo(cell);
        make.centerX.equalTo(cell);
        make.height.equalTo(@(10));
    }];
    UIImageView *icon = [[UIImageView alloc]init];
    
    [cell addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.mas_left).offset(10);
        make.centerY.equalTo(cell.mas_centerY).offset(5);
        make.width.and.height.equalTo(@(20));
    }];
    
    UILabel *text = [[UILabel alloc]init];
    [cell addSubview:text];
    text.font = [UIFont systemFontOfSize:14];
    [text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).offset(20);
       make.centerY.equalTo(cell.mas_centerY).offset(5);
    }];
    if (indexPath.row == 0) {
        [icon setImage:[UIImage imageNamed:@"店铺"]];
        text.text =ZBLocalized(@"查看食品安全档案", nil) ;
    }else if (indexPath.row == 1){
        [icon setImage:[UIImage imageNamed:@"闹钟"]];
        text.text = self.openTime;
    }
    
    return cell;
    
    
}
/* 行高 **/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
    
}
-(void)setSaveArr:(NSMutableArray *)saveArr{
    self.arrForSAVE = saveArr;
}
-(void)callAction{
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
