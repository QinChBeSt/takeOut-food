//
//  OrderEditVC.m
//  takeOut
//
//  Created by mac on 2018/4/9.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "OrderEditVC.h"
#define riderIconHeight 130

@interface OrderEditVC ()
@property (nonatomic , strong)UIView *naviView;

@property (nonatomic , strong)UIView *riderView;
@property (nonatomic , strong)UIImageView *riderIcon;
@property (nonatomic , strong)UILabel *riderName;
@property (nonatomic , strong)UILabel *riderTime;
@property (nonatomic , strong)UIButton *riderGoodBtn;
@property (nonatomic , strong)UIButton *riderMidBtn;
@property (nonatomic , strong)UIButton *riderBadBtn;

@property (nonatomic , strong)UIView *foodView;
@property (nonatomic , strong)UIImageView *foodIcon;
@property (nonatomic , strong)UILabel *foodName;
@property (nonatomic , strong)UIButton *foodGoodBtn;
@property (nonatomic , strong)UIButton *foodMidBtn;
@property (nonatomic , strong)UIButton *foodBadBtn;

@property (nonatomic , strong)NSString *riderSelectStr;
@property (nonatomic , strong)NSString *foodSelectStr;
@end

@implementation OrderEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
    [self createNaviView];
    [self setUpUI];
    // Do any additional setup after loading the view.
}
#pragma mark - ui
-(void)createNaviView{
    self.view.backgroundColor = [UIColor colorWithHexString:@"E8E8E8"];
    self.naviView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SafeAreaTopHeight )];
    self.naviView.backgroundColor = [UIColor colorWithHexString:BaseYellow];
    [self.view addSubview:self.naviView];
    
    __weak typeof(self) ws = self;
    UIImageView *backImg = [[UIImageView alloc]init];
    backImg.backgroundColor = [UIColor orangeColor];
    [self.naviView addSubview:backImg];
    [backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.naviView.mas_top).offset(SafeAreaStatsBarHeight + 5);
        make.left.equalTo(ws.naviView.mas_left).offset(15);
        make.width.equalTo(@(25));
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
    titleLabel.text = NSLocalizedString(@"评价", nil);
    titleLabel.textColor = [UIColor blackColor];
    [self.naviView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.centerY.equalTo(backImg);
    }];
}
-(void)setUpUI{
    __weak typeof(self) ws = self;
    self.riderView = [[UIView alloc]initWithFrame:CGRectMake(10, SafeAreaTopHeight + 15, SCREEN_WIDTH - 20,  riderIconHeight)];
    self.riderView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.riderView];
    
    self.riderIcon = [[UIImageView alloc]init];
    self.riderIcon.layer.cornerRadius=(riderIconHeight / 2 - 15 )/2;
    self.riderIcon.clipsToBounds = YES;
    self.riderIcon.backgroundColor = [UIColor orangeColor];
    [self.riderView addSubview:self.riderIcon];
    [self.riderIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.riderView.mas_left).offset(15);
        make.top.equalTo(ws.riderView.mas_top).offset(10);
        make.bottom.equalTo(ws.riderView.mas_centerY).offset(-5);
        make.width.equalTo(ws.riderIcon.mas_height);
    }];
    
    self.riderName = [[UILabel alloc]init];
    self.riderName.text = @"骑手名称";
    self.riderName.textColor = [UIColor lightGrayColor];
    [self.riderView addSubview:self.riderName];
    [self.riderName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.riderIcon.mas_centerY).offset(-3);
        make.left.equalTo(ws.riderIcon.mas_right).offset(10);
    }];
    
    self.riderTime = [[UILabel alloc]init];
    self.riderTime.text = @"4月1日12：30左右送达";
    self.riderTime.textColor = [UIColor lightGrayColor];
    [self.riderView addSubview:self.riderTime];
    [self.riderTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.riderIcon.mas_centerY).offset(3);
        make.left.equalTo(ws.riderIcon.mas_right).offset(10);
    }];
    
    
    UIView *midLine = [[UIView alloc]init];
    midLine.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
    [self.riderView addSubview:midLine];
    [midLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.riderView);
        make.left.equalTo(ws.riderView.mas_left).offset(15);
        make.top.equalTo(ws.riderView.mas_centerY).offset(10);
        make.height.equalTo(@(0.5));
    }];
    
    self.riderGoodBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.riderView addSubview:self.riderGoodBtn];
    self.riderGoodBtn.layer.cornerRadius=15;
    self.riderGoodBtn.clipsToBounds = YES;
    [self.riderGoodBtn setTitle:@"满意" forState:UIControlStateNormal];
    [self.riderGoodBtn addTarget:self action:@selector(goodForRider) forControlEvents:UIControlEventTouchUpInside];
    [self.riderGoodBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.riderGoodBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@((SCREEN_WIDTH - 20) / 3 - 80/3));
        make.left.equalTo(ws.riderView.mas_left).offset(20);
        make.top.equalTo(midLine.mas_bottom).offset(10);
        make.bottom.equalTo(ws.riderView.mas_bottom).offset(-10);
    }];
    
    self.riderMidBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.riderView addSubview:self.riderMidBtn];
    self.riderMidBtn.layer.cornerRadius=15;
    self.riderMidBtn.clipsToBounds = YES;
    [self.riderMidBtn setTitle:@"一般" forState:UIControlStateNormal];
    [self.riderMidBtn addTarget:self action:@selector(midForRider) forControlEvents:UIControlEventTouchUpInside];
    [self.riderMidBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.riderMidBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@((SCREEN_WIDTH - 20) / 3 - 80/3));
        make.left.equalTo(ws.riderGoodBtn.mas_right).offset(10);
        make.top.equalTo(midLine.mas_bottom).offset(10);
        make.bottom.equalTo(ws.riderView.mas_bottom).offset(-10);
    }];
    
    self.riderBadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.riderView addSubview:self.riderBadBtn];
    self.riderBadBtn.layer.cornerRadius=15;
    self.riderBadBtn.clipsToBounds = YES;
    [self.riderBadBtn setTitle:@"不满意" forState:UIControlStateNormal];
    [self.riderBadBtn addTarget:self action:@selector(badForRider) forControlEvents:UIControlEventTouchUpInside];
    [self.riderBadBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.riderBadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@((SCREEN_WIDTH - 20) / 3 - 80/3));
        make.left.equalTo(ws.riderMidBtn.mas_right).offset(10);
        make.top.equalTo(midLine.mas_bottom).offset(10);
        make.bottom.equalTo(ws.riderView.mas_bottom).offset(-10);
    }];
    
    
    self.foodView = [[UIView alloc]init];
    self.foodView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.foodView];
}
#pragma mark - 点击事件
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)goodForRider{
    self.riderSelectStr = @"满意";
    [self.riderGoodBtn setBackgroundColor:[UIColor colorWithHexString:BaseYellow]];
    [self.riderGoodBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.riderMidBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.riderMidBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.riderBadBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.riderBadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}
-(void)midForRider{
    self.riderSelectStr = @"一般";
    [self.riderMidBtn setBackgroundColor:[UIColor colorWithHexString:BaseYellow]];
    [self.riderMidBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
   
    
    [self.riderGoodBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.riderGoodBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.riderBadBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.riderBadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
-(void)badForRider{
    self.riderSelectStr = @"不满意";
    [self.riderBadBtn setBackgroundColor:[UIColor colorWithHexString:BaseYellow]];
    [self.riderBadBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    [self.riderMidBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.riderMidBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.riderGoodBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.riderGoodBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
