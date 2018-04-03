//
//  AddNewAddressVC.m
//  takeOut
//
//  Created by mac on 2018/4/3.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "AddNewAddressVC.h"
#import "LocationMapVC.h"

@interface AddNewAddressVC ()<UITextFieldDelegate>
@property (nonatomic , strong)UIView *naviView;
@property (nonatomic , strong)UITextField *userNameTextField;
@property (nonatomic , strong)UITextField *userPhoneNum;
@property (nonatomic , strong)UITextField *houseAdd;

@property (nonatomic , strong)UIImageView *manIcon;
@property (nonatomic , strong)UIImageView *womenIcon;
@property (nonatomic , strong)UIButton *manBtn;
@property (nonatomic , strong)UIButton *womanBtn;
@end

@implementation AddNewAddressVC{
    UILabel *tapToLoactionLabel;
    NSString *locationStr;
    NSString *userNameStr;
    NSString *userSexStr;
    NSString *userPhoneStr;
    NSString *userHouseNoStr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor colorWithHexString:@"E8E8E8"];
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
    titleLabel.text = NSLocalizedString(@"新增收货地址", nil);
    titleLabel.textColor = [UIColor blackColor];
    [self.naviView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.centerY.equalTo(backImg);
    }];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:NSLocalizedString(@"保存", nil) forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [self.naviView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backImg);
        make.right.equalTo(ws.naviView.mas_right).offset(-20);
    }];
}
-(void)setUpUI{
    __weak typeof(self) ws = self;
    UIView *topBackgroundView = [[UIView alloc]init];
    topBackgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topBackgroundView];
    [topBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(ws.view);
        make.centerX.equalTo(ws.view);
        make.top.equalTo(ws.naviView.mas_bottom).offset(10);
        make.height.equalTo(@(150));
    }];
   //收货人
    UILabel *userNameLabel = [[UILabel alloc]init];
    userNameLabel.text = NSLocalizedString(@"收货人", nil);
    userNameLabel.font = [UIFont systemFontOfSize:16];
    [topBackgroundView addSubview:userNameLabel];
    [userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topBackgroundView.mas_left).offset(20);
        make.centerY.equalTo(topBackgroundView.mas_top).offset(25);
        make.width.equalTo(@(SCREEN_WIDTH / 3 - 25));
    }];
    self.userNameTextField = [[UITextField alloc]init];
    self.userNameTextField.delegate = self;
     self.userNameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.userNameTextField addTarget:self action:@selector(UserTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [topBackgroundView addSubview:self.userNameTextField];
    [self.userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(SCREEN_WIDTH / 3));
        make.centerY.equalTo(userNameLabel);
        make.right.equalTo(topBackgroundView.mas_right).offset(-10);
        make.height.equalTo(@(45));
    }];
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(30, 50, SCREEN_WIDTH - 60, 0.5)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [topBackgroundView addSubview:line1];
//性别
    self.manIcon = [[UIImageView alloc]init];
    [self.manIcon setBackgroundColor:[UIColor blueColor]];
    [topBackgroundView addSubview:self.manIcon];
    [self.manIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topBackgroundView.mas_top).offset(75);
        make.left.equalTo(topBackgroundView.mas_left).offset(SCREEN_WIDTH / 3);
        make.width.equalTo(@(20));
        make.height.equalTo(@(20));
    }];
    
    UILabel *manStr = [[UILabel alloc]init];
    manStr.text = NSLocalizedString(@"先生", nil);
    manStr.font = [UIFont systemFontOfSize:14];
    [topBackgroundView addSubview:manStr];
    [manStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.manIcon);
        make.left.equalTo(ws.manIcon.mas_right).offset(15);
    }];
    self.manBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.manBtn addTarget:self action:@selector(chooseMan) forControlEvents:UIControlEventTouchUpInside];
    [topBackgroundView addSubview:self.manBtn];
    [self.manBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_manIcon);
        make.left.equalTo(_manIcon);
        make.right.equalTo(manStr);
        make.height.equalTo(@(50));
    }];
    
    self.womenIcon = [[UIImageView alloc]init];
    [self.womenIcon setBackgroundColor:[UIColor blackColor]];
    [topBackgroundView addSubview:self.womenIcon];
    [self.womenIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topBackgroundView.mas_top).offset(75);
        make.left.equalTo(manStr.mas_right).offset(30);
        make.width.equalTo(@(20));
        make.height.equalTo(@(20));
    }];
    
    UILabel *womanStr = [[UILabel alloc]init];
    womanStr.text = NSLocalizedString(@"女士", nil);
    womanStr.font = [UIFont systemFontOfSize:14];
    [topBackgroundView addSubview:womanStr];
    [womanStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.womenIcon);
        make.left.equalTo(ws.womenIcon.mas_right).offset(15);
    }];
    
    self.womanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.womanBtn addTarget:self action:@selector(chooseWoman) forControlEvents:UIControlEventTouchUpInside];
    [topBackgroundView addSubview:self.womanBtn];
    [self.womanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_womenIcon);
        make.left.equalTo(_womenIcon);
        make.right.equalTo(womanStr);
        make.height.equalTo(@(50));
    }];
    
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(30, 100, SCREEN_WIDTH - 60, 0.5)];
    line2.backgroundColor = [UIColor lightGrayColor];
    [topBackgroundView addSubview:line2];

