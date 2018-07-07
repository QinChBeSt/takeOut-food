//
//  ShopMassageVC.m
//  takeOut
//
//  Created by mac on 2018/3/26.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "ShopMassageVC.h"
#import "ShopMapLoactionView.h"
#import "FoodSafeVC.h"
#define kHeadCollectionViewHeight 150
@interface ShopMassageVC ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)NSString *openTime;

@property (nonatomic , strong)UIView *headView;
@property (nonatomic , strong)UILabel *addressLab;
@property (nonatomic , strong)UIImageView *shopIcon;
@property (nonatomic , strong)NSString *shopPhoneNo;

@property (nonatomic , strong)UIView *footView;
@property (nonatomic , strong)UIImageView *yhIcon;
@property (nonatomic , strong)NSMutableArray *arrForSAVE;

@property (nonatomic , strong)NSString *latStr;
@property (nonatomic , strong)NSString *longStr;
@property (nonatomic , strong)NSString *shopName;
@property (nonatomic , strong)NSString *shopADD;

@property (nonatomic , strong)NSMutableArray *shopPhotoArr;
@property (nonatomic , strong)NSMutableArray *shopSafePhotoArr;
@property (nonatomic , strong)UICollectionView *collectionView;
@end

@implementation ShopMassageVC
-(NSMutableArray *)arrForSAVE{
    if (_arrForSAVE == nil) {
        _arrForSAVE = [NSMutableArray array];
    }
    return _arrForSAVE;
}
-(NSMutableArray *)shopPhotoArr{
    if (_shopPhotoArr == nil) {
        _shopPhotoArr = [NSMutableArray array];
    }
    return _shopPhotoArr;
}
-(NSMutableArray *)shopSafePhotoArr{
    if (_shopSafePhotoArr == nil) {
        _shopSafePhotoArr = [NSMutableArray array];
    }
    return _shopSafePhotoArr;
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
        NSString *shopLOGURL = [NSString stringWithFormat:@"%@%@",IMGBaesURL,resDic[@"shoplog"]];
        [self.shopIcon sd_setImageWithURL:[NSURL URLWithString:shopLOGURL]];
        self.openTime = [NSString stringWithFormat:@"%@:%@",ZBLocalized(@"配送时间", nil),resDic[@"opentime"]];
        self.shopName =resDic[@"shopname"];
        self.shopADD =resDic[@"shopad"];
        self.shopPhotoArr = resDic[@"shopphoto"];
        self.shopSafePhotoArr = resDic[@"safephoto"];
        self.addressLab.text = resDic[@"shopad"];
        self.shopPhoneNo = resDic[@"shopphone"];
        self.latStr = resDic[@"lat"];
        self.longStr = resDic[@"lang"];
        __weak typeof(self) ws = self;
//        for (int i = 0 ; i < self.shopPhotoArr.count;i++ ) {
//            NSString *urlShopArr = self.shopPhotoArr[i];
//            self.shopIcon = [[UIImageView alloc]init];
//            [self.shopIcon sd_setImageWithURL:[NSURL URLWithString:urlShopArr] placeholderImage:[UIImage imageNamed:@"logo"]];
//            [self.headView addSubview:self.shopIcon];
//            [self.shopIcon mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.left.equalTo(ws.headView.mas_left).offset(15 + i * 75);
//                make.top.equalTo(ws.headView.mas_top).offset(50);
//                make.bottom.equalTo(ws.headView.mas_bottom).offset(-15);
//                make.width.equalTo(ws.shopIcon.mas_height);
//            }];
//        }
        if (self.shopPhotoArr.count == 0) {
            self.headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
            [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(ws.headView.mas_top);
                make.width.equalTo(@(SCREEN_WIDTH));
                make.left.equalTo(ws.headView);
                make.height.equalTo(@(0));
            }];
        }
        
        [self.tableView reloadData];
        [self.collectionView reloadData];
    } withFail:^(NSError *error) {
        
    }];
}
-(void)CreateheadView{
    __weak typeof(self) ws = self;
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeadCollectionViewHeight + 50)];
    [self.view addSubview:self.headView];
    
    CGFloat itemWidth = (SCREEN_WIDTH - 5 )/ 3;
    CGFloat itemHeight = kHeadCollectionViewHeight - 2;
    UICollectionViewFlowLayout *shareflowLayout = [[UICollectionViewFlowLayout alloc] init];
    shareflowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    shareflowLayout.sectionInset = UIEdgeInsetsMake(1, 1, 1,1);
    shareflowLayout.itemSize =CGSizeMake(itemWidth, itemHeight);
    // 1.设置列间距
    shareflowLayout.minimumInteritemSpacing = 0;
    // 2.设置行间距
    shareflowLayout.minimumLineSpacing = 0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:shareflowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.headView addSubview:self.collectionView];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.delaysContentTouches = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.headView.mas_top);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.left.equalTo(ws.headView);
        make.height.equalTo(@(kHeadCollectionViewHeight));
    }];
    
   
    
    self.addressLab = [[UILabel alloc]init];
    self.addressLab.numberOfLines = 2;
    self.addressLab.textAlignment = NSTextAlignmentLeft;
    self.addressLab.font = [UIFont systemFontOfSize:14];
    [self.headView addSubview:self.addressLab];
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.headView.mas_left).offset(45);
        make.top.equalTo(ws.collectionView.mas_bottom).offset(0);
        make.right.equalTo(ws.headView.mas_right).offset(-SCREEN_WIDTH / 5);
        make.height.equalTo(@(50));
    }];
    
    UIImageView *addIcon =[[UIImageView alloc]init];
    [addIcon setImage:[UIImage imageNamed:@"icon_shangjiaxiangqingdizhi"]];
    [self.headView addSubview:addIcon];
    [addIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.addressLab);
        make.left.equalTo(ws.headView.mas_left).offset(15);
        make.width.equalTo(@(15));
        make.height.equalTo(@(15));
    }];
    
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)];
    // 2. 将点击事件添加到label上
    [self.addressLab  addGestureRecognizer:labelTapGestureRecognizer];
    self.addressLab .userInteractionEnabled = YES; // 可以理解为设置label可被点击

    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
    [self.headView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.addressLab.mas_right).offset(15);
        make.bottom.equalTo(ws.addressLab);
        make.width.equalTo(@(1));
        make.top.equalTo(ws.addressLab.mas_top).offset(0);
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
    [phoneIcon setImage:[UIImage imageNamed:@"icon_shangjiaxiangqingdianhua"]];
    [self.headView addSubview:phoneIcon];
    [phoneIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(telBtn);
        make.centerY.equalTo(telBtn);
        make.width.and.height.equalTo(@(30));
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
    [saveTitIocn setImage:[UIImage imageNamed:@"icon_shangjiaxiangqingyouhui"]];
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
            
            
            UILabel *saveLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 60 +  i * 30, SCREEN_WIDTH - 100, 15)];
            saveLabel.font = [UIFont systemFontOfSize:14];
        
            
            NSString *savr1Str =[NSString stringWithFormat:@"%@",self.arrForSAVE[i][@"content"]];
            NSArray *arraySave1 = [savr1Str componentsSeparatedByString:@","];
            NSString *CHSave1Str;
            NSString *THSave1Str;
            NSString *ENSave1Str;
     
            if (arraySave1.count == 1) {
                CHSave1Str =savr1Str;
                THSave1Str = savr1Str;
                ENSave1Str = savr1Str;
            }else if(arraySave1.count == 2){
                CHSave1Str =arraySave1[0];
                THSave1Str = arraySave1[1];
                ENSave1Str = arraySave1[1];
            }else{
                CHSave1Str =arraySave1[0];
                THSave1Str = arraySave1[1];
                ENSave1Str = arraySave1[2];
            }
            
            NSString *language=[[ZBLocalized sharedInstance]currentLanguage];
            if ([language isEqualToString:@"th"]) {
                 saveLabel.text =THSave1Str;
            }
            else if ([language isEqualToString:@"zh-Hans"]) {
                 saveLabel.text = CHSave1Str;
            }
            else if ([language isEqualToString:@"en"]) {
                 saveLabel.text = ENSave1Str;
            }
            
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
        [icon setImage:[UIImage imageNamed:@"icon_shangjiaxiangqingchakan"]];
        text.text =ZBLocalized(@"查看食品安全档案", nil) ;
    }else if (indexPath.row == 1){
        [icon setImage:[UIImage imageNamed:@"icon_shangjiaxiangqingshijian"]];
        text.text = self.openTime;
    }
    
    return cell;
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        FoodSafeVC *food = [[FoodSafeVC alloc]init];
        food.arrForPhoto = self.shopSafePhotoArr;
        [self.navigationController pushViewController:food animated:YES];
    }
    
}
/* 行高 **/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
    
}

#pragma mark collectionView代理方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.shopPhotoArr.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    NSString *url = [self.shopPhotoArr objectAtIndex:indexPath.row];
    url = [NSString  stringWithFormat:@"%@/%@",IMGBaesURL,url];
    
    UIImageView *img = [[UIImageView alloc]init];
    [img sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"logo"]];
    [cell addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView);
        make.centerX.equalTo(cell.contentView);
        make.top.equalTo(cell.contentView).offset(3);
        make.left.equalTo(cell.contentView).offset(1.5);
    }];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
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
- (void)labelClick {
    ShopMapLoactionView *shop = [[ShopMapLoactionView alloc]init];
    if ([_latStr floatValue] >90) {
        [MBManager showBriefAlert:ZBLocalized(@"经纬度错误", nil)];
    }else{
        shop.latStr = self.latStr;
        shop.langStr = self.longStr;
        shop.name  = self.shopName;
        shop.add = self.shopADD;
        [self.navigationController pushViewController:shop animated:YES];
    }
    
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
