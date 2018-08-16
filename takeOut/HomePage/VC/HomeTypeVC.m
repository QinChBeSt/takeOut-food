//
//  HomeTypeVC.m
//  takeOut
//
//  Created by mac on 2018/3/29.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "HomeTypeVC.h"
#import "SortButton.h"
#import "TableViewCellForHomepageList.h"
#import "ShopDetailVC.h"
#import "CellForHomeType.h"

@interface HomeTypeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)UIView *naviView;
@property (nonatomic , strong)UIButton *replaceButton;

@property (nonatomic , strong)NSMutableArray *arrForHomePageShopList;
@end

@implementation HomeTypeVC{
    SortButton *clickButton;
     UIView *sortingView;
     NSMutableDictionary *dicForShow;//创建一个字典进行判断收缩还是展开
}
-(NSMutableArray *)arrForHomePageShopList{
    if (_arrForHomePageShopList == nil) {
        _arrForHomePageShopList = [NSMutableArray array];
    }
    return _arrForHomePageShopList;
}

-(void)viewWillAppear:(BOOL)animated{
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    dicForShow = [NSMutableDictionary dictionary];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
    view.backgroundColor = [UIColor whiteColor];
   
    if (self.TypeFlgStr.length == 0) {
         [self netWorkForShopList:0];
    }else{
        [self netWorkForShopList:0];
        //[self netWorkForShopFlgList:self.TypeFlgStr];
    }
    [self.view addSubview:view];
    [self createNaviView];
    [self setUpUI];
}
#pragma mark - 网络请求
//-(void)netWorkForShopFlgList:(NSString *)Flg{
//    NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,homeshopRecommendList];
//    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
//    if (!strlongitude) {
//        strlongitude = @"0";
//    }
//    if (!strlatitude) {
//        strlatitude = @"0";
//    }
//    [par setValue:strlongitude forKey:@"lonng"];
//    [par setValue:strlatitude forKey:@"lat"];
//    NSString * strPage =@"1";
//    int strPageid =[strPage intValue];
//    NSNumber *numPage =[NSNumber numberWithInt:strPageid];
//    [par setValue:@"1" forKey:@"flg"];
//    [par setValue:Flg forKey:@"typeflg"];
//    [par setValue:numPage forKey:@"page"];
//     [MHNetWorkTask getWithURL:url withParameter:par withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
//
//
//     } withFail:^(NSError *error) {
//
//     }];
//}
-(void)netWorkForShopList:(NSInteger )tag{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,homeGetShopList];
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    if (!_strlongitude) {
        _strlongitude = @"0";
    }
    if (!_strlatitude) {
        _strlatitude = @"0";
    }
    
    NSString * strPage =@"1";
    int strPageid =[strPage intValue];
    NSNumber *numPage =[NSNumber numberWithInt:strPageid];
    
    NSInteger flg =tag + 1;
    NSNumber *numFlg =[NSNumber numberWithInteger:flg];
   
    [par setValue:numFlg forKey:@"flg"];
    [par setValue:_strlongitude forKey:@"lonng"];
    [par setValue:_strlatitude forKey:@"lat"];
    [par setValue:_shopTypeId forKey:@"id"];
    [par setValue:numPage forKey:@"page"];
    
    [self.arrForHomePageShopList removeAllObjects];
    [MHNetWorkTask getWithURL:url withParameter:par withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
        NSArray *arr = result[@"value"];
        for (NSDictionary *dic in arr) {
            ModelForShopList *mod = [[ModelForShopList alloc]init];
            mod.act_list = dic[@"act_list"];
            mod.per_mean = [NSString stringWithFormat:@"%@",dic[@"per_mean"]];
            mod.send_dis = dic[@"send_dis"];
            mod.send_time = dic[@"send_time"];
            mod.send_pic = dic[@"send_pic"];
            mod.store_id = dic[@"store_id"];
            NSString *storeImgStr =[NSString stringWithFormat:@"%@%@",IMGBaesURL,dic[@"store_img"]];
            storeImgStr =  [storeImgStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            mod.store_img =storeImgStr;
            //@"http://pcobwjw66.sabkt.gdipper.com/9/12/1534167448239timg%20(7).jpg";
            mod.notice  = dic[@"shop_notice"];
            mod.store_name = dic[@"store_name"];
            mod.up_pic = dic[@"up_pic"];
            mod.opentime = dic[@"opentime"];
            mod.acTypeStr =[NSString stringWithFormat:@"%@",dic[@"shop_ac_type"]] ;
            [self.arrForHomePageShopList addObject:mod];
        }
        [self.tableView reloadData];
        
    } withFail:^(NSError *error) {
        
    }];
    
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
    titleLabel.text = self.typeName;
    titleLabel.textColor = [UIColor blackColor];
    [self.naviView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.centerY.equalTo(backImg);
    }];
}
-(void)setUpUI{
    [self createTableView];
}
-(void)createHeadView{
    sortingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - kWidthScale(18), 30)];
    [sortingView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:sortingView];
    
    NSArray *arrButtonTitle = @[ZBLocalized(@"综合排序", nil),ZBLocalized(@"销量最高", nil),ZBLocalized(@"距离最近", nil)];
    CGFloat buttonW = (SCREEN_WIDTH - kWidthScale(18)) / arrButtonTitle.count; //按钮的宽度和高度
    CGFloat buttonH = 30;
    for (int i=0; i<arrButtonTitle.count; i++) {  // 循环创建3个按钮
        clickButton=[[SortButton alloc]initWithFrame:CGRectMake(buttonW*i, 0, buttonW, buttonH)];
        if(i==0){
            clickButton.selected=YES;  // 设置第一个为默认值
            self.replaceButton=clickButton;
        }
        
        clickButton.tag=i;
        clickButton.titleLabel.font=[UIFont systemFontOfSize:12.0];
        [clickButton setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
        [clickButton setTitleColor:[UIColor blackColor]forState:UIControlStateSelected];
        [clickButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [clickButton setImage:[UIImage imageNamed:@"ic_pulldown"] forState:UIControlStateSelected];
        [clickButton setTitle:arrButtonTitle[i] forState:UIControlStateNormal];
        [clickButton addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [sortingView addSubview:clickButton];
        
        
    }
}

#pragma mark - 创建tableView
-(void)createTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight , self.view.frame.size.width, self.view.frame.size.height - SafeAreaTopHeight - SafeAreaTabbarHeight - 49) style:UITableViewStylePlain];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self createHeadView];
    self.tableView.tableHeaderView = sortingView;
    
    /** 注册cell. */
    //[self.tableView registerClass:[CellForHomeType class] forCellReuseIdentifier:@"pool2"];
    [self.view addSubview:self.tableView];
}

