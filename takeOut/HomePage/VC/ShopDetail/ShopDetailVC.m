//
//  ShopDetailVC.m
//  takeOut
//
//  Created by mac on 2018/3/26.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "ShopDetailVC.h"
#import "ZWMSegmentController.h"
#import "FoodListVC.h"
#import "EvaluationVC.h"
#import "ShopMassageVC.h"
#import "ShopDetailMassageVC.h"

@interface ShopDetailVC ()
@property (nonatomic , strong) UIView *niveView;
@property (nonatomic, strong) ZWMSegmentController *segmentVC;
@property (nonatomic , copy) NSString *shopId;
@property (nonatomic , copy) NSString *shopUpPayMoney;
@property (nonatomic , strong)NSArray *saveListArr;
@property (nonatomic , strong)UIImageView *shipIcon;
@property (nonatomic , strong)UILabel *shopName;
@property (nonatomic , strong)UILabel *shopSaveLabel;
@property (nonatomic , strong)UIImageView *shopSaveImg;
@property (nonatomic , strong)UILabel *shopSaveNumLabel;
@property (nonatomic , strong)ModelForShopList *toNextMod;
@end

@implementation ShopDetailVC{
    NSString *shopNameStr;
    NSString *shopSaveIconUrl;
    NSString *shopSaveStr;
    NSString *numForSaveCount;
}
-(void)viewWillAppear:(BOOL)animated{
  
  
     
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createNaviView];
    [self CreateSegment];
    // Do any additional setup after loading the view.
}

#pragma mark - ui
-(void)createNaviView{
    self.niveView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SafeAreaTopHeight + 100)];
    self.niveView.backgroundColor = [UIColor colorWithHexString:@"737300"];
    [self.view addSubview:self.niveView];
    
    __weak typeof(self) ws = self;
    UIImageView *backImg = [[UIImageView alloc]init];
    backImg.backgroundColor = [UIColor orangeColor];
    [self.niveView addSubview:backImg];
    [backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.niveView.mas_top).offset(SafeAreaStatsBarHeight + 5);
        make.left.equalTo(ws.niveView.mas_left).offset(15);
        make.width.equalTo(@(25));
        make.height.equalTo(@(30));
    }];
    
    UIButton *backBTN = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBTN addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.niveView addSubview:backBTN];
    [backBTN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.niveView.mas_top).offset(SafeAreaStatsBarHeight);
        make.left.equalTo(ws.niveView.mas_left).offset(10);
        make.width.equalTo(@(40));
        make.height.equalTo(@(SafeAreaTopHeight - SafeAreaStatsBarHeight));
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"商家详情";
    titleLabel.textColor = [UIColor whiteColor];
    [self.niveView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.centerY.equalTo(backImg);
    }];
    
    self.shipIcon = [[UIImageView alloc]init];
    [self.shipIcon setBackgroundColor:[UIColor orangeColor]];
    [self.niveView addSubview:self.shipIcon];
    [self.shipIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.niveView.mas_left).offset(10);
        make.bottom.equalTo(ws.niveView.mas_bottom).offset(-10);
        make.width.equalTo(@(SCREEN_WIDTH / 5));
        make.height.equalTo(@(SCREEN_WIDTH / 5));
    }];
    
    self.shopName = [[UILabel alloc]init];
    self.shopName.text = shopNameStr;
    self.shopName.textColor = [UIColor whiteColor];
    [self.niveView addSubview:self.shopName];
    [self.shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.shipIcon.mas_right).offset(20);
        make.top.equalTo(ws.shipIcon);
    }];
    
    self.shopSaveImg = [[UIImageView alloc]init];
    [self.shopSaveImg sd_setImageWithURL:[NSURL URLWithString:shopSaveIconUrl]];
    [self.niveView addSubview:self.shopSaveImg];
    [self.shopSaveImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.shopName);
        make.top.equalTo(ws.shopName.mas_bottom).offset(20);
        make.width.equalTo(@(15));
        make.height.equalTo(@(15));
    }];
    
    self.shopSaveLabel = [[UILabel alloc]init];
    self.shopSaveLabel.font = [UIFont systemFontOfSize:12];
    self.shopSaveLabel.textColor = [UIColor whiteColor];
    self.shopSaveLabel.text = shopSaveStr;
    [self.niveView addSubview:self.shopSaveLabel];
    [self.shopSaveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_shopSaveImg);
        make.left.equalTo(ws.shopSaveImg.mas_right).offset(5);
    }];
    
    UIImageView *rightIcon = [[UIImageView alloc]init];
    rightIcon.backgroundColor = [UIColor orangeColor];
    [self.niveView addSubview:rightIcon];
    [rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.niveView.mas_right).offset(-15);
        make.centerY.equalTo(ws.shopSaveImg);
        make.width.equalTo(@(8));
        make.height.equalTo(@(12));
    }];
    
    
    self.shopSaveNumLabel = [[UILabel alloc]init];
    self.shopSaveNumLabel.font = [UIFont systemFontOfSize:12];
    self.shopSaveNumLabel.textColor = [UIColor whiteColor];
    self.shopSaveNumLabel.text = numForSaveCount;
    [self.niveView addSubview:self.shopSaveNumLabel];
    [self.shopSaveNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_shopSaveImg);
        make.right.equalTo(rightIcon.mas_left).offset(-5);
    }];
    
    UIButton *toDetailVC = [UIButton buttonWithType:UIButtonTypeCustom];
    [toDetailVC addTarget:self action:@selector(toDetail) forControlEvents:UIControlEventTouchUpInside];
    [self.niveView addSubview:toDetailVC];
    [toDetailVC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.niveView.mas_bottom).offset(-10);
        make.left.equalTo(ws.shipIcon.mas_right).offset(20);
        make.top.equalTo(ws.shopName);
        make.right.equalTo(ws.niveView.mas_right);
    }];
    
    if (self.saveListArr.count == 0) {
        self.shopSaveLabel.hidden = YES;
        self.shopSaveImg.hidden = YES;
        self.shopSaveNumLabel.hidden = YES;
    }
}

