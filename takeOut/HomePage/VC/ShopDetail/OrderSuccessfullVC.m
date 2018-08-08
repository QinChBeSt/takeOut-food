//
//  OrderSuccessfullVC.m
//  takeOut
//
//  Created by mac on 2018/4/8.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "OrderSuccessfullVC.h"
#import "ShopDetailVC.h"
@interface OrderSuccessfullVC ()
@property (nonatomic , strong)UIView *naviView;
@property (nonatomic , strong)UILabel *sussLab;
@end

@implementation OrderSuccessfullVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = [UIColor colorWithHexString:@"E8E8E8"];
    [self createNaviView];
    [self setUpUI];
    // Do any additional setup after loading the view.
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
    titleLabel.text = ZBLocalized(@"提交订单成功", nil);
    titleLabel.textColor = [UIColor blackColor];
    [self.naviView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.centerY.equalTo(backImg);
    }];
    
  
   
}
-(void)setUpUI{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREENH_HEIGHT / 5 * 2)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    UILabel *center = [[UILabel alloc]init];
    center.text = ZBLocalized(@"感谢您的支持，欢迎下次光临", nil);
    [backView addSubview:center];
    [center mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(backView);
    }];
    UILabel *fin = [[UILabel alloc]init];
    fin.text = ZBLocalized(@"等待商家接单", nil);
    [backView addSubview:fin];
    [fin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(center.mas_top).offset(-20);
    }];
    
    self.sussLab = [[UILabel alloc]init];
    //fin.text = ZBLocalized(@"等待商家接单", nil);
    [backView addSubview:self.sussLab];
    [self.sussLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(center.mas_bottom).offset(20);
    }];
    
    
    __block int timeout=10; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            //dispatch_release(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self back];
            });
        }else{
            //int minutes = timeout / 60;
            int seconds = timeout % 60;
            
            NSString *language=[[ZBLocalized sharedInstance]currentLanguage];
            NSLog(@"切换后的语言:%@",language);
            
            NSString *strTime;
            if ([language isEqualToString:@"th"]) {
                strTime = [NSString stringWithFormat:@"ย้อนกลับใน%d%@", seconds,ZBLocalized(@"秒后返回", nil)];
            }else{
                strTime = [NSString stringWithFormat:@"%d%@", seconds,ZBLocalized(@"秒后返回", nil)];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                self.sussLab.text =strTime;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

-(void)DownTime{
    
    
}
#pragma mark - 点击事件
-(void)back{
    NSArray *vcArray = self.navigationController.viewControllers;
    
    
    for(UIViewController *vc in vcArray)
    {
        if ([vc isKindOfClass:[ShopDetailVC class]])
        {
            [self.navigationController popToViewController:vc animated:YES];
        }
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
