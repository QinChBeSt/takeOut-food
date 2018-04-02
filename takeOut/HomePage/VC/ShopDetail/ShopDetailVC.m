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

@interface ShopDetailVC ()
@property (nonatomic , strong) UIView *niveView;
@property (nonatomic, strong) ZWMSegmentController *segmentVC;
@property (nonatomic , copy) NSString *shopId;
@end

@implementation ShopDetailVC
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
}
- (void)CreateSegment{
    self.navigationController.navigationBar.translucent = NO;
    
    FoodListVC *f = [[FoodListVC alloc] init];
    f.shopId = self.shopId;
    EvaluationVC *s = [[EvaluationVC alloc] init];
    ShopMassageVC *f1 = [[ShopMassageVC alloc] init];

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

-(void)setModShopList:(ModelForShopList *)modShopList{
    self.shopId = modShopList.store_id;
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
