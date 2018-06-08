//
//  AllOrderVC.m
//  takeOut
//
//  Created by mac on 2018/3/29.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "AllOrderVC.h"
#import "CellForOrderList.h"
#import "ModelForOrderList.h"
#import "DetailForOrder.h"
#import "OrderEditVC.h"
#import "CellForOrderListNoPJ.h"
#import "LoginByPhoneVC.h"

@interface AllOrderVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)NSMutableArray *arrForOrerList;
@property (nonatomic , strong)UIButton *toLOginBtn;
@property (nonatomic , strong)UIImageView *kongBaiView;

/**
 *   页数
 */
@property (nonatomic,assign) int pageIndex;
@end

@implementation AllOrderVC
-(NSMutableArray *)arrForOrerList{
    if (_arrForOrerList == nil) {
        _arrForOrerList = [NSMutableArray array];
    }
    return _arrForOrerList;
}
-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:NO];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *userID = [defaults objectForKey:UD_USERID];
    if (userID == nil || [userID isEqualToString:@""]) {
        self.tableView.hidden = YES;
        self.toLOginBtn.hidden = NO;
    }else{
        self.tableView.hidden = NO;
        self.toLOginBtn.hidden = YES;
     [self getNetwork];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    self.kongBaiView.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    __weak typeof (self)ws = self;
    self.toLOginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.toLOginBtn.backgroundColor = [UIColor colorWithHexString:BaseYellow];
    [self.toLOginBtn setTitle:ZBLocalized(@"登录/注册", nil) forState:UIControlStateNormal];
    [self.toLOginBtn addTarget:self action:@selector(toLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.toLOginBtn setTintColor:[UIColor blackColor]];
    [self.view addSubview:_toLOginBtn];
    self.toLOginBtn.hidden = YES;
    [_toLOginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.centerY.equalTo(ws.view.mas_centerY).offset(0);
        make.height.equalTo(@(50));
        make.width.equalTo(@(SCREEN_WIDTH - 90));
    }];
    self.kongBaiView = [[UIImageView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREENH_HEIGHT - SafeAreaTopHeight -TabbarHeight - SafeAreaTabbarHeight)];
    self.kongBaiView.hidden = YES;
    self.kongBaiView.image = [UIImage imageNamed:ZBLocalized(@"bg_dingdankongbaiye", nil)];
    [[UIApplication sharedApplication].keyWindow addSubview:self.kongBaiView];
    
    // Do any additional setup after loading the view.
}
-(void)getNetwork{
    self.pageIndex = 1;
    NSString *page = [NSString stringWithFormat:@"%d",self.pageIndex];
    NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,getOrderListURL];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [defaults objectForKey:UD_USERID];
    NSDictionary *parameters = @{@"userid":userID,
                                 @"flg":@"0",
                                 @"page":page
                                 };
    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
    [self.arrForOrerList removeAllObjects];
    [self.tableView reloadData];
    [managers POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableDictionary *dic = responseObject;
        NSMutableArray *arr = dic[@"value"];
        for (NSMutableDictionary *dic11 in arr) {
            ModelForOrderList *Mod = [[ModelForOrderList alloc]init];
            Mod.ordenum = dic11[@"ordenum"];
            Mod.shopname = dic11[@"shopname"];
            Mod.shopstart = dic11[@"shopstart"];
            Mod.goodsnum = dic11[@"goodsnum"];
            Mod.totalpic = dic11[@"totalpic"];
            Mod.godslist = dic11[@"godslist"];
            Mod.cdata = dic11[@"cdata"];
            [self.arrForOrerList addObject:Mod];
        }
        if (self.arrForOrerList.count == 0) {
            self.kongBaiView.hidden = NO;
            
        }else{
            self.kongBaiView.hidden = YES;
        }
        [self.tableView.mj_footer resetNoMoreData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

-(void)loadMoreBills{
    self.pageIndex ++;
    NSString *page = [NSString stringWithFormat:@"%d",self.pageIndex];
    NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,getOrderListURL];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [defaults objectForKey:UD_USERID];
    NSDictionary *parameters = @{@"userid":userID,
                                 @"flg":@"0",
                                 @"page":page
                                 };
    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
   // [self.arrForOrerList removeAllObjects];
    [managers POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableDictionary *dic = responseObject;
        NSMutableArray *arr = dic[@"value"];
        if (arr.count == 0) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
        for (NSMutableDictionary *dic11 in arr) {
            ModelForOrderList *Mod = [[ModelForOrderList alloc]init];
            Mod.ordenum = dic11[@"ordenum"];
            Mod.shopname = dic11[@"shopname"];
            Mod.shopstart = dic11[@"shopstart"];
            Mod.goodsnum = dic11[@"goodsnum"];
            Mod.totalpic = dic11[@"totalpic"];
            Mod.godslist = dic11[@"godslist"];
            Mod.cdata = dic11[@"cdata"];
            [self.arrForOrerList addObject:Mod];
        }
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - 创建tableView
-(void)createTableView{
  
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0 , self.view.frame.size.width, SCREENH_HEIGHT - SafeAreaTopHeight - 45 - 49 - SafeAreaTabbarHeight) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getNetwork];
    }];
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreBills];
    }];
    self.tableView.mj_footer = footer;
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
        ModelForOrderList *mod = [[ModelForOrderList alloc]init];
        mod = [self.arrForOrerList objectAtIndex:indexPath.row];
        NSArray *arrForGoodsCount = [[NSArray alloc]init];
        arrForGoodsCount = mod.godslist;
        
        NSString *shopStrat = mod.shopstart;
        NSString *shopOrderNo = mod.ordenum;
      //  if ([shopStrat isEqualToString:@"9"]) {
            //        CellForOrderList *cell = [tableView dequeueReusableCellWithIdentifier:@"pool1"];
        NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld-%ld-%@-%lu-%@",indexPath.section,indexPath.row,shopStrat,(unsigned long)arrForGoodsCount.count,shopOrderNo];
            
            CellForOrderList *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (!cell) {
                cell = [[CellForOrderList alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.mod = mod;
            [cell handlerButtonAction:^(NSString *str) {
                OrderEditVC *order = [[OrderEditVC alloc]init];
                order.hidesBottomBarWhenPushed = YES;
                order.orderId = mod.ordenum;
                [self.navigationController pushViewController:order animated:YES];
            }];
            return cell;
//        }else{
//            //        CellForOrderListNoPJ *cell2 = [tableView dequeueReusableCellWithIdentifier:@"pool2"];
//            NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
//
//            CellForOrderListNoPJ *cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//            if (!cell2) {
//                cell2 = [[CellForOrderListNoPJ alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
//            }
//            cell2.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell2.mod = mod;
//
//            return cell2;
//        }
//
    }
   
    return nil;
}
/* 行高 **/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self cellHeightForIndexPath:indexPath cellContentViewWidth:SCREEN_WIDTH tableView:self.tableView];
    
//    ModelForOrderList *mod = [[ModelForOrderList alloc]init];
//    mod = [self.arrForOrerList objectAtIndex:indexPath.row];
//    /* model 为模型实例， keyPath 为 model 的属性名，通过 kvc 统一赋值接口 */
//    return [tableView cellHeightForIndexPath:indexPath model:mod keyPath:@"model" cellClass:[CellForOrderList class] contentViewWidth:self.view.frame.size.width];

    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailForOrder *detailvc = [[DetailForOrder alloc]init];
    detailvc.hidesBottomBarWhenPushed = YES;
    ModelForOrderList *mod = [[ModelForOrderList alloc]init];
    mod = [self.arrForOrerList objectAtIndex:indexPath.row];
    detailvc.orderID = mod.ordenum;
    [self.navigationController pushViewController:detailvc animated:YES];
}
-(void)toLogin{
    LoginByPhoneVC *login = [[LoginByPhoneVC alloc]init];
    self.hidesBottomBarWhenPushed = YES;
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
