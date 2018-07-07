//
//  AboutusVC.m
//  takeOut
//
//  Created by mac on 2018/4/11.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "AboutusVC.h"
#import "YSZCvc.h"

@interface AboutusVC ()
@property (nonatomic , strong)UIView *naviView;
@end

@implementation AboutusVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNaviView];
    [self setupUI];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
//[self.tabBarController.tabBar setHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
   // [self.tabBarController.tabBar setHidden:NO];
}
-(void)createNaviView{
    self.view.backgroundColor = [UIColor colorWithHexString:BaseBackgroundGray];
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
    titleLabel.text = ZBLocalized(@"关于我们", nil);
    titleLabel.textColor = [UIColor blackColor];
    [self.naviView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.centerY.equalTo(backImg);
    }];
    
    UILabel *copmName = [[UILabel alloc]init];
    copmName.textColor = [UIColor colorWithHexString:BaseTextGrayColor];
    copmName.text = @"Manjit management Co,. Ltd";
    [self.view addSubview:copmName];
    [copmName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.bottom.equalTo(ws.view.mas_bottom).offset(-SafeAreaTabbarHeight - 20);
    }];
}
-(void)setupUI{
    __weak typeof(self) ws = self;
    UIImageView *ICON = [[UIImageView alloc]init];
    [self.view addSubview:ICON];
    [ICON setImage:[UIImage imageNamed:@"AppIcon"]];
    [ICON mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.top.equalTo(ws.naviView.mas_bottom).offset(40);
        make.width.and.height.equalTo(@(50));
    }];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    UILabel *vison = [[UILabel alloc]init];
    [self.view addSubview:vison];
    vison.text = [NSString stringWithFormat:@"%@v%@",ZBLocalized(@"当前版本：", nil),app_build];
    vison.textColor = [UIColor colorWithHexString:BaseTextGrayColor];
    [vison mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.top.equalTo(ICON.mas_bottom).offset(10);
    }];
    
    UIView *yszcView = [[UIView alloc]init];
    yszcView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:yszcView];
    [yszcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.centerY.equalTo(ws.view);
        make.width.equalTo(ws.view);
        make.height.equalTo(@(50));
    }];
    UILabel *yszcLab = [[UILabel alloc]init];
    yszcLab.text = ZBLocalized(@"隐私政策", nil);
    yszcLab.textColor = [UIColor colorWithHexString:BaseTextGrayColor];
    yszcLab.font = [UIFont systemFontOfSize:15];
    [yszcView addSubview:yszcLab];
    [yszcLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yszcView.mas_left).offset(20);
        make.centerY.equalTo(yszcView);
    }];
    
    UIButton *toYszc = [UIButton buttonWithType:UIButtonTypeCustom];
    [toYszc addTarget:self action:@selector(toYszcAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:toYszc];
    [toYszc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.and.centerY.equalTo(ws.view);
        make.width.equalTo(ws.view);
        make.height.equalTo(@(50));
    }];
//    UILabel *text = [[UILabel alloc]init];
//    text.font = [UIFont systemFontOfSize:14];
//
//    text.numberOfLines = 0;
//    text.text = ZBLocalized(@"Beeorder, 目前领先的餐饮供应电商平台! F2B模式, 工厂直接报价给商家,去掉中间环节, 终端市场建仓配送直达餐厅。上百种产品厂家直供, 商家无忧买到性价比超高的优质产品, 并享受到专业的客户服务。不需要再起早贪黑跑菜市场、跑批发部, 不需要再货比三家讨价还价。无论是在店里还是在家里、旅途你都能随时随地为您的餐厅下单采购！Beeorder, 餐厅老板的信赖之选, 让天下餐厅没有难做的生意。", nil) ;
//    [self.view addSubview:text];
//    [text mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(ws.view);
//        make.left.equalTo(ws.view.mas_left).offset(30);
//        make.top.equalTo(vison.mas_bottom).offset(20);
//    }];
}
#pragma mark - 点击事件
-(void)toYszcAction{
    YSZCvc *yszc = [[YSZCvc alloc]init];
    yszc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:yszc animated:YES];
}
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
