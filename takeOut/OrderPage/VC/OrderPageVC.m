//
//  OrderPageVC.m
//  takeOut
//
//  Created by mac on 2018/3/23.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "OrderPageVC.h"
#import "ZWMSegmentController.h"
#import "AllOrderVC.h"
#import "WillEvaluateVC.h"
#import "LoginByPhoneVC.h"
@interface OrderPageVC ()
@property (nonatomic , strong)UIView *naviView;
@property (nonatomic, strong) ZWMSegmentController *segmentVC;
@property (nonatomic , strong)UIButton *toLOginBtn;
@end

@implementation OrderPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
     self.view.backgroundColor = [UIColor whiteColor];
     [self createNaviView];

    [self CreateSegment];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:YES];

}
#pragma mark - ui
-(void)createNaviView{
    self.naviView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SafeAreaTopHeight )];
    self.naviView.backgroundColor = [UIColor colorWithHexString:BaseYellow];
    [self.view addSubview:self.naviView];
    
    __weak typeof(self) ws = self;
    UIImageView *backImg = [[UIImageView alloc]init];
    [self.naviView addSubview:backImg];
    [backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.naviView.mas_top).offset(SafeAreaStatsBarHeight + 5);
        make.left.equalTo(ws.naviView.mas_left).offset(15);
        make.width.equalTo(@(25));
        make.height.equalTo(@(30));
    }];
    
   
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = NSLocalizedString(@"订单", nil);
    titleLabel.textColor = [UIColor blackColor];
    [self.naviView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.centerY.equalTo(backImg);
    }];
}

- (void)CreateSegment{
    self.navigationController.navigationBar.translucent = NO;
    
    AllOrderVC *f = [[AllOrderVC alloc] init];
   
    WillEvaluateVC *s = [[WillEvaluateVC alloc] init];
   
    NSArray *array = @[f,s];
    
    self.segmentVC = [[ZWMSegmentController alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight , SCREEN_WIDTH, SCREENH_HEIGHT - SafeAreaTopHeight) titles:@[NSLocalizedString(@"全部订单", nil),NSLocalizedString(@"待评价", nil)]];
    self.segmentVC.segmentView.showSeparateLine = YES;
    
    self.segmentVC.segmentView.segmentTintColor = [UIColor blackColor];
    self.segmentVC.viewControllers = [array copy];
  
    
    self.segmentVC.segmentView.style=ZWMSegmentStyleFlush;
   
    [self addSegmentController:self.segmentVC];
    [self.segmentVC  setSelectedAtIndex:0];
}

-(void)toLogin{
LoginByPhoneVC *login = [[LoginByPhoneVC alloc]init];
    self.hidesBottomBarWhenPushed = YES;
[self.navigationController pushViewController:login animated:YES];

}
#pragma mark - 点击事件
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
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
