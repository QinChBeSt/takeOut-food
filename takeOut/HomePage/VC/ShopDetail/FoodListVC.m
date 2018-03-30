//
//  FoodListVC.m
//  takeOut
//
//  Created by mac on 2018/3/26.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "FoodListVC.h"
#import "ModelForFoodList.h"
#import "CellForShopFood.h"
#import "CellForChooseSize.h"
#import "CellForShopFoodChooseSize.h"

#define shoppingCarViewHeight 50

@interface FoodListVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UITableView *leftTable;
@property (nonatomic,strong) UITableView *rightTable;
@property (nonatomic,assign) BOOL isSelected;

@property (nonatomic , strong)NSMutableArray *arrForType;
@property (nonatomic , strong)NSMutableArray *arrForDetal;

//选择大小份View
@property (nonatomic , strong)UIView *chooseSizeBackgroundView;
@property (nonatomic , strong)UIView *chooseSizeView;
@property (nonatomic , strong)UILabel *chooesTitle;
@property (nonatomic , strong)UILabel *choosePrice;
@property (nonatomic , strong)UICollectionView *collectionView;
@property (nonatomic , strong)NSMutableArray *arrForChooseSize;

//购物车
@property (nonatomic ,strong)UIView *buyCarView;
@property (nonatomic ,strong)UILabel *buyCarAddLabel;
@property (nonatomic , strong)NSMutableArray *arrForAddShoppingCarList;
@property (nonatomic , copy)NSString *isDeleArr;

@property (nonatomic , copy)NSString *selectbuyCarMoncy;
@property (nonatomic , copy)NSString *selcetbuyCarId;
@property (nonatomic , assign)CGFloat addMoney;

//----小红点
//左边购物车小圆点选择行数
@property (nonatomic ,assign)NSInteger leftTableViewSelectRow;
//下面购物车小红点
@property (nonatomic , strong)UILabel *ShoppingCarRedLabel;
//下面购物车小红点数字
@property (nonatomic , assign)NSInteger ShoppingCarRedNum;

@end

