//
//  WillEvaluateVC.m
//  takeOut
//
//  Created by mac on 2018/3/29.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "WillEvaluateVC.h"
#import "CellForOrderList.h"
#import "ModelForOrderList.h"
#import "DetailForOrder.h"
#import "OrderEditVC.h"
@interface WillEvaluateVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)NSMutableArray *arrForOrerList;


@end

@implementation WillEvaluateVC
-(NSMutableArray *)arrForOrerList{
    if (_arrForOrerList == nil) {
        _arrForOrerList = [NSMutableArray array];
    }
    return _arrForOrerList;
}
-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:NO];
    [self getNetwork];
}
- (void)viewDidLoad {
    [super viewDidLoad];
     [self createTableView];
}

-(void)getNetwork{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,getOrderListURL];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [defaults objectForKey:UD_USERID];
    NSDictionary *parameters = @{@"userid":userID,
                                 @"flg":@"0",
                                 @"page":@"1",
                                 };
    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
    [self.arrForOrerList removeAllObjects];
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
            if ([Mod.shopstart isEqualToString:@"9"]) {
                [self.arrForOrerList addObject:Mod];
            }
            
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
#pragma mark - 创建tableView
-(void)createTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0 , self.view.frame.size.width, SCREENH_HEIGHT - SafeAreaTopHeight - 45 - 49 - SafeAreaTabbarHeight) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    /** 注册cell. */
    [self.tableView registerClass:[CellForOrderList class] forCellReuseIdentifier:@"pool1"];
    
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
    ModelForOrderList *mod = [[ModelForOrderList alloc]init];
    mod = [self.arrForOrerList objectAtIndex:indexPath.row];
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
    
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
    
    //}
    //return nil;
}
/* 行高 **/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self cellHeightForIndexPath:indexPath cellContentViewWidth:SCREEN_WIDTH tableView:self.tableView];
    
    ModelForOrderList *mod = [[ModelForOrderList alloc]init];
    mod = [self.arrForOrerList objectAtIndex:indexPath.row];
    /* model 为模型实例， keyPath 为 model 的属性名，通过 kvc 统一赋值接口 */
    return [tableView cellHeightForIndexPath:indexPath model:mod keyPath:@"model" cellClass:[CellForOrderList class] contentViewWidth:self.view.frame.size.width];
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailForOrder *detailvc = [[DetailForOrder alloc]init];
    detailvc.hidesBottomBarWhenPushed = YES;
    ModelForOrderList *mod = [[ModelForOrderList alloc]init];
    mod = [self.arrForOrerList objectAtIndex:indexPath.row];
    detailvc.orderID = mod.ordenum;
    [self.navigationController pushViewController:detailvc animated:YES];
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
