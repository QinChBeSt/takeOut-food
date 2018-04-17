//
//  PayOrderChooseAddressVC.m
//  takeOut
//
//  Created by mac on 2018/4/4.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "PayOrderChooseAddressVC.h"
#import "AddNewAddressVC.h"
#import "LoginByPhoneVC.h"

#import "CellForMyAddress.h"

@interface PayOrderChooseAddressVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UIView *naviView;
@property (nonatomic , strong)NSMutableArray *arrForGetAddress;
@property (nonatomic , strong)UITableView *tableView;

@property (nonatomic , strong)UIView *tbFirst;
@property (nonatomic , strong)NSIndexPath *lastIndexPath;
@property (nonatomic , assign)NSInteger indexNum;
@property (nonatomic , strong)ModelForGetAddress *modForChoose;
@end

@implementation PayOrderChooseAddressVC

-(NSMutableArray *)arrForGetAddress{
    if (_arrForGetAddress == nil) {
        _arrForGetAddress = [NSMutableArray array];
    }
    return _arrForGetAddress;
}
-(void)viewWillAppear:(BOOL)animated{
    [self getNetWork];
}
-(void)getNetWork{
    self.view.backgroundColor = [UIColor colorWithHexString:@"E8E8E8"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userid = [defaults objectForKey:UD_USERID];
    if (userid == nil) {
        LoginByPhoneVC *login = [[LoginByPhoneVC alloc]init];
        [self.navigationController pushViewController:login animated:YES];
    }else{
        NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,getAddressUrl];
        NSDictionary *parameters = @{@"uid":userid,
                                     @"page":@"1"
                                     };
        AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
        //请求的方式：POST
        [self.arrForGetAddress removeAllObjects];
        [managers POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSMutableArray *arr = responseObject[@"value"];
            for (NSDictionary *dic in arr) {
                ModelForGetAddress *mod = [[ModelForGetAddress alloc]init];
                mod.id = dic[@"id"];
                mod.userAddrsAddr = dic[@"userAddrsAddr"];
                mod.userAddrsAddrText = dic[@"userAddrsAddrText"];
                mod.userAddrsLat = dic[@"userAddrsLat"];
                mod.userAddrsLong = dic[@"userAddrsLong"];
                mod.userAddrsUname = dic[@"userAddrsUname"];
                mod.userAddrsUphone = dic[@"userAddrsUphone"];
                mod.userAddrsUsex = dic[@"userAddrsUsex"];
                mod.userId = dic[@"userId"];
                [self.arrForGetAddress addObject:mod];
            }
            [self.tableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
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
    
    UIButton *SureBTN = [UIButton buttonWithType:UIButtonTypeCustom];
    [SureBTN setTitle:ZBLocalized(@"确定", nil) forState:UIControlStateNormal];
    [SureBTN addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [SureBTN setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.naviView addSubview:SureBTN];
    [SureBTN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.naviView.mas_top).offset(SafeAreaStatsBarHeight);
        make.right.equalTo(ws.naviView.mas_right).offset(-10);
        make.width.equalTo(@(40));
        make.height.equalTo(@(SafeAreaTopHeight - SafeAreaStatsBarHeight));
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = ZBLocalized(@"选择收货地址", nil);
    titleLabel.textColor = [UIColor blackColor];
    [self.naviView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.centerY.equalTo(backImg);
    }];
}
-(void)setUpUI{
    [self createButtonBtn];
    [self createTableView];
}
-(void)createTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight , SCREEN_WIDTH, SCREENH_HEIGHT - SafeAreaTopHeight -SafeAreaTabbarHeight - 50 ) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"E8E8E8"];
    self.tableView.tableFooterView=[[UIView alloc]init];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView registerClass:[CellForMyAddress class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:self.tableView];
    
}
#pragma mark- UITabelViewDataSource/delegat

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrForGetAddress.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellForMyAddress *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if(cell == nil)
    {
        cell = [[CellForMyAddress alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    ModelForGetAddress *mod = [[ModelForGetAddress alloc]init];
    mod = [self.arrForGetAddress objectAtIndex:indexPath.row];
    cell.Mod = mod;
    cell.backgroundColor = [UIColor colorWithHexString:@"E8E8E8"];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    if (indexPath == self.lastIndexPath) {
        cell.selectImage.backgroundColor = [UIColor colorWithHexString:BaseYellow];
    }else{
        cell.selectImage.backgroundColor = [UIColor blackColor];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.lastIndexPath = indexPath;
    [self.tableView reloadData];
    self.modForChoose = [[ModelForGetAddress alloc]init];
    self.modForChoose = [self.arrForGetAddress objectAtIndex:indexPath.row];
    NSLog(@"地址ID%@",self.modForChoose.id);
    
}
-(void)createButtonBtn{
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENH_HEIGHT - SafeAreaTabbarHeight - 50, SCREEN_WIDTH, 50 + SafeAreaTabbarHeight)];
    bottomView.backgroundColor = [UIColor colorWithHexString:BaseYellow];
    [self.view addSubview:bottomView];
    
    
    UIButton *addNewADD = [UIButton buttonWithType:UIButtonTypeCustom];
    addNewADD.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    [addNewADD setTitle:ZBLocalized(@" + 新增收货地址", nil) forState:UIControlStateNormal];
    [addNewADD setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addNewADD addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
    addNewADD.titleLabel.font = [UIFont systemFontOfSize:14];
    [bottomView addSubview:addNewADD];
    
}
#pragma mark - 点击事件
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)save{
    if (self.blockchooseAddress) {
        self.blockchooseAddress(self.modForChoose);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)addAddress{
    AddNewAddressVC *ADD = [[AddNewAddressVC alloc]init];
    [self.navigationController pushViewController:ADD animated:YES];
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
