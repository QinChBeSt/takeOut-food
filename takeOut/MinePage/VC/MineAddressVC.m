//
//  MineAddressVC.m
//  takeOut
//
//  Created by mac on 2018/4/3.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "MineAddressVC.h"
#import "AddNewAddressVC.h"
@interface MineAddressVC ()
@property (nonatomic , strong)UIView *naviView;
@end

@implementation MineAddressVC

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
    titleLabel.text = NSLocalizedString(@"我的地址", nil);
    titleLabel.textColor = [UIColor blackColor];
    [self.naviView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.centerY.equalTo(backImg);
    }];
}
-(void)setUpUI{
    [self createButtonBtn];
    
}
-(void)createButtonBtn{
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENH_HEIGHT - SafeAreaTabbarHeight - 50, SCREEN_WIDTH, 50 + SafeAreaTabbarHeight)];
    bottomView.backgroundColor = [UIColor colorWithHexString:BaseYellow];
    [self.view addSubview:bottomView];
    
    
    UIButton *addNewADD = [UIButton buttonWithType:UIButtonTypeCustom];
    addNewADD.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    [addNewADD setTitle:NSLocalizedString(@" + 新增收货地址", nil) forState:UIControlStateNormal];
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
    AddNewAddressVC *ADD = [[AddNewAddressVC alloc]init];
    [self.navigationController pushViewController:ADD animated:YES];
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