@implementation FoodListVC{
    NSUserDefaults *defaults;
}
-(NSMutableArray *)arrForType{
    if (_arrForType == nil ) {
        _arrForType = [NSMutableArray array];
    }
    return _arrForType;
}
-(NSMutableArray *)arrForDetal{
    if (_arrForDetal == nil) {
        _arrForDetal = [NSMutableArray array];
    }
    return _arrForDetal;
}
-(NSMutableArray *)arrForChooseSize{
    if (_arrForChooseSize == nil) {
        _arrForChooseSize = [NSMutableArray array];
    }
    return _arrForChooseSize;
}
-(NSMutableArray *)arrForAddShoppingCarList{
    if (_arrForAddShoppingCarList == nil) {
        _arrForAddShoppingCarList = [NSMutableArray array];
    }
    return _arrForAddShoppingCarList;
}
#pragma makr - NetWork
-(void)getNetWork{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,shopDatailUrl];
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    int strid =[_shopId intValue];
    NSNumber *numShopId =[NSNumber numberWithInt:strid];
    [par setValue:numShopId forKey:@"shopid"];
    [MHNetWorkTask getWithURL:url withParameter:par withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
        self.arrForType = result[@"value"];
        for (int i = 0; i < self.arrForType.count; i++) {
            NSString *value = [NSString stringWithFormat:@"LEFTTABLEVIEW%d",i];
            [defaults setObject:nil forKey:value];
            
        }
        for (NSDictionary *dic in self.arrForType) {
            NSArray *arr = dic[@"goodsLists"];
            for (NSDictionary *dic1 in arr) {
                ModelForFoodList *mod = [[ModelForFoodList alloc]init];
                mod.id = [dic1[@"id"] intValue];
                mod.godsname = dic1[@"godsname"];
                mod.godslog = dic1[@"godslog"];
                mod.ys = dic1[@"ys"];
                mod.pic = [dic1[@"pic"] floatValue];
                mod.goodspic = dic1[@"goodspic"];
                [self.arrForDetal addObject:mod];
                
            }
        }
        [self.leftTable reloadData];
        [self.rightTable reloadData];
    } withFail:^(NSError *error) {
        
    }];
}
-(void)getNetWorkForAddShoppingCar{
    NSString *Url1 = [NSString stringWithFormat:@"%@%@",BASEURL,AddShoppingCarUlr];
    
    NSString *userID = [defaults objectForKey:UD_USERID];
  
    NSURL* url = [NSURL URLWithString:Url1];
    // 请求
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    // 超时
    request.timeoutInterval = 5;
    // 请求方式
    request.HTTPMethod = @"POST";
    
    // 设置请求体和参数
    // 创建一个描述订单的JSON数据
    NSDictionary* orderInfo = @{@"s_id":self.shopId,
                                @"u_id":userID,
                                @"goods":self.arrForAddShoppingCarList};
    // OC对象转JSON
    NSData* json = [NSJSONSerialization dataWithJSONObject:orderInfo options:NSJSONWritingPrettyPrinted error:nil];
    // 设置请求头
    request.HTTPBody = json;
    // 设置请求头类型 (因为发送给服务器的参数类型已经不是普通数据,而是JSON)
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSURLSession* session = [NSURLSession sharedSession];
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // 错误判断
        if (data==nil||error)return;
        // 解析JSON
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSString* resultErro = dic[@"error"];
        if (resultErro)
        {
            NSLog(@"错误信息:%@",resultErro);
        }else
        {
            NSLog(@"结果信息:%@",dic);
        }
    }];
    
    [task resume];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    defaults = [NSUserDefaults standardUserDefaults];
    self.ShoppingCarRedNum = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTableView];
    [self addChooseView];
    [self createShopingCarView];
    [self getNetWork];
}
#pragma mark - UI
static NSString *const resueIdleft = @"leftCell";
static NSString *const resueIdright = @"rightCell";
static NSString *const resueIdrightChooseSize = @"rightCellChooseSize";
- (void)initTableView {
    
    self.leftTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width / 4, self.view.frame.size.height - SafeAreaTopHeight - 100 -36 - SafeAreaTabbarHeight - shoppingCarViewHeight) style:UITableViewStylePlain];
    self.leftTable.delegate = self;
    self.leftTable.dataSource = self;

    self.leftTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.leftTable];
    [self.leftTable registerClass:[UITableViewCell class] forCellReuseIdentifier:resueIdleft];
    [self.leftTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    self.rightTable = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 4, 0, self.view.frame.size.width / 4 * 3, self.view.frame.size.height - SafeAreaTopHeight - 100 -36 - SafeAreaTabbarHeight - shoppingCarViewHeight) style:UITableViewStylePlain];
    self.rightTable.dataSource = self;
    self.rightTable.delegate = self;
    self.rightTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.rightTable];
   // [self.rightTable registerClass:[CellForShopFood class] forCellReuseIdentifier:resueIdright];
    [self.rightTable registerClass:[CellForShopFoodChooseSize class] forCellReuseIdentifier:resueIdrightChooseSize];
}
-(void)addChooseView{
    self.chooseSizeBackgroundView = [[UIView alloc]initWithFrame:self.view.frame];
    self.chooseSizeBackgroundView.backgroundColor = [UIColor colorWithHexString:@"8E9294" alpha:0.4];
    UITapGestureRecognizer *tapChooseView=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removewChooseView)];
    [self.chooseSizeBackgroundView addGestureRecognizer:tapChooseView];
    [self.view addSubview:self.chooseSizeBackgroundView];
    __weak typeof(self) ws = self;
    self.chooseSizeView = [[UIView alloc]init];
    self.chooseSizeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.chooseSizeView];
    [self.chooseSizeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view.mas_top).offset(30);
        make.left.equalTo(ws.view.mas_left).offset(30);
        make.centerX.equalTo(ws.view.mas_centerX);
        make.height.equalTo(@(170));
    }];
    [self.chooseSizeBackgroundView setHidden:YES];
    [self.chooseSizeView setHidden:YES];
   
    self.chooesTitle = [[UILabel alloc]init];
    [self.chooseSizeView addSubview:self.chooesTitle];
    [self.chooesTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.chooseSizeView.mas_top).offset(10);
        make.centerX.equalTo(ws.chooseSizeView);
    }];
    
    UIButton *exti = [UIButton buttonWithType:UIButtonTypeCustom];
    exti.backgroundColor = [UIColor orangeColor];
    [exti addTarget:self action:@selector(removewChooseView) forControlEvents:UIControlEventTouchUpInside];
    [self.chooseSizeView addSubview:exti];
    [exti mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.chooseSizeView.mas_right).offset(-10);
        make.top.equalTo(ws.chooseSizeView.mas_top).offset(10);
        make.width.equalTo(@(30));
        make.height.equalTo(@(30));
    }];
    
    CGFloat itemWidth = (SCREEN_WIDTH - 120 )/ 3;
    CGFloat itemHeight = 30;
    UICollectionViewFlowLayout *shareflowLayout = [[UICollectionViewFlowLayout alloc] init];
    shareflowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    shareflowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    shareflowLayout.itemSize =CGSizeMake(itemWidth, itemHeight);
    // 1.设置列间距
    shareflowLayout.minimumInteritemSpacing = 15;
    // 2.设置行间距
    shareflowLayout.minimumLineSpacing = 5;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:shareflowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.chooseSizeView addSubview:self.collectionView];
    [self.collectionView registerClass:[CellForChooseSize class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.delaysContentTouches = NO;
    self.collectionView.delegate = self;
    
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.chooseSizeView.mas_top).offset(50);
        make.width.equalTo(ws.chooseSizeView);
        make.centerX.equalTo(ws.chooseSizeView);
        make.bottom.equalTo(ws.chooseSizeView.mas_bottom).offset(-40);
    }];
    
    UIView *priceBakcground = [[UIView alloc]init];
    [priceBakcground setBackgroundColor:[UIColor lightGrayColor]];
    [self.chooseSizeView addSubview:priceBakcground];
    [priceBakcground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(ws.chooseSizeView.mas_width);
        make.centerX.equalTo(ws.chooseSizeView.mas_centerX);
        make.bottom.equalTo(ws.chooseSizeView.mas_bottom);
        make.height.equalTo(@(40));
    }];
    
    self.choosePrice = [[UILabel alloc]init];
    self.choosePrice.text = @"0 元";
    self.choosePrice.font = [UIFont systemFontOfSize:22];
    [self.chooseSizeView addSubview:self.choosePrice];
    [self.choosePrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.chooseSizeView.mas_left).offset(15);
        make.centerY.equalTo(priceBakcground.mas_centerY).offset(0);
    }];
    
    UIButton *addBuyCar = [UIButton buttonWithType:UIButtonTypeCustom];
    addBuyCar.backgroundColor = [UIColor colorWithHexString:BaseYellow];
    addBuyCar.layer.cornerRadius = 5;
    [addBuyCar setTitle:@"加入购物车" forState:UIControlStateNormal];
    [addBuyCar setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    addBuyCar.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [addBuyCar addTarget:self action:@selector(addBuyCar) forControlEvents:UIControlEventTouchUpInside];
    [self.chooseSizeView addSubview:addBuyCar];
    [addBuyCar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.choosePrice);
        make.right.equalTo(ws.chooseSizeView.mas_right).offset(-10);
        make.bottom.equalTo(ws.chooseSizeView.mas_bottom).offset(-5);
        make.width.equalTo(@(100));
    }];
    
}
-(void)createShopingCarView{
    __weak typeof(self) ws = self;
    self.buyCarView = [[UIView alloc]init];
    self.buyCarView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.buyCarView];
    [self.buyCarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.view.mas_bottom);
        make.width.equalTo(ws.view.mas_width);
        make.height.equalTo(@(shoppingCarViewHeight + SafeAreaTabbarHeight));
        make.centerX.equalTo(ws.view);
    }];
    
    UIImageView *imgShoppingCar = [[UIImageView alloc]init];
    imgShoppingCar.backgroundColor = [UIColor orangeColor];
    [self.buyCarView addSubview:imgShoppingCar];
    [imgShoppingCar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(20));
        make.top.equalTo(@(5));

    make.centerY.equalTo(ws.buyCarView.mas_top).offset(shoppingCarViewHeight/2);
        make.width.equalTo(@(50));
    }];
    
    self.ShoppingCarRedLabel = [[UILabel alloc]init];
    self.ShoppingCarRedLabel.hidden = YES;
    self.ShoppingCarRedLabel.layer.cornerRadius = 10;
    self.ShoppingCarRedLabel.clipsToBounds = YES;
    self.ShoppingCarRedLabel.font = [UIFont systemFontOfSize:12];
    self.ShoppingCarRedLabel.textAlignment = NSTextAlignmentCenter;
    self.ShoppingCarRedLabel.textColor = [UIColor whiteColor];
    self.ShoppingCarRedLabel.backgroundColor = [UIColor redColor];
    [imgShoppingCar addSubview:self.ShoppingCarRedLabel];
    [self.ShoppingCarRedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(imgShoppingCar.mas_right).offset(5);
        make.top.equalTo(imgShoppingCar.mas_top).offset(0);
        make.width.equalTo(@(20));
        make.height.equalTo(@(20));
    }];
    
    self.buyCarAddLabel = [[UILabel alloc]init];
    self.buyCarAddLabel.text = @"0 元";
    self.buyCarAddLabel.font = [UIFont systemFontOfSize:22];
    self.buyCarAddLabel.textColor = [UIColor whiteColor];
    [self.buyCarView addSubview:self.buyCarAddLabel];
    [self.buyCarAddLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.buyCarView.mas_top).offset(shoppingCarViewHeight/2);
        make.left.equalTo(imgShoppingCar.mas_right).offset(20);
    }];
    
    UIButton *addBuyCar = [UIButton buttonWithType:UIButtonTypeCustom];
    addBuyCar.backgroundColor = [UIColor colorWithHexString:@"#00CD00"];
    addBuyCar.layer.cornerRadius = 0;
    [addBuyCar setTitle:NSLocalizedString(@"去结算", nil) forState:UIControlStateNormal];
    [addBuyCar setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addBuyCar.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    [addBuyCar addTarget:self action:@selector(addShoppongCarNetWord) forControlEvents:UIControlEventTouchUpInside];
    [self.buyCarView addSubview:addBuyCar];
    [addBuyCar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.buyCarAddLabel);
        make.right.equalTo(ws.buyCarView.mas_right).offset(0);
        make.top.equalTo(ws.buyCarView.mas_top).offset(0);
        make.width.equalTo(@(100));
    }];
}

