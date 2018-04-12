//
//  MinePageVC.m
//  takeOut
//
//  Created by mac on 2018/3/23.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "MinePageVC.h"
#import "LoginByPhoneVC.h"
#import "FileTool.h"
#import "MineAddressVC.h"
#import "MyEvaVC.h"
#import "AboutusVC.h"
@interface MinePageVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) UIView *headView;
@property (nonatomic , strong) UIImageView *headIamge;
@property (nonatomic , strong) UILabel *userName;
@property (nonatomic , strong) UILabel *userPhone;
//判断是否登录，Cell行数
@property (nonatomic , assign) NSInteger isLoginOut;
//清理缓存
@property (nonatomic, assign) NSInteger totalSize;
#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
@end

@implementation MinePageVC
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:YES];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [defaults objectForKey:UD_USERNAME];
    NSString *userID = [defaults objectForKey:UD_USERID];
    NSString *userPhine = [defaults objectForKey:UD_USERPHONE];
    if (userID == nil || [userID isEqualToString:@""]) {
        self.userName.text = NSLocalizedString(@"登陆", nil);
        self.userPhone.text = @"";
        _isLoginOut = 1;
    }else{
    self.userName.text = userName;
    self.userPhone.text = userPhine;
        _isLoginOut = 2;
    }
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [FileTool getFileSize:CachePath completion:^(NSInteger totalSize) {
        
        _totalSize = totalSize;
        
        [self.tableView reloadData];
        
    }];
    [self createTableView];
    // Do any additional setup after loading the view.
}
-(void)createHeadView{
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SafeAreaStatsBarHeight + SCREENH_HEIGHT/3)];
    self.headView.backgroundColor = [UIColor colorWithHexString:BaseYellow];
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
    self.userName.font = [UIFont systemFontOfSize:20];
    [self.headView addSubview:self.userName];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.headIamge);
        make.top.equalTo(ws.headIamge.mas_bottom).offset(15);
    }];
    
    self.userPhone = [[UILabel alloc]init];
    self.userPhone.font = [UIFont systemFontOfSize:18];
    [self.headView addSubview:self.userPhone];
    [self.userPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.headIamge);
        make.top.equalTo(ws.userName.mas_bottom).offset(10);
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
       return _isLoginOut;
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
            cell.textLabel.text = NSLocalizedString(@"我的地址", nil);
        }else if (indexPath.row == 1){
            cell.textLabel.text = NSLocalizedString(@"我的评价", nil);
        }else if (indexPath.row == 2){
            cell.textLabel.text = NSLocalizedString(@"关于我们", nil);
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.textLabel.text = NSLocalizedString(@"清除缓存", nil);
        }else if (indexPath.row == 1){
            cell.textLabel.text = NSLocalizedString(@"退出登录", nil);
        }
    }
    return cell;
}

-(void)toLogin{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [defaults objectForKey:UD_USERNAME];
    NSString *userID = [defaults objectForKey:UD_USERID];
    if (userID == nil || [userID isEqualToString:@""]) {
        LoginByPhoneVC *login = [[LoginByPhoneVC alloc]init];
        [self.navigationController pushViewController:login animated:YES];
    }else{
        NSLog(@"========去设置个人信息");
    }
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *userID = [defaults objectForKey:UD_USERID];
            if (userID == nil) {
                LoginByPhoneVC *login = [[LoginByPhoneVC alloc]init];
                [self.navigationController pushViewController:login animated:YES];
            }else{
            MineAddressVC *myaddress = [[MineAddressVC alloc]init];
            myaddress.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:myaddress animated:YES];
            }
        }
        else if (indexPath.row == 1){
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *userID = [defaults objectForKey:UD_USERID];
            if (userID == nil) {
                LoginByPhoneVC *login = [[LoginByPhoneVC alloc]init];
                [self.navigationController pushViewController:login animated:YES];
            }else{
                MyEvaVC *eva = [[MyEvaVC alloc]init];
                eva.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:eva animated:YES];
            }
        }else if (indexPath.row == 2){
            AboutusVC *about = [[AboutusVC alloc]init];
            about.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:about animated:YES];
        }
    }
    else if (indexPath.section == 1) {
    //清除缓存
        if (indexPath.row == 0) {
            if (_totalSize == 0) {
                [MBManager showBriefAlert:@"没有缓存"];
                return;
            }
            [FileTool removeDirectoryPath:CachePath];
            NSInteger totalSize = _totalSize;
            NSString *sizeStr = @"清除缓存";
            // MB KB B
            if (totalSize > 1000 * 1000) {
                // MB
                CGFloat sizeF = totalSize / 1000.0 / 1000.0;
                sizeStr = [NSString stringWithFormat:@"%@%.1fMB",sizeStr,sizeF];
            } else if (totalSize > 1000) {
                // KB
                CGFloat sizeF = totalSize / 1000.0;
                sizeStr = [NSString stringWithFormat:@"%@%.1fKB",sizeStr,sizeF];
            } else if (totalSize > 0) {
                // B
                sizeStr = [NSString stringWithFormat:@"%@%.ldB",sizeStr,totalSize];
            }
            NSString *cleanSize = [NSString stringWithFormat:@"%@成功",sizeStr];
            [MBManager showBriefAlert:cleanSize];
            _totalSize = 0;
            [self.tableView reloadData];
        }
        
        else if (indexPath.row == 1) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:nil forKey:UD_USERID];
            [defaults setObject:nil forKey:UD_USERNAME];
            [defaults setObject:nil forKey:UD_USERPHONE];
            
            [defaults synchronize];
            
            self.userName.text = NSLocalizedString(@"登陆", nil);
            self.userPhone.text = @"";
            _isLoginOut = 1;
            
            [self.tableView reloadData];
        }
    }
    
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