- (void)CreateSegment{
    self.navigationController.navigationBar.translucent = NO;
    
    FoodListVC *f = [[FoodListVC alloc] init];
    f.shopId = self.shopId;
    f.upPayMoney = self.shopUpPayMoney;
    EvaluationVC *s = [[EvaluationVC alloc] init];
    s.shopId = self.shopId;
    ShopMassageVC *f1 = [[ShopMassageVC alloc] init];
    f1.shopId = self.shopId;
    f1.saveArr = self.saveListArr;
    NSArray *array = @[f,s,f1];
    
    self.segmentVC = [[ZWMSegmentController alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight + 100, SCREEN_WIDTH, SCREENH_HEIGHT - SafeAreaTopHeight -100) titles:@[@"点菜",@"评价",@"商家"]];
    self.segmentVC.segmentView.showSeparateLine = YES;
    self.segmentVC.segmentView.segmentTintColor = [UIColor blackColor];
    self.segmentVC.viewControllers = [array copy];
    if (array.count==1) {
        self.segmentVC.segmentView.style=ZWMSegmentStyleDefault;
    } else {
        self.segmentVC.segmentView.style=ZWMSegmentStyleFlush;
    }
    [self addSegmentController:self.segmentVC];
    [self.segmentVC  setSelectedAtIndex:0];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)toDetail{
    ShopDetailMassageVC *detailVC = [[ShopDetailMassageVC alloc]init];
    detailVC.modShopList = self.toNextMod;
    [self.navigationController pushViewController:detailVC animated:YES];
}
-(void)setModShopList:(ModelForShopList *)modShopList{
    self.toNextMod = modShopList;
    self.shopId = modShopList.store_id;
    self.shopUpPayMoney = modShopList.up_pic;
    shopNameStr = modShopList.store_name;
    if (modShopList.act_list.count != 0) {
        self.saveListArr = modShopList.act_list;
        numForSaveCount = [NSString stringWithFormat:@"%lu%@",(unsigned long)self.saveListArr.count,NSLocalizedString(@"个活动", nil)];
         NSString *imgUrl =  self.saveListArr[0][@"img"];
         shopSaveIconUrl =[NSString stringWithFormat:@"%@/%@",BASEURL,imgUrl] ;
        int count = 0;
        for (NSMutableDictionary *dic in self.saveListArr) {
            
            if (shopSaveStr == nil) {
                shopSaveStr = dic[@"content"];
            }else{
                if (count < 2) {
                     shopSaveStr = [NSString stringWithFormat:@"%@,%@",shopSaveStr,dic[@"content"]];
                }
           
           }
            count++;
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
