//
//  NewAddVC.m
//  takeOut
//
//  Created by mac on 2018/6/28.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "NewAddVC.h"
#import "LocationMapVC.h"
#import "NewLoginByPhoneVC.h"
#import <IQKeyboardReturnKeyHandler.h>
#import <IQKeyboardManager.h>
@interface NewAddVC ()<UITextFieldDelegate,UITextViewDelegate>
@property (nonatomic , strong)UIView *naviView;
@property (nonatomic , strong)UITextField *userNameTextField;
@property (nonatomic , strong)UITextField *userPhoneNum;
@property (nonatomic , strong)UITextView *houseAdd;

@property (nonatomic , strong)UIImageView *manIcon;
@property (nonatomic , strong)UIImageView *womenIcon;
@property (nonatomic , strong)UIButton *manBtn;
@property (nonatomic , strong)UIButton *womanBtn;
@property (nonatomic , strong)UILabel *tapToLoactionLabel;
@property (nonatomic , strong)UILabel *textViewPlaLab;
@end

@implementation NewAddVC{
     IQKeyboardReturnKeyHandler * _returnKeyHander;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    _returnKeyHander = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
//    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self createNaviView];
    [self setUpUI];
}
#pragma mark - ui
-(void)createNaviView{
    self.view.backgroundColor = [UIColor whiteColor];
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
    if (_naviTitle == nil) {
        titleLabel.text = ZBLocalized(@"新增收货地址", nil);
    }
    else{
        titleLabel.text = _naviTitle;
    }
    titleLabel.textColor = [UIColor blackColor];
    [self.naviView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.centerY.equalTo(backImg);
    }];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:ZBLocalized(@"保存", nil) forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(saveToChoose) forControlEvents:UIControlEventTouchUpInside];
    [self.naviView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backImg);
        make.right.equalTo(ws.naviView.mas_right).offset(-20);
    }];
}
-(void)setUpUI{
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, 10)];
    topLine.backgroundColor = [UIColor colorWithHexString:BaseBackgroundGray];
    [self.view addSubview:topLine];
    
    __weak typeof(self) ws = self;
    //收货人
    UILabel *userNameLabel = [[UILabel alloc]init];
    userNameLabel.text = ZBLocalized(@"收货人", nil);
    userNameLabel.textColor = [UIColor colorWithHexString:@"4b4b4b"];
    userNameLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:userNameLabel];
    [userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.view.mas_left).offset(20);
        make.centerY.equalTo(topLine.mas_bottom).offset(25);
        make.width.equalTo(@(SCREEN_WIDTH / 3 - 25));
    }];
    
    self.userNameTextField = [[UITextField alloc]init];
    self.userNameTextField.delegate = self;
    if (_userNameStr != nil) {
        self.userNameTextField.text = _userNameStr;
    }
    self.userNameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.userNameTextField addTarget:self action:@selector(UserTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.userNameTextField];
    self.userNameTextField.textColor = [UIColor colorWithHexString:@"4b4b4b"];
    [self.userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(SCREEN_WIDTH / 3));
        make.centerY.equalTo(userNameLabel);
        make.right.equalTo(ws.view.mas_right).offset(-10);
        make.height.equalTo(@(45));
    }];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(30, 50 + SafeAreaTopHeight + 10, SCREEN_WIDTH - 60, 0.5)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line1];
    
    self.manIcon = [[UIImageView alloc]init];
    self.manIcon.image = [UIImage imageNamed:@"icon_nanxingdown"];
    [self.view addSubview:self.manIcon];
    [self.manIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topLine.mas_bottom).offset(75);
        make.left.equalTo(self.view.mas_left).offset(SCREEN_WIDTH / 3);
        make.width.equalTo(@(20));
        make.height.equalTo(@(20));
    }];
    UILabel *manStr = [[UILabel alloc]init];
    manStr.text = ZBLocalized(@"先生", nil);
    manStr.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:manStr];
    [manStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.manIcon);
        make.left.equalTo(ws.manIcon.mas_right).offset(15);
    }];
    self.manBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.manBtn addTarget:self action:@selector(chooseMan) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.manBtn];
    [self.manBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_manIcon);
        make.left.equalTo(_manIcon);
        make.right.equalTo(manStr);
        make.height.equalTo(@(50));
    }];
    
    
    self.womenIcon = [[UIImageView alloc]init];
    [self.womenIcon setImage:[UIImage imageNamed:@"icon_nvxing"]];
    [self.view addSubview:self.womenIcon];
    [self.womenIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(topLine.mas_bottom).offset(75);
        make.left.equalTo(manStr.mas_right).offset(30);
        make.width.equalTo(@(20));
        make.height.equalTo(@(20));
    }];
    
    UILabel *womanStr = [[UILabel alloc]init];
    womanStr.text = ZBLocalized(@"女士", nil);
    womanStr.numberOfLines = 2;
    womanStr.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:womanStr];
    [womanStr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.womenIcon);
        make.left.equalTo(ws.womenIcon.mas_right).offset(15);
        make.right.equalTo(ws.view).offset(-5);
    }];
    
    self.womanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.womanBtn addTarget:self action:@selector(chooseWoman) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.womanBtn];
    [self.womanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_womenIcon);
        make.left.equalTo(_womenIcon);
        make.right.equalTo(womanStr);
        make.height.equalTo(@(50));
    }];
    
    if (_userSex != nil) {
        NSString *sex = [NSString stringWithFormat:@"%@",_userSex];
        if (![sex isEqualToString:@"1"]) {
            self.manIcon.image = [UIImage imageNamed:@"icon_nanxing"];
            
            [self.womenIcon setImage:[UIImage imageNamed:@"icon_nvxingdown"]];
            _userSex = @"2";
        }
    }
    
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(30, 100 + 10 + SafeAreaTopHeight, SCREEN_WIDTH - 60, 0.5)];
    line2.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:line2];
    
    //电话
    //收货人
    UILabel *userPhoneLabel = [[UILabel alloc]init];
    userPhoneLabel.text = ZBLocalized(@"电话", nil);
    userPhoneLabel.textColor = [UIColor colorWithHexString:@"4b4b4b"];
    userPhoneLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:userPhoneLabel];
    [userPhoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(20);
        make.centerY.equalTo(topLine.mas_bottom).offset(125);
        make.width.equalTo(@(SCREEN_WIDTH / 3 - 25));
    }];
    
    self.userPhoneNum = [[UITextField alloc]init];
    self.userPhoneNum.textColor = [UIColor colorWithHexString:@"4b4b4b"];
    self.userPhoneNum.delegate = self;
    self.userPhoneNum.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.userPhoneNum.keyboardType = UIKeyboardTypeNumberPad;
    [self.userPhoneNum addTarget:self action:@selector(PhoneTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.userPhoneNum];
    [self.userPhoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(SCREEN_WIDTH / 3));
        make.centerY.equalTo(userPhoneLabel);
        make.right.equalTo(self.view.mas_right).offset(-10);
        make.height.equalTo(@(45));
    }];
    if (_userPhoneStr != nil) {
        self.userPhoneNum.text =[NSString stringWithFormat:@"%@",_userPhoneStr];
    }
    
    UIView *midLine = [[UIView alloc]init];
    midLine.backgroundColor = [UIColor colorWithHexString:BaseBackgroundGray];
    [self.view addSubview:midLine];
    [midLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(ws.view);
        make.centerX.equalTo(ws.view);
        make.top.equalTo(topLine.mas_bottom).offset(150);
        make.height.equalTo(@(20));
    }];
    
    UILabel *addressLabel = [[UILabel alloc]init];
    addressLabel.textColor = [UIColor colorWithHexString:@"4b4b4b"];
    addressLabel.text = ZBLocalized(@"收货地址", nil);
    addressLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.view.mas_left).offset(20);
        make.centerY.equalTo(midLine.mas_bottom).offset(25);
        make.width.equalTo(@(SCREEN_WIDTH / 3 - 25));
    }];
    UIImageView *locationIcon = [[UIImageView alloc]init];
    
    [locationIcon setImage:[UIImage imageNamed:@"ic_point"]];
    [self.view addSubview:locationIcon];
    [locationIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.view.mas_left).offset(SCREEN_WIDTH /3);
        make.centerY.equalTo(addressLabel);
        make.width.equalTo(@(10));
        make.height.equalTo(@(15));
    }];
    
    self.tapToLoactionLabel = [[UILabel alloc]init];
    self.tapToLoactionLabel.textColor = [UIColor colorWithHexString:@"4b4b4b"];
    self.tapToLoactionLabel.font = [UIFont systemFontOfSize:16];
    self.tapToLoactionLabel.numberOfLines = 2;
    self.tapToLoactionLabel.text = ZBLocalized(@"点击选择", nil);
    self.tapToLoactionLabel.textColor = [UIColor colorWithHexString:@"B5B5B5"];
    [self.view addSubview:self.tapToLoactionLabel];
    [self.tapToLoactionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(locationIcon.mas_right).offset(5);
        make.right.equalTo(ws.view.mas_right).offset(-5);
        make.centerY.equalTo(addressLabel);
        make.height.equalTo(@(50));
    }];
    
    if (_locationStr != nil) {
        self.tapToLoactionLabel.text = _locationStr;
        self.tapToLoactionLabel.textColor = [UIColor colorWithHexString:@"4b4b4b"];
        self.tapToLoactionLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    UILabel *houseNoLabel = [[UILabel alloc]init];
    houseNoLabel.textColor = [UIColor colorWithHexString:@"4b4b4b"];
    houseNoLabel.text = ZBLocalized(@"楼号/门牌号", nil);
    houseNoLabel.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:houseNoLabel];
    [houseNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.view.mas_left).offset(20);
        make.centerY.equalTo(midLine.mas_bottom).offset(75);
        make.width.equalTo(@(SCREEN_WIDTH / 3 - 25));
    }];
    
    
    self.textViewPlaLab = [[UILabel alloc]init];
    self.textViewPlaLab.text =ZBLocalized(@"例3号楼3001", nil);
    self.textViewPlaLab.font = [UIFont systemFontOfSize:14];
    self.textViewPlaLab.textColor = [UIColor colorWithHexString:@"B5B5B5"];
    [self.view addSubview:self.textViewPlaLab];
    [self.textViewPlaLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(SCREEN_WIDTH / 3 + 10));
        make.centerY.equalTo(houseNoLabel) ;
        make.right.equalTo(ws.view.mas_right).offset(-10);
        make.height.equalTo(@(45));
    }];
    self.houseAdd = [[UITextView alloc]init];
   
    self.houseAdd.textColor = [UIColor colorWithHexString:@"4b4b4b"];
    self.houseAdd.backgroundColor = [UIColor clearColor];

    self.houseAdd.font = [UIFont systemFontOfSize:14];
    
    self.houseAdd.delegate = self;
    [self.view addSubview:self.houseAdd];
    [self.houseAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(SCREEN_WIDTH / 3));
        make.top.equalTo(houseNoLabel).offset(-6) ;
        make.right.equalTo(ws.view.mas_right).offset(-10);
        make.height.equalTo(@(90));
    }];
    
    if (_userHouseNoStr != nil) {
        self.houseAdd.text =_userHouseNoStr;
        self.textViewPlaLab.hidden = YES;
    }
    
    UIButton *addNewADD = [UIButton buttonWithType:UIButtonTypeCustom];
    [addNewADD addTarget:self action:@selector(taptoLocation) forControlEvents:UIControlEventTouchUpInside];
    addNewADD.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:addNewADD];
    [addNewADD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(locationIcon.mas_right).offset(5);
        make.right.equalTo(ws.view.mas_right).offset(-5);
        make.centerY.equalTo(addressLabel);
        make.height.equalTo(@(50));
    }];
    UIView *buttomLine = [[UIView alloc]init];
    buttomLine.backgroundColor = [UIColor colorWithHexString:BaseBackgroundGray];
    [self.view addSubview:buttomLine];
    [buttomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.view.mas_left).offset(0);
        make.top.equalTo(ws.houseAdd.mas_bottom).offset(0);
        make.bottom.equalTo(ws.view);
        make.width.equalTo(@(SCREEN_WIDTH));
        
    }];
    
}
#pragma mark - 点击事件
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)saveToChoose{
    if (_addressId != nil) {
        [self edit];
    }else{
        [self save];
    }
}
-(void)edit{
    if (_locationStr == nil) {
        [MBManager showBriefAlert:ZBLocalized(@"请获取地理位置", nil)];
    }else if (_userNameTextField.text.length == 0){
        [MBManager showBriefAlert:ZBLocalized(@"请填写收货人姓名", nil)];
    }else if (_userPhoneNum.text.length == 0){
        [MBManager showBriefAlert:ZBLocalized(@"请填写收货人电话", nil)];
    }else if (_userPhoneNum.text.length < 9){
        [MBManager showBriefAlert:ZBLocalized(@"手机号应该为9~11位数字", nil)];
    }else if (_userPhoneNum.text.length > 11){
        [MBManager showBriefAlert:ZBLocalized(@"手机号应该为9~11位数字", nil)];
    }
    else if (_houseAdd.text.length == 0){
        [MBManager showBriefAlert:ZBLocalized(@"请获填写具体位置", nil)];
    }else{
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *userid = [defaults objectForKey:UD_USERID];
        if (userid == nil) {
            NewLoginByPhoneVC *login = [[NewLoginByPhoneVC alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }else{
            NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,editAddressURL];
            NSDictionary *parameters = @{@"addrid":_addressId,
                                         @"uname":_userNameStr,
                                         @"sex":_userSex,
                                         @"phone":_userPhoneStr,
                                         @"addr":_locationStr,
                                         @"addrtext":_userHouseNoStr,
                                         @"lat":_getLat,
                                         @"lonng":_getLong
                                         };
            AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
            //请求的方式：POST
            [managers POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSString *code =[NSString stringWithFormat:@"%@",responseObject[@"code"]];
                if ([code isEqualToString:@"1"]) {
                    [MBManager showBriefAlert:ZBLocalized(@"地址修改成功", nil)];
                    [self performSelector:@selector(back) withObject:nil/*可传任意类型参数*/ afterDelay:2.0];
                }
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [MBManager showBriefAlert:ZBLocalized(@"地址修改失败", nil)];
            }];
        }
        
    }
}
-(void)save{
    if (_locationStr == nil) {
        [MBManager showBriefAlert:ZBLocalized(@"请获取地理位置", nil)];
    }else if (_userNameTextField.text.length == 0){
        [MBManager showBriefAlert:ZBLocalized(@"请填写收货人姓名", nil)];
    }else if (_userPhoneNum.text.length == 0){
        [MBManager showBriefAlert:ZBLocalized(@"请填写收货人电话", nil)];
    }else if (_houseAdd.text.length == 0){
        [MBManager showBriefAlert:ZBLocalized(@"请获填写具体位置", nil)];
    }else if([[_userNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length]==0) {
        [MBManager showBriefAlert:ZBLocalized(@"请填写收货人姓名", nil)];
        return;
    }else if ([[_userPhoneNum.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length]==0){
        [MBManager showBriefAlert:ZBLocalized(@"请填写收货人电话", nil)];
        return;
    }
    
    else{
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *userid = [defaults objectForKey:UD_USERID];
        if (userid == nil) {
            NewLoginByPhoneVC *login = [[NewLoginByPhoneVC alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        } else{
            if(_userSex == nil){
                _userSex = @"1";
            }
            NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,addAddressUrl];
            NSDictionary *parameters = @{@"uid":userid,
                                         @"uname":_userNameStr,
                                         @"sex":_userSex,
                                         @"phone":_userPhoneStr,
                                         @"addr":_locationStr,
                                         @"addrtext":_userHouseNoStr,
                                         @"lat":_getLat,
                                         @"lonng":_getLong
                                         };
            AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
            //请求的方式：POST
            [managers POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSString *code =[NSString stringWithFormat:@"%@",responseObject[@"code"]];
                if ([code isEqualToString:@"1"]) {
                    [MBManager showBriefAlert:ZBLocalized(@"地址添加成功", nil)];
                    [self performSelector:@selector(back) withObject:nil/*可传任意类型参数*/ afterDelay:2.0];
                }
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [MBManager showBriefAlert:ZBLocalized(@"地址添加失败", nil)];
            }];
        }
        
    }
}
-(void)houseTextFieldDidChange :(UITextField *)theTextField{
    _userHouseNoStr = theTextField.text;
}
-(void)textViewDidChange:(UITextView *)textView{
    if (textView== self.houseAdd) {
         _userHouseNoStr = textView.text;
    }
 
}
-(void)textViewDidBeginEditing:(UITextView *)textView{
     if (textView == self.houseAdd) {
    self.textViewPlaLab.hidden = YES;
     }
}
-(void)textViewDidEndEditing:(UITextView *)textView
{if (textView == self.houseAdd) {
    if (textView.text.length == 0) {
        self.textViewPlaLab.hidden = NO;
    }
}
}

#pragma mark - 监听textFile
- (NSString *)filterCharactor:(NSString *)string withRegex:(NSString *)regexStr{
    NSString *filterText = string;
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *result = [regex stringByReplacingMatchesInString:filterText options:NSMatchingReportCompletion range:NSMakeRange(0, filterText.length) withTemplate:@""];
    return result;
}
-(void)UserTextFieldDidChange :(UITextField *)theTextField{

    if (theTextField == self.userNameTextField) {
        if (theTextField.text.length > 30) {
            theTextField.text = [theTextField.text substringToIndex:30];
            
        }
        _userNameStr = theTextField.text;
    }

}
-(void)PhoneTextFieldDidChange :(UITextField *)theTextField{
    
    if (theTextField == self.userPhoneNum) {
        if (theTextField.text.length > 11) {
            theTextField.text = [theTextField.text substringToIndex:11];
           [MBManager showBriefAlert:ZBLocalized(@"手机号不能大于11位数", nil) ];
        }
         _userPhoneStr = theTextField.text;
    }

}

-(void)chooseMan{
    self.manIcon.image = [UIImage imageNamed:@"icon_nanxingdown"];
    
    [self.womenIcon setImage:[UIImage imageNamed:@"icon_nvxing"]];
    _userSex = @"1";
    
}
-(void)chooseWoman{
    self.manIcon.image = [UIImage imageNamed:@"icon_nanxing"];
    
    [self.womenIcon setImage:[UIImage imageNamed:@"icon_nvxingdown"]];
    _userSex = @"2";
}

-(void)taptoLocation{
    LocationMapVC *mapVC = [[LocationMapVC alloc]init];
    mapVC.returnValueBlock = ^(NSString *strValue) {
        self.tapToLoactionLabel.text = strValue;
        self.tapToLoactionLabel.textColor = [UIColor blackColor];
        self.tapToLoactionLabel.textAlignment = NSTextAlignmentCenter;
        _locationStr = strValue;
    };
    mapVC.returnlatBlock = ^(NSString *lat) {
        _getLat = lat;
    };
    mapVC.returnlongitBlock = ^(NSString *longit) {
        _getLong = longit;
    };
    [self.navigationController pushViewController:mapVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
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