#pragma mark - 滚动刷新
#pragma mark ~~~~~~~~~~ TableViewDataSource ~~~~~~~~~~
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.rightTable) {
        return 100;
    }
    return 50;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.rightTable) {
        return self.arrForType.count;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTable) {
        return self.arrForType.count;
    }
    return self.arrForDetal.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.leftTable) {
        UITableViewCell *cell = nil;
        cell = [tableView dequeueReusableCellWithIdentifier:resueIdleft];
       NSDictionary *dic = [self.arrForType objectAtIndex:indexPath.row];
       cell.textLabel.text = dic[@"goodsTypeEntity"][@"goodsTypeName"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.selectedBackgroundView.backgroundColor = [UIColor lightGrayColor];
        UILabel *redIcon = [[UILabel alloc]init];
        redIcon.hidden = YES;
        redIcon.layer.cornerRadius = 8;
        redIcon.clipsToBounds = YES;
        redIcon.font = [UIFont systemFontOfSize:12];
        redIcon.textAlignment = NSTextAlignmentCenter;
        redIcon.textColor = [UIColor whiteColor];
        redIcon.backgroundColor = [UIColor redColor];
        [cell addSubview:redIcon];
        [redIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(cell.textLabel.mas_right).offset(0);
            make.top.equalTo(cell.textLabel.mas_top).offset(5);
            make.width.equalTo(@(16));
            make.height.equalTo(@(16));
        }];
        NSInteger nowRow = indexPath.row + 1;
        if (nowRow == self.leftTableViewSelectRow && self.leftTableViewSelectRow != nil) {
            
            redIcon.hidden = NO;
            
            NSString *value = [NSString stringWithFormat:@"LEFTTABLEVIEW%ld",(long)indexPath.row];
             NSString *COUNT = [defaults objectForKey:value];
            redIcon.text = COUNT;
        }
        
        return cell;
    } else {
        ModelForFoodList *modArr = [self.arrForDetal objectAtIndex:indexPath.row];
        
        if (modArr.goodspic.count > 1) {
            CellForShopFoodChooseSize *cell1 = [tableView cellForRowAtIndexPath:indexPath];//根据indexPath准确地取出一行，而不是从cell重用队列中取出
            if (cell1 == nil) {
                cell1 = [[CellForShopFoodChooseSize alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resueIdrightChooseSize];
            }
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            ModelForFoodList *mod = [self.arrForDetal objectAtIndex:indexPath.row];
            cell1.mod = mod;
            //选大小后加购物车
            cell1.blockChooseSize = ^(ModelForFoodList *mod1) {
                NSLog(@"%f",mod1.pic);
                self.chooesTitle.text = mod1.godsname;
                self.arrForChooseSize = mod1.goodspic;
                [self.collectionView reloadData];
                self.chooseSizeBackgroundView.hidden = NO;
                self.chooseSizeView.hidden = NO;
                self.leftTableViewSelectRow = indexPath.section + 1;
                if (self.leftTableViewSelectRow == nil) {
                    self.leftTableViewSelectRow = 1;
                }
            };
            
            return cell1;
            
        }else{
            
            // 定义cell标识  每个cell对应一个自己的标识
            NSString *CellIdentifier = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section,indexPath.row];
            // 通过不同标识创建cell实例
            CellForShopFood *cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
             ModelForFoodList *mod = [self.arrForDetal objectAtIndex:indexPath.row];
            if (!cell2) {
                
                cell2 = [[CellForShopFood alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
                 NSString *cellValue = [NSString stringWithFormat:@"RightTableViewsection%ldrow%ld",indexPath.section,indexPath.row];
                [defaults setObject:nil forKey:cellValue];
            }
            
            
            cell2.selectionStyle = UITableViewCellSelectionStyleNone;
           
            cell2.mod = mod;
            //直接加购物车
            cell2.blockAddShopingCar = ^(ModelForFoodList *mod2) {
                NSArray *arr = mod2.goodspic;
                NSDictionary *dic = arr[0];
                self.selectbuyCarMoncy = dic[@"goodsPicPic"];
                self.selcetbuyCarId = dic[@"id"];
                [self addBuyCarNoSize];
                
                ModelForFoodList *mod11 = [self.arrForDetal objectAtIndex:indexPath.row];
               
                
                NSInteger removeIndex;
                for (int i = 0 ; i < self.arrForAddShoppingCarList.count; i++) {
                    NSMutableDictionary *dicForChoose = [NSMutableDictionary dictionary];
                    dicForChoose = [self.arrForAddShoppingCarList objectAtIndex:i];
                    NSNumber * getGoodsId =  [NSNumber numberWithInteger:mod11.id];
                    if (dicForChoose[@"g_id"] == getGoodsId) {
                        //已经添加过此商品 增加数量即可
                        self.isDeleArr = @"yes";
                        removeIndex = i;
                    }
                }
                if ([self.isDeleArr isEqualToString:@"yes"]) {
                    //已经添加过此商品 增加数量即可
                    NSMutableDictionary *dicForChoose = [NSMutableDictionary dictionary];
                    dicForChoose = [self.arrForAddShoppingCarList objectAtIndex:removeIndex];
                    NSInteger  GetgoodsCount = [dicForChoose[@"count"] integerValue];
                    GetgoodsCount = GetgoodsCount + 1;
                    NSNumber * goodsCount = [NSNumber numberWithInteger:GetgoodsCount];
                    [self.arrForAddShoppingCarList removeObjectAtIndex:removeIndex];
                    //添加字典
                    NSNumber * good_Id =  [NSNumber numberWithInteger:mod11.id];
                    NSString *picStr = [NSString stringWithFormat:@"%.f",mod11.pic];
                    
                    [dicForChoose setObject:goodsCount forKey:@"count"];
                    [dicForChoose setObject:good_Id forKey:@"g_id"];
                    [dicForChoose setObject:mod.godsname forKey:@"g_name"];
                    [dicForChoose setObject:picStr forKey:@"g_pic"];
                    [dicForChoose setObject:mod.godslog forKey:@"g_log"];
                    [self.arrForAddShoppingCarList addObject:dicForChoose];
                    self.isDeleArr = @"no";
                }else{
                    //新添加的商品
                    NSNumber * good_Id =  [NSNumber numberWithInteger:mod11.id];
                    NSString *picStr = [NSString stringWithFormat:@"%.f",mod11.pic];
                    NSNumber * goodsCount = [NSNumber numberWithInteger:1];
                    NSMutableDictionary *dicForChoose = [NSMutableDictionary dictionary];
                    [dicForChoose setObject:goodsCount forKey:@"count"];
                    [dicForChoose setObject:good_Id forKey:@"g_id"];
                    [dicForChoose setObject:mod.godsname forKey:@"g_name"];
                    [dicForChoose setObject:picStr forKey:@"g_pic"];
                    [dicForChoose setObject:mod.godslog forKey:@"g_log"];
                    [self.arrForAddShoppingCarList addObject:dicForChoose];
                }
                //添加字典
                
                
            //左边小红点
                self.leftTableViewSelectRow = indexPath.section + 1;
                if (self.leftTableViewSelectRow == nil) {
                    self.leftTableViewSelectRow = 1;
                }
                NSString *value = [NSString stringWithFormat:@"LEFTTABLEVIEW%ld",(long)indexPath.section];
                NSString *countStr = [defaults objectForKey:value];
                NSInteger count = [countStr integerValue];
                count++;
                countStr = [NSString stringWithFormat:@"%ld",(long)count];
                
                NSString *cellValue = [NSString stringWithFormat:@"RightTableViewsection%ldrow%ld",indexPath.section,indexPath.row];
                NSInteger rightCellCount;
                NSString *rightCellCountStr = [defaults objectForKey:cellValue];
                if (rightCellCountStr  == nil) {
                    rightCellCount = 1;
                }else{
                    rightCellCount = [rightCellCountStr integerValue];
                    rightCellCount++;
                }
                if (rightCellCount != 0) {
                    [cell2.chooseCountLabel setHidden:NO];
                    [cell2.delectToShoppingCar setHidden:NO];
                }
                cell2.ChooseCount = rightCellCount;
                cell2.chooseCountLabel.text = [NSString stringWithFormat:@"-%ld-",(long)rightCellCount];
                rightCellCountStr = [NSString stringWithFormat:@"%ld",(long)rightCellCount];
                [defaults setObject:rightCellCountStr forKey:cellValue];
                [defaults setObject:countStr forKey:value];
                [defaults synchronize];
                [self.leftTable reloadData];
                
                self.ShoppingCarRedNum++;
                self.ShoppingCarRedLabel.hidden = NO;
                self.ShoppingCarRedLabel.text = [NSString stringWithFormat:@"%ld",(long)_ShoppingCarRedNum];
                
                
            };
            
            cell2.blockDelShopingCar = ^(ModelForFoodList *mod3) {
                NSArray *arr = mod3.goodspic;
                NSDictionary *dic = arr[0];
                self.selectbuyCarMoncy = dic[@"goodsPicPic"];
                self.selcetbuyCarId = dic[@"id"];
                [self delectBuyCarNoSize];
   //************ 网路请求 error
//                ModelForFoodList *mod11 = [self.arrForDetal objectAtIndex:indexPath.row];
//                NSMutableDictionary *dicForChoose = [NSMutableDictionary dictionary];
//                //添加字典
//                NSNumber * good_Id =  [NSNumber numberWithInteger:mod11.id];
//                NSString *picStr = [NSString stringWithFormat:@"%.f",mod11.pic];
//                NSNumber * goodsCount = [NSNumber numberWithInteger:1];
//
//                [dicForChoose setObject:goodsCount forKey:@"count"];
//                [dicForChoose setObject:good_Id forKey:@"g_id"];
//                [dicForChoose setObject:mod.godsname forKey:@"g_name"];
//                [dicForChoose setObject:picStr forKey:@"g_pic"];
//                [dicForChoose setObject:mod.godslog forKey:@"g_log"];
//                [self.arrForAddShoppingCarList addObject:dicForChoose];
            
                //左边小红点
                self.leftTableViewSelectRow = indexPath.section + 1;
                if (self.leftTableViewSelectRow == nil) {
                    self.leftTableViewSelectRow = 1;
                }
                NSString *value = [NSString stringWithFormat:@"LEFTTABLEVIEW%ld",(long)indexPath.section];
                NSString *countStr = [defaults objectForKey:value];
                NSInteger count = [countStr integerValue];
                count--;
                countStr = [NSString stringWithFormat:@"%ld",(long)count];
                
                NSString *cellValue = [NSString stringWithFormat:@"RightTableViewsection%ldrow%ld",indexPath.section,indexPath.row];
                NSInteger rightCellCount;
                NSString *rightCellCountStr = [defaults objectForKey:cellValue];
                if (rightCellCountStr  == nil) {
                    rightCellCount = 1;
                }else{
                    rightCellCount = [rightCellCountStr integerValue];
                    rightCellCount--;
                }
                
                cell2.ChooseCount = rightCellCount;
                cell2.chooseCountLabel.text = [NSString stringWithFormat:@"-%ld-",(long)rightCellCount];
                rightCellCountStr = [NSString stringWithFormat:@"%ld",(long)rightCellCount];
                if (rightCellCount == 0) {
                    [cell2.chooseCountLabel setHidden:YES];
                    [cell2.delectToShoppingCar setHidden:YES];
                }
                [defaults setObject:rightCellCountStr forKey:cellValue];
                [defaults setObject:countStr forKey:value];
                [defaults synchronize];
                [self.leftTable reloadData];
                
                self.ShoppingCarRedNum--;
                self.ShoppingCarRedLabel.hidden = NO;
                self.ShoppingCarRedLabel.text = [NSString stringWithFormat:@"%ld",(long)_ShoppingCarRedNum];
                
                
            };
           
            return cell2;
            
        }
    }
    return  nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == self.rightTable) {
       NSDictionary * dic = [self.arrForType objectAtIndex:section];
        NSString *tit = dic[@"goodsTypeEntity"][@"goodsTypeName"];
        
        return tit;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTable) {
        [self.rightTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        self.isSelected = YES;
        
    }
}

// 头部视图将要显示时调用
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (tableView == self.rightTable) {
        // 判断，如果是左边点击触发的滚动，这不执行下面代码
        if (self.isSelected) {
            return;
        }
        
        // 获取可见视图的第一个row
        //NSInteger currentSection = [[[self.rightTable indexPathsForVisibleRows] firstObject] section];
       // NSIndexPath *index = [NSIndexPath indexPathForRow:currentSection inSection:0];
        NSIndexPath *index = [NSIndexPath indexPathForRow:section inSection:0];
        // 点击左边对应区块
        [self.leftTable selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
}

// 开始拖动赋值没有点击
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    // 当右边视图将要开始拖动时，则认为没有被点击了。
    self.isSelected = NO;
}

#pragma mark collectionView代理方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.arrForChooseSize.count == nil) {
        return 1;
    }
    return self.arrForChooseSize.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CellForChooseSize *cell = (CellForChooseSize *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    if (self.arrForChooseSize.count != 0) {
        NSDictionary *dic = [self.arrForChooseSize objectAtIndex:indexPath.row];
        cell.nameLabel.text = dic[@"goodsPicName"];
        
    }

    cell.backgroundColor = [UIColor grayColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [self.arrForChooseSize objectAtIndex:indexPath.row];
    NSString *strPic = dic[@"goodsPicPic"];
    self.choosePrice.text = [NSString stringWithFormat:@"%@ 元",strPic];
    self.selectbuyCarMoncy = dic[@"goodsPicPic"];
    self.selcetbuyCarId = dic[@"id"];
    
    
}

#pragma mark - 点击事件
-(void)removewChooseView{
    [self.chooseSizeBackgroundView setHidden:YES];
    [self.chooseSizeView setHidden:YES];
}
-(void)addBuyCar{
    NSLog(@"%@,%f",self.selectbuyCarMoncy,self.addMoney);
    self.addMoney = [self.selectbuyCarMoncy floatValue] + self.addMoney;
    self.buyCarAddLabel.text = [NSString stringWithFormat:@"%.2f 元",self.addMoney];
    NSInteger row = self.leftTableViewSelectRow - 1;
    NSString *value = [NSString stringWithFormat:@"LEFTTABLEVIEW%ld",(long)row];
    NSString *countStr = [defaults objectForKey:value];
    NSInteger count = [countStr integerValue];
    count++;
    countStr = [NSString stringWithFormat:@"%ld",(long)count];
    [defaults setObject:countStr forKey:value];
    [defaults synchronize];
    [self.leftTable reloadData];
    
    self.ShoppingCarRedNum++;
    self.ShoppingCarRedLabel.hidden = NO;
    self.ShoppingCarRedLabel.text = [NSString stringWithFormat:@"%ld",(long)_ShoppingCarRedNum];
}
-(void)addBuyCarNoSize{
    NSLog(@"当前购物车%@,加上新的%f",self.selectbuyCarMoncy,self.addMoney);
    self.addMoney = [self.selectbuyCarMoncy floatValue] + self.addMoney;
    self.buyCarAddLabel.text = [NSString stringWithFormat:@"%.2f 元",self.addMoney];
}
-(void)delectBuyCarNoSize{
    NSLog(@"当前购物车%@,减去取消的%f",self.selectbuyCarMoncy,self.addMoney);
    self.addMoney =   self.addMoney  - [self.selectbuyCarMoncy floatValue];
    self.buyCarAddLabel.text = [NSString stringWithFormat:@"%.2f 元",self.addMoney];
}
-(void)addShoppongCarNetWord{
    [self getNetWorkForAddShoppingCar];
}
-(void)back{
    NSLog(@"1111111111");
}
#pragma mark - 动效

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
