//
//  ShopDetailMassageVC.m
//  takeOut
//
//  Created by mac on 2018/4/3.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "ShopDetailMassageVC.h"

@interface ShopDetailMassageVC ()
@property (nonatomic , strong) UIImageView *niveView;
@property (nonatomic , strong)UIImageView *shipIcon;
@property (nonatomic , strong)UILabel *shopName;
@property (nonatomic , strong)UILabel *shopMassageLabelLine1;
@property (nonatomic , strong)UILabel *shopMassageLabelLine2;
@property (nonatomic , strong)UILabel *shopMassageLabelLine3;
@property (nonatomic , strong)NSArray *saveListArr;
@property (nonatomic , strong)NSString *shopIcomURL;
@end

@implementation ShopDetailMassageVC{
    NSString *shopNameStr;
    NSString *shopSaveIconUrl;
    NSString *shopMassage1;
    NSString *shopMassage2;
    NSString *shopMassage3;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNaviView];
    // Do any additional setup after loading the view.
}
#pragma mark - ui
-(void)createNaviView{
    self.niveView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SafeAreaTopHeight + 195)];
    self.niveView.image = [UIImage imageNamed:@"bg_shangjiaxiangqing2"];
    [self.view addSubview:self.niveView];
    
    __weak typeof(self) ws = self;
    UIImageView *backImg = [[UIImageView alloc]init];
    [backImg setImage:[UIImage imageNamed:@"back_black"]];
    [self.niveView addSubview:backImg];
    [backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.niveView.mas_top).offset(SafeAreaStatsBarHeight + 5);
        make.left.equalTo(ws.niveView.mas_left).offset(15);
        make.width.equalTo(@(30));
        make.height.equalTo(@(30));
    }];
    
    UIButton *backBTN = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBTN addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBTN];
    [backBTN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.niveView.mas_top).offset(SafeAreaStatsBarHeight);
        make.left.equalTo(ws.niveView.mas_left).offset(10);
        make.width.equalTo(@(40));
        make.height.equalTo(@(SafeAreaTopHeight - SafeAreaStatsBarHeight));
    }];
    
    
    self.shipIcon = [[UIImageView alloc]init];
    [self.shipIcon sd_setImageWithURL:[NSURL URLWithString:self.shopIcomURL] placeholderImage:[UIImage imageNamed:@"logo"]];
    [self.niveView addSubview:self.shipIcon];
    [self.shipIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.niveView);
        make.top.equalTo(backBTN.mas_centerY);
        make.width.equalTo(@(75));
        make.height.equalTo(@(75));
    }];
    
    self.shopName = [[UILabel alloc]init];
    self.shopName.text = shopNameStr;
    self.shopName.textColor = [UIColor blackColor];
    [self.niveView addSubview:self.shopName];
    [self.shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.shipIcon);
        make.top.equalTo(ws.shipIcon.mas_bottom).offset(10);
    }];
    
    self.shopMassageLabelLine1 = [[UILabel alloc]init];
    self.shopMassageLabelLine1.text = shopMassage1;
    self.shopMassageLabelLine1.textColor = [UIColor blackColor];
    self.shopMassageLabelLine1.font = [UIFont systemFontOfSize:12];
    [self.niveView addSubview:self.shopMassageLabelLine1];
    [self.shopMassageLabelLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.niveView);
        make.top.equalTo(ws.shopName.mas_bottom).offset(20);
    }];
    self.shopMassageLabelLine2 = [[UILabel alloc]init];
    self.shopMassageLabelLine2.text = shopMassage2;
    self.shopMassageLabelLine2.textColor = [UIColor blackColor];
    self.shopMassageLabelLine2.font = [UIFont systemFontOfSize:12];
    [self.niveView addSubview:self.shopMassageLabelLine2];
    [self.shopMassageLabelLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.niveView);
        make.top.equalTo(ws.shopMassageLabelLine1.mas_bottom).offset(5);
    }];
    self.shopMassageLabelLine3 = [[UILabel alloc]init];
    self.shopMassageLabelLine3.text = shopMassage3;
    self.shopMassageLabelLine3.textColor = [UIColor blackColor];
    self.shopMassageLabelLine3.font = [UIFont systemFontOfSize:12];
    [self.niveView addSubview:self.shopMassageLabelLine3];
    [self.shopMassageLabelLine3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.niveView);
        make.top.equalTo(ws.shopMassageLabelLine2.mas_bottom).offset(5);
    }];
    
    
    if (self.saveListArr.count != 0) {
        for (int i = 0 ; i < self.saveListArr.count; i++) {
            UIImageView *saveIcon = [[UIImageView alloc]initWithFrame:CGRectMake(60, SafeAreaTopHeight + 195+10 + i * 30, 20, 20)];
            NSString *shopSaveStr = [NSString stringWithFormat:@"%@/%@",BASEURL,self.saveListArr[i][@"img"]];
            [saveIcon sd_setImageWithURL:[NSURL URLWithString:shopSaveStr]];
            saveIcon.backgroundColor = [UIColor orangeColor];
            [self.view addSubview:saveIcon];
            
            UILabel *saveLabel = [[UILabel alloc]initWithFrame:CGRectMake(85, SafeAreaTopHeight + 195+ 10 + i * 30, SCREEN_WIDTH - 85 - 30, 20)];
            saveLabel.font = [UIFont systemFontOfSize:14];
         
            NSString *savr1Str =[NSString stringWithFormat:@"%@",self.saveListArr[i][@"content"]];
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
            
            [self.view addSubview:saveLabel];
            
        }
    }
}
-(void)setModShopList:(ModelForShopList *)modShopList{
    shopNameStr = modShopList.store_name;
    NSString *send_pay =[NSString stringWithFormat:@"%@฿",modShopList.send_pic];
    NSString *send_Start = [NSString stringWithFormat:@"%@฿",modShopList.up_pic];
    NSString *yueShou = [NSString stringWithFormat:@"👍%@",modShopList.per_mean];
    NSString *time = modShopList.opentime;
    NSString *noti = modShopList.notice;
    if (noti == NULL ) {
        noti = @"";
    }
    self.shopIcomURL = modShopList.store_img;
    shopMassage1 = [NSString stringWithFormat:@"%@：%@ | %@：%@ | %@%@",ZBLocalized(@"配送", nil),send_pay,ZBLocalized(@"起送", nil),send_Start,yueShou,ZBLocalized(@"份", nil)];
    shopMassage2 = [NSString stringWithFormat:@"%@：%@",ZBLocalized(@"配送时间", nil),time];
    shopMassage3 = [NSString stringWithFormat:@"%@：%@",ZBLocalized(@"商家公告", nil),noti];
    if (modShopList.act_list.count != 0) {
        self.saveListArr = modShopList.act_list;
    }
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
