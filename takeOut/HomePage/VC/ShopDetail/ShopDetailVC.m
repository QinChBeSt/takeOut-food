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
@property (nonatomic , strong) UIImageView *niveView;
@property (nonatomic, strong) ZWMSegmentController *segmentVC;
@property (nonatomic , copy) NSString *shopId;
@property (nonatomic , copy) NSString *shopUpPayMoney;
@property (nonatomic , strong)NSArray *saveListArr;
@property (nonatomic , strong)UIImageView *shipIcon;
@property (nonatomic , strong)UILabel *shopName;
@property (nonatomic , strong)UILabel *shopNotiLab;
@property (nonatomic , strong)UILabel *shopSaveLabel;
@property (nonatomic , strong)UIImageView *shopSaveImg;
@property (nonatomic , strong)UILabel *shopSaveNumLabel;
@property (nonatomic , strong)ModelForShopList *toNextMod;
@property (nonatomic , strong)NSString *shopIcomURL;
@property (nonatomic , strong)NSString *shopACType;
@property (nonatomic , strong)NSString *shopNotiStr;
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
    self.niveView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SafeAreaTopHeight + kWidthScale(250))];
    self.niveView.image =[UIImage imageNamed:@"bg_shangjiaxiangqing2"];
    self.niveView.backgroundColor = [UIColor colorWithHexString:@"737300"];
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
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = ZBLocalized(@"商家详情", nil);
    titleLabel.textColor = [UIColor blackColor];
    [self.niveView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.centerY.equalTo(backImg);
    }];
    
    self.shipIcon = [[UIImageView alloc]init];
    [self.shipIcon sd_setImageWithURL:[NSURL URLWithString:self.shopIcomURL] placeholderImage:[UIImage imageNamed:@"logo"]];
    [self.niveView addSubview:self.shipIcon];
    [self.shipIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.niveView.mas_left).offset(kWidthScale(18));
        make.bottom.equalTo(ws.niveView.mas_bottom).offset(-(kWidthScale(250) - 40) / 2);
        make.width.equalTo(@(kWidthScale(155)));
        make.height.equalTo(@(kWidthScale(155)));
    }];
    
    self.shopName = [[UILabel alloc]init];
    self.shopName.text = shopNameStr;
    self.shopName.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    self.shopName.textColor = [UIColor blackColor];
    [self.niveView addSubview:self.shopName];
    [self.shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.shipIcon.mas_right).offset(kWidthScale(18));
        make.top.equalTo(ws.shipIcon).offset(-2) ;
         make.right.equalTo(ws.niveView.mas_right).offset(-kWidthScale(18));
    }];
    
    UIImageView *shopNotiImg = [[UIImageView alloc]init];
    [shopNotiImg setImage:[UIImage imageNamed:@"shopNoti"]];
    [self.niveView addSubview:shopNotiImg];
    [shopNotiImg mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(ws.shipIcon.mas_right).offset(kWidthScale(18));
        make.centerY.equalTo(ws.shipIcon);
        make.width.equalTo(@(kWidthScale(30)));
        make.height.equalTo(@(kWidthScale(30)));
    }];
    
    self.shopNotiLab = [[UILabel alloc]init];
    if ([self isBlankString:self.shopNotiStr]) {
        self.shopNotiStr = @"";
    }
    self.shopNotiLab.text = [NSString stringWithFormat:@"%@:%@",ZBLocalized(@"公告", nil),self.shopNotiStr];
    
    self.shopNotiLab.font = [UIFont systemFontOfSize:14];
    self.shopNotiLab.textColor = [UIColor blackColor];
    [self.niveView addSubview:self.shopNotiLab];
    [self.shopNotiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(shopNotiImg.mas_right).offset(kWidthScale(5));
        make.centerY.equalTo(ws.shipIcon) ;
        make.right.equalTo(ws.niveView.mas_right).offset(-kWidthScale(18));
    }];
    
    self.shopSaveImg = [[UIImageView alloc]init];
    [self.shopSaveImg sd_setImageWithURL:[NSURL URLWithString:shopSaveIconUrl]];
    [self.niveView addSubview:self.shopSaveImg];
    [self.shopSaveImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.shopName);
        make.bottom.equalTo(ws.shipIcon.mas_bottom).offset(0);
        make.width.equalTo(@(41));
        make.height.equalTo(@(15));
    }];
   
    
    UIImageView *rightIcon = [[UIImageView alloc]init];
    [rightIcon setImage:[UIImage imageNamed:@"右箭头黑"]];
    [self.niveView addSubview:rightIcon];
    [rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.niveView.mas_right).offset(-10);
        make.centerY.equalTo(ws.shopSaveImg);
        make.width.equalTo(@(8));
        make.height.equalTo(@(12));
    }];
    
    
    self.shopSaveNumLabel = [[UILabel alloc]init];
    self.shopSaveNumLabel.font = [UIFont systemFontOfSize:12];
    self.shopSaveNumLabel.textColor = [UIColor blackColor];
    self.shopSaveNumLabel.text = numForSaveCount;
    [self.niveView addSubview:self.shopSaveNumLabel];
    [self.shopSaveNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_shopSaveImg);
        make.right.equalTo(rightIcon.mas_left).offset(-5);
    }];
    
    self.shopSaveLabel = [[UILabel alloc]init];
    self.shopSaveLabel.font = [UIFont systemFontOfSize:12];
    self.shopSaveLabel.textColor = [UIColor blackColor];
    self.shopSaveLabel.text = shopSaveStr;
    [self.niveView addSubview:self.shopSaveLabel];
    [self.shopSaveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_shopSaveImg);
        make.left.equalTo(ws.shopSaveImg.mas_right).offset(5);
        make.right.equalTo(ws.shopSaveNumLabel.mas_left).offset(-5);
    }];
    UIButton *toDetailVC = [UIButton buttonWithType:UIButtonTypeCustom];
    [toDetailVC addTarget:self action:@selector(toDetail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:toDetailVC];
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
    f.acTypeStr = self.shopACType;
    EvaluationVC *s = [[EvaluationVC alloc] init];
    s.shopId = self.shopId;
    ShopMassageVC *f1 = [[ShopMassageVC alloc] init];
    f1.shopId = self.shopId;
    f1.saveArr = self.saveListArr;
    NSArray *array = @[f,s,f1];
    
    self.segmentVC = [[ZWMSegmentController alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight + 100, SCREEN_WIDTH, SCREENH_HEIGHT - SafeAreaTopHeight -100) titles:@[ZBLocalized(@"点菜", nil),ZBLocalized(@"评价", nil),ZBLocalized(@"商家", nil)]];
    self.segmentVC.segmentView.showSeparateLine = YES;
    self.segmentVC.segmentView.segmentTintColor = [UIColor blackColor];
    self.segmentVC.segmentView.segmentNormalColor = [UIColor colorWithHexString:@"696969"];
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
    self.shopIcomURL = modShopList.store_img;
    self.shopNotiStr = modShopList.notice;
    shopNameStr = modShopList.store_name;
    self.shopACType = modShopList.acTypeStr;
    if (modShopList.act_list.count != 0) {
        self.saveListArr = modShopList.act_list;
        numForSaveCount = [NSString stringWithFormat:@"%lu%@",(unsigned long)self.saveListArr.count,ZBLocalized(@"个活动", nil)];
         NSString *imgUrl =  self.saveListArr[0][@"img"];
        NSString *language=[[ZBLocalized sharedInstance]currentLanguage];
        NSLog(@"切换后的语言:%@",language);
        NSString *lauStr;
        if ([language isEqualToString:@"th"]) {
            lauStr = @"th";
        }
        else if ([language isEqualToString:@"en"]){
            lauStr = @"en";
        }
        else if ([language isEqualToString:@"zh-Hans"]){
            lauStr = @"zh";
        }
         shopSaveIconUrl =[NSString stringWithFormat:@"%@/%@/%@",IMGsaveBaesURL,lauStr,imgUrl] ;
        int count = 0;
        
        NSMutableDictionary *dic = self.saveListArr[0];
        
        NSString *savr1Str =dic[@"content"];
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
        
        
        if ([language isEqualToString:@"th"]) {
            shopSaveStr =THSave1Str;
        }
        else if ([language isEqualToString:@"zh-Hans"]) {
            shopSaveStr = CHSave1Str;
        }
        else if ([language isEqualToString:@"en"]) {
            shopSaveStr = ENSave1Str;
        }
        
//        for (NSMutableDictionary *dic in self.saveListArr) {
//
//            if (shopSaveStr == nil) {
//                shopSaveStr = dic[@"content"];
//            }else{
//                if (count < 2) {
//                     shopSaveStr = [NSString stringWithFormat:@"%@,%@",shopSaveStr,dic[@"content"]];
//                }
//
//           }
//            count++;
//        }
    }
    
}

-(BOOL) isBlankString:(NSString *)string{
    NSString *str = [NSString stringWithFormat:@"%@",string];
    
    if ([str isEqualToString:@""]) {
        return YES;
    }
    
    if ([str isEqualToString:@"<null>"]) {
        return YES;
    }
    
    if ([str isEqualToString:@"(null)"]) {
        return YES;
    }
    
    if ([str isEqualToString:@"<nil>"]) {
        return YES;
    }
    
    if (str == nil || str == NULL) {
        return YES;
    }
    
    if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([str isEqual:[NSNull null]]) {
        return YES;
    }
    
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    
    
    return NO;
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
