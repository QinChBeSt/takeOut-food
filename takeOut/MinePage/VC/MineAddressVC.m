//
//  MineAddressVC.m
//  takeOut
//
//  Created by mac on 2018/4/3.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "MineAddressVC.h"
#import "AddNewAddressVC.h"
#import "NewAddVC.h"
#import "NewLoginByPhoneVC.h"
#import "ModelForGetAddress.h"
#import "CellForMyAddress.h"
@interface MineAddressVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UIView *naviView;
@property (nonatomic , strong)NSMutableArray *arrForGetAddress;
@property (nonatomic , strong)UITableView *tableView;

@property (nonatomic , strong)UIView *tbFirst;
@property (nonatomic , strong)NSIndexPath *index;
@property (nonatomic , assign)NSInteger indexNum;

@property (nonatomic , strong)UIImageView *kongbaiView;
@end

@implementation MineAddressVC
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
        NewLoginByPhoneVC *login = [[NewLoginByPhoneVC alloc]init];
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
            if (self.arrForGetAddress.count == 0) {
                self.kongbaiView.hidden = NO;
            }else{
                self.kongbaiView.hidden = YES;
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
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = ZBLocalized(@"我的地址", nil);
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
    UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, SafeAreaTopHeight, SCREEN_WIDTH - 60, 30)];
    tipLabel.font = [UIFont systemFontOfSize:12];
    tipLabel.text = ZBLocalized(@"温馨提示，点击可以编辑地址，长按可以删除", nil);
    [self.view addSubview:tipLabel];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 30, SCREEN_WIDTH, SCREENH_HEIGHT - SafeAreaTopHeight -SafeAreaTabbarHeight - 50 - 30) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"E8E8E8"];
     self.tableView.tableFooterView=[[UIView alloc]init];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.tableView registerClass:[CellForMyAddress class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:self.tableView];
    self.kongbaiView = [[UIImageView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREENH_HEIGHT - SafeAreaTopHeight - SafeAreaTabbarHeight - 50)];
    self.kongbaiView.hidden = YES;
    self.kongbaiView.image = [UIImage imageNamed:ZBLocalized(@"bg_dizhikongbaiye", nil)];
    [self.view addSubview:self.kongbaiView];
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
    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(lpGR:)];
    //设定最小的长按时间 按不够这个时间不响应手势
    longPressGR.minimumPressDuration = 1;
    [cell addGestureRecognizer:longPressGR];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewAddVC *addnewVC = [[NewAddVC alloc]init];
    ModelForGetAddress *mod = [[ModelForGetAddress alloc]init];
    mod = [self.arrForGetAddress objectAtIndex:indexPath.row];
    addnewVC.userNameStr = mod.userAddrsUname;
    addnewVC.locationStr = mod.userAddrsAddr;
    addnewVC.userSex = mod.userAddrsUsex;
    addnewVC.userPhoneStr = mod.userAddrsUphone;
    addnewVC.userHouseNoStr = mod.userAddrsAddrText;
    addnewVC.naviTitle = ZBLocalized(@"修改收货地址", nil);
    addnewVC.addressId = mod.id;
    addnewVC.userId = mod.userId;
    addnewVC.getLong = mod.userAddrsLong;
    addnewVC.getLat = mod.userAddrsLat;
    [self.navigationController pushViewController:addnewVC animated:YES];
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
-(void)addAddress{
    NewAddVC *ADD = [[NewAddVC alloc]init];
    [self.navigationController pushViewController:ADD animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)deleteAddress{
    if (self.indexNum == nil) {
        self.indexNum = 0;
    }
    ModelForGetAddress *mod = [[ModelForGetAddress alloc]init];
    mod = [self.arrForGetAddress objectAtIndex:self.indexNum];
    NSString *addresId = [NSString stringWithFormat:@"%@",mod.id];
    NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,deleteAddressURL];
    NSDictionary *parameters = @{@"addrid":addresId
                                 };
    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
    //请求的方式：POST
    [managers POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *code =[NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([code isEqualToString:@"1"]) {
            [MBManager showBriefAlert:ZBLocalized(@"地址修改成功", nil)];
            [self.arrForGetAddress removeObjectAtIndex:self.indexNum];
            [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

//实现手势对应的功能

-(void)lpGR:(UILongPressGestureRecognizer *)lpGR

{
    
    if (lpGR.state == UIGestureRecognizerStateBegan) {//手势开始
        
       CGPoint point = [lpGR locationInView:self.tableView];

       self.index = [self.tableView indexPathForRowAtPoint:point]; // 可以获取我们在哪个cell上长按

       self.indexNum = self.index.row;
        
    }
    
    if (lpGR.state == UIGestureRecognizerStateEnded)//手势结束
        
    {
       
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:ZBLocalized(@"是否删除", nil) message:@"" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:ZBLocalized(@"取消", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            NSLog(@"取消执行");
        }];
        
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:ZBLocalized(@"确定删除", nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            NSLog(@"确定执行");
            [self deleteAddress];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:otherAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
        
    }
    
}

@end
