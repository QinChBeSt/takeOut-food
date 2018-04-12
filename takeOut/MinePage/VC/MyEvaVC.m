//
//  MyEvaVC.m
//  takeOut
//
//  Created by mac on 2018/4/11.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "MyEvaVC.h"
#import "CellForMyAve.h"
@interface MyEvaVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)UIView *naviView;
@property (nonatomic , strong)UILabel *aveCountLab;
@property (nonatomic , strong)NSMutableArray *arrForMineAve;
@end

@implementation MyEvaVC
-(NSMutableArray *)arrForMineAve{
    if (_arrForMineAve == nil) {
        _arrForMineAve = [NSMutableArray array];
    }
    return _arrForMineAve;
}
-(void)viewWillAppear:(BOOL)animated{
    //[self.tabBarController.tabBar setHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
   // [self.tabBarController.tabBar setHidden:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"8e8e8e"];
    [self createNaviView];
    [self createTableView];
    [self getNetWork];
    // Do any additional setup after loading the view.
}
#pragma mark - ui
-(void)createNaviView{
    self.view.backgroundColor = [UIColor whiteColor];
    self.naviView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SafeAreaTopHeight )];
    self.naviView.backgroundColor = [UIColor colorWithHexString:BaseYellow];
    [self.view addSubview:self.naviView];
    
    __weak typeof(self) ws = self;
    UIImageView *backImg = [[UIImageView alloc]init];
    backImg.backgroundColor = [UIColor orangeColor];
    [self.naviView addSubview:backImg];
    [backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.naviView.mas_top).offset(SafeAreaStatsBarHeight + 5);
        make.left.equalTo(ws.naviView.mas_left).offset(15);
        make.width.equalTo(@(25));
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
    titleLabel.text = NSLocalizedString(@"我的评价", nil);
    titleLabel.textColor = [UIColor blackColor];
    [self.naviView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.centerY.equalTo(backImg);
    }];
}
-(void)getNetWork{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [defaults objectForKey:UD_USERID];
    NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,getMineEvaUrl];
    NSDictionary *parameters = @{@"uid":userID,
                                 @"page":@"0"
                                 };
    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
    //请求的方式：POST
    [managers POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *code =[NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([code isEqualToString:@"1"]) {
          NSDictionary *dicRes = responseObject[@"value"];
            NSString *avecount = [NSString stringWithFormat:@"%@",dicRes[@"toals"]];
            self.aveCountLab.text = [NSString stringWithFormat:@"%@%@%@",NSLocalizedString(@"已评价", nil),avecount,NSLocalizedString(@"条", nil)];
            NSMutableArray *arr  = dicRes[@"eva"];
            for (NSMutableDictionary *dic in arr) {
                [self.arrForMineAve addObject:dic];
            }
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)createTableView{

    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    headView.backgroundColor = [UIColor colorWithHexString:BaseYellow];
    [self.view addSubview:headView];
   
    UIImageView *icon = [[UIImageView alloc]init];
    icon.backgroundColor = [UIColor orangeColor];
    icon.layer.cornerRadius=25;
    icon.clipsToBounds = YES;
    [headView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headView);
        make.top.equalTo(@(20));
        make.width.and.height.equalTo(@(50));
    }];
    UILabel *userName = [[UILabel alloc]init];
    [headView addSubview:userName];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [defaults objectForKey:UD_USERNAME];
    userName.text = username;
    [userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(icon);
        make.top.equalTo(icon.mas_bottom).offset(15);
    }];
    
    self.aveCountLab = [[UILabel alloc]init];
    [headView addSubview:self.aveCountLab];
    [self.aveCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(icon);
        make.top.equalTo(userName.mas_bottom).offset(10);
    }];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight , SCREEN_WIDTH, SCREENH_HEIGHT - SafeAreaTopHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = headView;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"E8E8E8"];
    self.tableView.tableFooterView=[[UIView alloc]init];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView registerClass:[CellForMyAve class] forCellReuseIdentifier:@"pool1"];
    [self.view addSubview:self.tableView];
    
}
#pragma mark- UITabelViewDataSource/delegat

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrForMineAve.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   CellForMyAve *cell = [tableView dequeueReusableCellWithIdentifier:@"pool1"];
   cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dic = self.arrForMineAve[indexPath.row];
   return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
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
