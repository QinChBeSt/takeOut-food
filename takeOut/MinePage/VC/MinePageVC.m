//
//  MinePageVC.m
//  takeOut
//
//  Created by mac on 2018/3/23.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "MinePageVC.h"
#import "LoginByPhoneVC.h"
@interface MinePageVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) UIView *headView;
@property (nonatomic , strong) UIImageView *headIamge;
@property (nonatomic , strong) UILabel *userName;
@end

@implementation MinePageVC
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];
    // Do any additional setup after loading the view.
}
-(void)createHeadView{
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SafeAreaStatsBarHeight + SCREENH_HEIGHT/3)];
    self.headView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.headView];
    __weak typeof(self) ws = self;
    self.headIamge = [[UIImageView alloc]init];
    self.headIamge.layer.cornerRadius=35;
    self.headIamge.clipsToBounds = YES;
    self.headIamge.layer.borderWidth = 0.5;
    self.headIamge.layer.borderColor = [[UIColor blackColor] CGColor];
    self.headIamge.backgroundColor = [UIColor orangeColor];
    [self.headView addSubview:self.headIamge];
    [self.headIamge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.headView);
        make.centerY.equalTo(ws.headView);
        make.width.equalTo(@(70));
        make.height.equalTo(@(70));
    }];
    
    self.userName = [[UILabel alloc]init];
    self.userName.text = @"登陆";
    self.userName.font = [UIFont systemFontOfSize:20];
    [self.headView addSubview:self.userName];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.headIamge);
        make.top.equalTo(ws.headIamge.mas_bottom).offset(15);
    }];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn addTarget:self action:@selector(toLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.headIamge);
        make.width.equalTo(ws.headView);
        make.top.equalTo(ws.headIamge.mas_bottom).offset(5);
        make.bottom.equalTo(ws.headView.mas_bottom);
    }];
}
-(void)createTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -SafeAreaStatsBarHeight, SCREEN_WIDTH, SCREENH_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    [self createHeadView];
    self.tableView.tableHeaderView = self.headView;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:self.tableView];
    
}
#pragma mark- UITabelViewDataSource/delegat
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }else{
       return 2;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"我的地址";
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"我的评价";
        }else if (indexPath.row == 2){
            cell.textLabel.text = @"关于我们";
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.textLabel.text = @"清除缓存";
        }else if (indexPath.row == 1){
            cell.textLabel.text = @"退出登陆";
        }
    }
    return cell;
}

-(void)toLogin{
    LoginByPhoneVC *login = [[LoginByPhoneVC alloc]init];
    
    [self.navigationController pushViewController:login animated:YES];
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