#pragma mark - tableView DataSouce
/**** 行数 ****/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrForHomePageShopList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
    
    TableViewCellForHomepageList *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[TableViewCellForHomepageList alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
   // cell.isShowLong =dicForShow[indexPath];
    cell.mod = [self.arrForHomePageShopList objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.blockChooseShow = ^(NSString *isShow) {
        dicForShow[indexPath] = [NSNumber numberWithBool:![dicForShow[indexPath] boolValue]];
        [self.tableView reloadData];
        
    };
    
    return cell;
    
    
    
}
/* 行高 **/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self cellHeightForIndexPath:indexPath cellContentViewWidth:SCREEN_WIDTH tableView:self.tableView];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    ShopDetailVC *shopDetailVC = [[ShopDetailVC alloc]init];
    shopDetailVC.modShopList = [self.arrForHomePageShopList objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:shopDetailVC animated:YES];
    
}


#pragma mark - 点击事件
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
//点击了对应的筛选条件按钮操作
-(void)clickAction:(UIButton *)sender{
    NSLog(@"%ld",(long)sender.tag);
    self.replaceButton.selected=NO;  // 改变箭头的方向
    sender.selected=YES;
    self.replaceButton=sender;
    
    [self loadData:sender.tag]; // 重新加载数据,刷新表
    
}
//加载模型数据数组
-(void)loadData:(NSInteger)tagNum{
    [self netWorkForShopList:tagNum];
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