//电话
    //收货人
    UILabel *userPhoneLabel = [[UILabel alloc]init];
    userPhoneLabel.text = NSLocalizedString(@"电话", nil);
    userPhoneLabel.font = [UIFont systemFontOfSize:16];
    [topBackgroundView addSubview:userPhoneLabel];
    [userPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topBackgroundView.mas_left).offset(20);
        make.centerY.equalTo(topBackgroundView.mas_top).offset(125);
        make.width.equalTo(@(SCREEN_WIDTH / 3 - 25));
    }];
    self.userPhoneNum = [[UITextField alloc]init];
    self.userPhoneNum.delegate = self;
    self.userPhoneNum.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.userPhoneNum addTarget:self action:@selector(PhoneTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [topBackgroundView addSubview:self.userPhoneNum];
    [self.userPhoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(SCREEN_WIDTH / 3));
        make.centerY.equalTo(userPhoneLabel);
        make.right.equalTo(topBackgroundView.mas_right).offset(-10);
        make.height.equalTo(@(45));
    }];
    
//下班部
    UIView *bottomBackgroundView = [[UIView alloc]init];
    bottomBackgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomBackgroundView];
    [bottomBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(ws.view);
        make.centerX.equalTo(ws.view);
        make.top.equalTo(topBackgroundView.mas_bottom).offset(20);
        make.height.equalTo(@(100));
    }];
    
    UILabel *addressLabel = [[UILabel alloc]init];
    addressLabel.text = NSLocalizedString(@"收货地址", nil);
    addressLabel.font = [UIFont systemFontOfSize:16];
    [bottomBackgroundView addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomBackgroundView.mas_left).offset(20);
        make.centerY.equalTo(bottomBackgroundView.mas_top).offset(25);
        make.width.equalTo(@(SCREEN_WIDTH / 3 - 25));
    }];
    
    UIImageView *locationIcon = [[UIImageView alloc]init];
    [locationIcon setImage:[UIImage imageNamed:@"ic_point"]];
    [bottomBackgroundView addSubview:locationIcon];
    [locationIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomBackgroundView.mas_left).offset(SCREEN_WIDTH /3);
        make.centerY.equalTo(addressLabel);
        make.width.equalTo(@(10));
        make.height.equalTo(@(15));
    }];
    
    tapToLoactionLabel = [[UILabel alloc]init];
    tapToLoactionLabel.font = [UIFont systemFontOfSize:16];
    tapToLoactionLabel.numberOfLines = 2;
    tapToLoactionLabel.text = NSLocalizedString(@"点击选择", nil);
    tapToLoactionLabel.textColor = [UIColor colorWithHexString:@"B5B5B5"];
    [bottomBackgroundView addSubview:tapToLoactionLabel];
    [tapToLoactionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(locationIcon.mas_right).offset(5);
        make.right.equalTo(bottomBackgroundView.mas_right).offset(-5);
        make.centerY.equalTo(addressLabel);
        make.height.equalTo(@(50));
    }];
 
    UILabel *houseNoLabel = [[UILabel alloc]init];
    houseNoLabel.text = NSLocalizedString(@"楼号/门牌号", nil);
    houseNoLabel.font = [UIFont systemFontOfSize:16];
    [bottomBackgroundView addSubview:houseNoLabel];
    [houseNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomBackgroundView.mas_left).offset(20);
        make.centerY.equalTo(bottomBackgroundView.mas_top).offset(75);
        make.width.equalTo(@(SCREEN_WIDTH / 3 - 25));
    }];
    self.houseAdd = [[UITextField alloc]init];
    self.houseAdd.delegate = self;
    self.houseAdd.placeholder = NSLocalizedString(@"例3号楼3001", nil);
    self.houseAdd.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.houseAdd addTarget:self action:@selector(houseTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [bottomBackgroundView addSubview:self.houseAdd];
    [self.houseAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(SCREEN_WIDTH / 3));
        make.centerY.equalTo(houseNoLabel);
        make.right.equalTo(bottomBackgroundView.mas_right).offset(-10);
        make.height.equalTo(@(45));
    }];
    
    UIButton *addNewADD = [UIButton buttonWithType:UIButtonTypeCustom];
    [addNewADD addTarget:self action:@selector(taptoLocation) forControlEvents:UIControlEventTouchUpInside];
    addNewADD.titleLabel.font = [UIFont systemFontOfSize:14];
    [bottomBackgroundView addSubview:addNewADD];
    [addNewADD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(locationIcon.mas_right).offset(5);
        make.right.equalTo(bottomBackgroundView.mas_right).offset(-5);
        make.centerY.equalTo(addressLabel);
        make.height.equalTo(@(50));
    }];
}
#pragma mark - 点击事件
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)save{
    if (locationStr == nil) {
        [MBManager showBriefAlert:NSLocalizedString(@"请获取地理位置", nil)];
    }else if (userNameStr == nil){
        [MBManager showBriefAlert:NSLocalizedString(@"请填写收货人姓名", nil)];
    }else if (userPhoneStr == nil){
        [MBManager showBriefAlert:NSLocalizedString(@"请填写收货人电话", nil)];
    }else if (userHouseNoStr == nil){
        [MBManager showBriefAlert:NSLocalizedString(@"请获填写具体位置", nil)];
    }else{
        
        
    }
}

#pragma mark - 监听textFile
-(void)UserTextFieldDidChange :(UITextField *)theTextField{
    
}
-(void)PhoneTextFieldDidChange :(UITextField *)theTextField{
    
}
-(void)houseTextFieldDidChange :(UITextField *)theTextField{
    
}

-(void)chooseMan{
    self.manIcon.backgroundColor = [UIColor blueColor];
    self.womenIcon.backgroundColor = [UIColor blackColor];
    
}
-(void)chooseWoman{
    self.manIcon.backgroundColor = [UIColor blackColor];
    self.womenIcon.backgroundColor = [UIColor redColor];
}

-(void)taptoLocation{
    LocationMapVC *mapVC = [[LocationMapVC alloc]init];
    mapVC.returnValueBlock = ^(NSString *strValue) {
        tapToLoactionLabel.text = strValue;
        tapToLoactionLabel.textColor = [UIColor blackColor];
        tapToLoactionLabel.textAlignment = NSTextAlignmentCenter;
        locationStr = strValue;
    };
    [self.navigationController pushViewController:mapVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
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
