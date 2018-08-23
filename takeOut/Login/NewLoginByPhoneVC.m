//
//  NewLoginByPhoneVC.m
//  takeOut
//
//  Created by mac on 2018/7/10.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "NewLoginByPhoneVC.h"
#import "NewRegisVC.h"
#import "ChooseCountryVC.h"
#import "LoginByPasswordVC.h"
#import "UserProtoVC.h"
@interface NewLoginByPhoneVC ()<UITextFieldDelegate>
@property (nonatomic , strong)UIView *niveView;
@property (nonatomic , strong)UIButton *countryBtn;
@property (nonatomic , strong)UILabel *countryNumLab;
@property (nonatomic , strong) UITextField *phoneNumTextField;
@property (nonatomic , copy) NSString *phoneNumStr;
@property (nonatomic , strong) UITextField *codeTextField;
@property (nonatomic , copy) NSString *codeNumStr;
@property (nonatomic , strong) UIButton *codeButton;
@property (nonatomic , strong)UIButton *toLoginButton;
@property (nonatomic , strong)UIButton *xuanze;
@end

@implementation NewLoginByPhoneVC
-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNaviView];
    [self setUpUI];
}
#pragma mark - ui
-(void)createNaviView{
    self.view.backgroundColor = [UIColor whiteColor];
    self.niveView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SafeAreaTopHeight )];
    self.niveView.backgroundColor = [UIColor colorWithHexString:BaseYellow];
    [self.view addSubview:self.niveView];
    
    __weak typeof(self) ws = self;
    UIImageView *backImg = [[UIImageView alloc]init];
    [backImg setImage:[UIImage imageNamed:@"icon_@3jiantou"]];
    [self.niveView addSubview:backImg];
    [backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.niveView.mas_top).offset(SafeAreaStatsBarHeight + 10);
        make.left.equalTo(ws.niveView.mas_left).offset(15);
        make.width.equalTo(@(15));
        make.height.equalTo(@(24));
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
    titleLabel.text = [NSString stringWithFormat:@"%@ BEEORDER",ZBLocalized(@"登录", nil)];
    titleLabel.textColor = [UIColor colorWithHexString:BaseTextBlackColor];
    titleLabel.font = [UIFont systemFontOfSize:16];
    [self.niveView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backImg.mas_right).offset(kWidthScale(45));
        make.centerY.equalTo(backImg);
    }];
    
    UILabel *rightLab = [[UILabel alloc]init];
    rightLab.textColor = [UIColor colorWithHexString:BaseTextBlackColor];
    rightLab.font = [UIFont systemFontOfSize:16];
    rightLab.text = ZBLocalized(@"注册", nil);
    [self.niveView addSubview:rightLab];
    [rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backImg);
        make.right.equalTo(ws.niveView).offset(-kWidthScale(40));
    }];
    
    UIButton *regisBTN = [UIButton buttonWithType:UIButtonTypeCustom];
    [regisBTN addTarget:self action:@selector(regis) forControlEvents:UIControlEventTouchUpInside];
    [self.niveView addSubview:regisBTN];
    [regisBTN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.niveView.mas_top).offset(SafeAreaStatsBarHeight);
        make.right.equalTo(ws.niveView);
        make.width.equalTo(@(50));
        make.height.equalTo(@(SafeAreaTopHeight - SafeAreaStatsBarHeight));
    }];
    
}
-(void)setUpUI{
    __weak typeof(self) ws = self;
   
    self.countryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.countryBtn setTitleColor:[UIColor colorWithHexString:BaseYellow] forState:UIControlStateNormal];
    self.countryBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.countryBtn.titleLabel.numberOfLines = 2;
    [self.countryBtn addTarget:self action:@selector(toChooseCountry) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.countryBtn];
    [self.countryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.view.mas_left).offset(kWidthScale(70));
        make.top.equalTo(ws.niveView.mas_bottom).offset(kWidthScale(195));
        make.width.equalTo(@(kWidthScale(50)));
        make.height.equalTo(@(kWidthScale(35)));
    }];
    
    
    self.countryNumLab = [[UILabel alloc]init];
    self.countryNumLab.font = [UIFont systemFontOfSize:14];
    self.countryNumLab.textColor = [UIColor colorWithHexString:@"626262"];
    [self.view addSubview:self.countryNumLab];
    [self.countryNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.niveView.mas_bottom).offset(kWidthScale(195));
        make.left.equalTo(ws.countryBtn.mas_right).offset(kWidthScale(15));
        make.width.equalTo(@(kWidthScale(90)));
        
    }];
    UITapGestureRecognizer *countryNoTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toChooseCountry)];
    [self.countryNumLab addGestureRecognizer:countryNoTapGestureRecognizer];
    self.countryNumLab.userInteractionEnabled = YES; // 可以理解为设置label可
    
    UIView *phoneLine = [[UIView alloc]init];
    phoneLine.backgroundColor = [UIColor colorWithHexString:@"e9e9e9"];
    [self.view addSubview:phoneLine];
    [phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.left.equalTo(ws.view.mas_left).offset(kWidthScale(65));
        make.top.equalTo(ws.countryNumLab.mas_bottom).offset(kWidthScale(35));
        make.height.equalTo(@(1));
    }];
    
    self.phoneNumTextField = [[UITextField alloc]init];
    self.phoneNumTextField.delegate = self;
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:ZBLocalized(@"请输入手机号", nil) attributes:
                                      @{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"aeaeae"],
                                        NSFontAttributeName:self.phoneNumTextField.font
                                        }];
    self.phoneNumTextField.attributedPlaceholder = attrString;
  
    self.phoneNumTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumTextField.returnKeyType = UIReturnKeyNext;
    [self.phoneNumTextField addTarget:self action:@selector(phoneTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.phoneNumTextField];
    [self.phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.countryNumLab);
        make.left.equalTo(ws.countryNumLab.mas_right).offset(kWidthScale(5));
        make.right.equalTo(phoneLine.mas_right).offset(-5);
        
    }];
    
    self.codeTextField = [[UITextField alloc]init];
    self.codeTextField.delegate = self;
    self.codeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    NSAttributedString *attrStringcode = [[NSAttributedString alloc] initWithString:ZBLocalized(@"请输入验证码", nil) attributes:
                                      @{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"aeaeae"],
                                        NSFontAttributeName:self.codeTextField.font
                                        }];
    self.codeTextField.attributedPlaceholder = attrStringcode;
   
    self.codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTextField.returnKeyType =  UIReturnKeyDone;
    [self.codeTextField addTarget:self action:@selector(codeTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.codeTextField];
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneLine.mas_bottom).offset(kWidthScale(90));
        make.left.equalTo(ws.countryBtn.mas_left).offset(0);
        make.width.equalTo(@(kWidthScale(400)));
    }];
    
    UIView *codeLine = [[UIView alloc]init];
    codeLine.backgroundColor = [UIColor colorWithHexString:@"e9e9e9"];
    [self.view addSubview:codeLine];
    [codeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
         make.left.equalTo(ws.view.mas_left).offset(kWidthScale(65));
        make.top.equalTo(ws.codeTextField.mas_bottom).offset(kWidthScale(35));
        make.height.equalTo(@(1));
    }];
    self.codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.codeButton setBackgroundColor:[UIColor clearColor]];
    [self.codeButton setTitle:ZBLocalized(@"获取验证码", nil) forState:UIControlStateNormal];
    [self.codeButton setTitleColor:[UIColor colorWithHexString:BaseYellow] forState:UIControlStateNormal];
    self.codeButton.layer.cornerRadius=5;
    self.codeButton.titleLabel.numberOfLines = 2;
    self.codeButton.clipsToBounds = YES;
    [self.codeButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    self.codeButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:self.codeButton];
    [self.codeButton addTarget:self action:@selector(verifyEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(codeLine.mas_right).offset(0);
        make.bottom.equalTo(codeLine.mas_bottom);
        make.centerY.equalTo(ws.codeTextField);
        make.width.equalTo(@(kWidthScale(200)));
    }];
    
    self.toLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.toLoginButton setBackgroundColor:[UIColor colorWithHexString:@"c9c9c9"]];
    self.toLoginButton.layer.cornerRadius=kWidthScale(5);
    self.toLoginButton.clipsToBounds = YES;
    self.toLoginButton.enabled = NO;
    [self.toLoginButton setTitle:ZBLocalized(@"登录", nil) forState:UIControlStateNormal];
    [self.toLoginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.toLoginButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self.view addSubview:self.toLoginButton];
    [self.toLoginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.toLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.view.mas_left).offset(kWidthScale(65));
        make.top.equalTo(codeLine.mas_bottom).offset(kWidthScale(132));
        make.centerX.equalTo(ws.view);
        make.height.equalTo(@(kWidthScale(85)));
    }];
    
    UIButton *loginByOthr = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *str = ZBLocalized(@"使用其他登录", nil);
    [loginByOthr setTitle:str forState:UIControlStateNormal];
    [loginByOthr addTarget:self action:@selector(loginByOther) forControlEvents:UIControlEventTouchUpInside];
    [loginByOthr setTitleColor:[UIColor colorWithHexString:BaseYellow] forState:UIControlStateNormal];
    loginByOthr.titleLabel.font = [UIFont systemFontOfSize:16];
    CGSize titleSize = [str sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:loginByOthr.titleLabel.font.fontName size:loginByOthr.titleLabel.font.pointSize]}];
    
    titleSize.height = 20;
    titleSize.width += 20;
    [self.view addSubview:loginByOthr];
    [loginByOthr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.top.equalTo(ws.toLoginButton.mas_bottom).offset(kWidthScale(40));
        make.height.equalTo(@(30));
        make.width.equalTo(@(titleSize.width));
    }];
    
     NSString *language=[[ZBLocalized sharedInstance]currentLanguage];
    if ([language isEqualToString:@"zh-Hans"]) {

        [self.countryBtn setImage:[UIImage imageNamed:@"icon_@3guoqizhongguoxiao"] forState:UIControlStateNormal];
        self.countryNumLab.text = @"+86";
    }else{
       [self.countryBtn setImage:[UIImage imageNamed:@"icon_@3guoqitaiguoxiao"] forState:UIControlStateNormal];
        self.countryNumLab.text = @"+66";
    }
    
    
    UILabel *beeOrderArget = [[UILabel alloc]init];
    beeOrderArget.text =ZBLocalized(@"《BEEORDER用户协议》", nil);
    beeOrderArget.textColor = [UIColor colorWithHexString:BaseYellow];
    beeOrderArget.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:beeOrderArget];
    [beeOrderArget mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.view.mas_bottom).offset(-SafeAreaTabbarHeight - kWidthScale(52));
        make.centerX.equalTo(ws.view);
    }];
    UILabel *Arget = [[UILabel alloc]init];
    Arget.text =ZBLocalized(@"登录代表您已同意", nil);
    Arget.textColor = [UIColor colorWithHexString:@"616161"];
    Arget.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:Arget];
    [Arget mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(beeOrderArget.mas_top).offset(-5);
        make.centerX.equalTo(ws.view);
    }];
    
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeProtpo)];
    [beeOrderArget addGestureRecognizer:labelTapGestureRecognizer];
    beeOrderArget.userInteractionEnabled = YES;
    
}
//倒数
- (void)reflashGetKeyBt:(NSNumber *)second
{
    if ([second integerValue] == 0)
    {
        _codeButton.selected=YES;
        _codeButton.userInteractionEnabled=YES;
        [_codeButton setTitle:ZBLocalized(@"获取验证码", nil) forState:(UIControlStateNormal)];
        [_codeButton setTitleColor:[UIColor colorWithHexString:BaseYellow] forState:UIControlStateNormal];
   
    }
    else
    {
        _codeButton.selected=NO;
        _codeButton.userInteractionEnabled=NO;
        int i = [second intValue];
        [_codeButton setTitleColor:[UIColor colorWithHexString:@"626262"] forState:UIControlStateNormal];
        [_codeButton setTitle:[NSString stringWithFormat:@"%i",i]forState:(UIControlStateNormal)];
        [self performSelector:@selector(reflashGetKeyBt:)withObject:[NSNumber numberWithInt:i-1] afterDelay:1];
    }
    
}

#pragma mark - 点击事件
- (void)verifyEvent
{
    if (self.phoneNumStr.length == 0 ) {
        [MBManager showBriefAlert:ZBLocalized(@"请输入正确的手机号", nil)];
        return;
    }
    
    //启动倒计时
    
    NSString * uuidStr= [UUID getUUID];
    NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,getsmsMsg];
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    NSString *phoneStr = [[NSString alloc]init];
    NSString *phoneZoneStr = [[NSString alloc]init];
    if ([self.countryNumLab.text isEqualToString:@"+86"]) {
        phoneStr = [NSString stringWithFormat:@"%@",self.phoneNumStr];
        phoneZoneStr = [NSString stringWithFormat:@"86"];
        if (phoneStr.length !=11) {
            [MBManager showBriefAlert:ZBLocalized(@"请输入正确的手机号", nil)];
            return;
        }
    }else{
        
        NSString *first = [self.phoneNumStr substringToIndex:1];
        if ([first isEqualToString:@"0"]) {
            if (self.phoneNumStr.length >10) {
                [MBManager showBriefAlert:ZBLocalized(@"手机号不能大于10位数", nil) ];
                return;
            }else if (self.phoneNumStr.length <10) {
                [MBManager showBriefAlert:ZBLocalized(@"请输入正确的手机号", nil)];
                return;
            }
            else{
                phoneStr = [NSString stringWithFormat:@"%@",self.phoneNumStr];
            }
        }else  {
            if (self.phoneNumStr.length >9) {
                [MBManager showBriefAlert:ZBLocalized(@"手机号不能大于9位数", nil) ];
                return;
            }else if (self.phoneNumStr.length <9) {
                [MBManager showBriefAlert:ZBLocalized(@"请输入正确的手机号", nil)];
                return;
            }
            else{
                phoneStr = [NSString stringWithFormat:@"0%@",self.phoneNumStr];
            }
        }
        
        phoneZoneStr = [NSString stringWithFormat:@"66"];
    }
    [par setValue:uuidStr forKey:@"phonemac"];
    [par setValue:phoneStr forKey:@"phone"];
    [par setValue:phoneZoneStr forKey:@"phonezone"];
    [self performSelector:@selector(reflashGetKeyBt:)withObject:[NSNumber numberWithInt:60] afterDelay:0];
    [MHNetWorkTask getWithURL:url withParameter:par withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
        NSString *code =[NSString stringWithFormat:@"%@",result[@"code"]];
        if ([code isEqualToString:@"1"]) {
            
        }else{
            NSString *mag = result[@"msg"];
            [MBManager showBriefAlert:mag];
        }
        
    } withFail:^(NSError *error) {
        [MBManager showBriefAlert:@"获取验证码失败，请检查网络"];
    }];
}
#pragma mark - 监听textFile
-(void)phoneTextFieldDidChange :(UITextField *)theTextField{
    NSLog( @"text changed: %@", theTextField.text);
    self.phoneNumStr = theTextField.text;
    if (self.phoneNumStr.length >= 9 && self.codeNumStr.length >= 1 ) {
        [self.toLoginButton setBackgroundColor:[UIColor colorWithHexString:BaseYellow]];
        self.toLoginButton.enabled = YES;
    }else{
        [self.toLoginButton setBackgroundColor:[UIColor colorWithHexString:@"c9c9c9"]];
        self.toLoginButton.enabled = NO;
    }
    
}
-(void)codeTextFieldDidChange :(UITextField *)theTextField{
    NSLog( @"text changed: %@", theTextField.text);
    self.codeNumStr = theTextField.text;
    if (self.phoneNumStr.length >= 9 && self.codeNumStr.length >= 1 ) {
        [self.toLoginButton setBackgroundColor:[UIColor colorWithHexString:BaseYellow]];
        self.toLoginButton.enabled = YES;
    }else{
        [self.toLoginButton setBackgroundColor:[UIColor colorWithHexString:@"c9c9c9"]];
        self.toLoginButton.enabled = NO;
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"])  //按会车可以改变
    {
        return NO;
    }
   
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.phoneNumTextField == textField)
    {
        if ([self.countryNumLab.text isEqualToString:@"+86"]) {
            if ([toBeString length] > 11) {
                textField.text = [toBeString substringToIndex:11];
                NSLog(@"不能大于11");
                [MBManager showBriefAlert:ZBLocalized(@"手机号不能大于11位数", nil) ];
                return NO;
            }
        }else{
            if ([self isBlankString:toBeString] ) {
                return YES;
            }else{
                NSString *first = [toBeString substringToIndex:1];
                NSLog(@"起始字符%@",first);
                if ([first isEqualToString:@"0"]) {
                    if ([toBeString length] > 10) {
                        textField.text = [toBeString substringToIndex:10];
                        NSLog(@"不能大于10");
                        [MBManager showBriefAlert:ZBLocalized(@"手机号不能大于10位数", nil) ];
                        return NO;
                    }
                }else  {
                    if ([toBeString length] > 9) {
                        textField.text = [toBeString substringToIndex:9];
                        NSLog(@"不能大于9");
                        [MBManager showBriefAlert:ZBLocalized(@"手机号不能大于9位数", nil) ];
                        return NO;
                    }
                }
            }
            
        }
        
    }
    return YES;
}
    

-(void)xuanzeAcTION{
    if (self.xuanze.selected == YES) {
        self.xuanze.selected = NO;
    }
    
    else if (self.xuanze.selected == NO) {
        self.xuanze.selected = YES;
 
    }
    
}
-(void)login{
    if (_phoneNumStr.length == 0) {
        [MBManager showBriefAlert:ZBLocalized(@"请输入手机号", nil)];
        return;
    }else if (_codeNumStr.length == 0) {
        [MBManager showBriefAlert:ZBLocalized(@"请输入验证码", nil)];
        return;
    }
    
    
    
    NSString *phoneStr = [[NSString alloc]init];
    if ([self.countryNumLab.text isEqualToString:@"+86"]) {
        
        phoneStr = [NSString stringWithFormat:@"%@",self.phoneNumStr];
    }else{
        NSString *first = [self.phoneNumStr substringToIndex:1];
        if ([first isEqualToString:@"0"]) {
            if (self.phoneNumStr.length >10) {
                [MBManager showBriefAlert:ZBLocalized(@"手机号不能大于10位数", nil) ];
                return;
            }else{
                phoneStr = [NSString stringWithFormat:@"%@",self.phoneNumStr];
            }
        }else {
            if (self.phoneNumStr.length >9) {
                [MBManager showBriefAlert:ZBLocalized(@"手机号不能大于9位数", nil) ];
                return;
            }else{
                phoneStr = [NSString stringWithFormat:@"0%@",self.phoneNumStr];
            }
        }
    }
    NSString *COUNRT ;
    NSString *PHZONE;
    if ([self.countryNumLab.text isEqualToString:@"+86"]) {
        COUNRT = @"中国";
        PHZONE = @"86";
    }
    else{
        COUNRT = @"泰国";
        PHZONE = @"66";
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *ADDR = [NSString stringWithFormat:@"%@",[defaults objectForKey:UD_AddR]];
    NSString *LAT = [NSString stringWithFormat:@"%@",[defaults objectForKey:UD_lat]];
    NSString *LONG = [NSString stringWithFormat:@"%@",[defaults objectForKey:UD_long]];
    NSString * uuidStr= [UUID getUUID];
    NSString * md5Code = [MD5encryption MD5ForLower32Bate:self.codeNumStr];
    NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,setsmsMsg];
    NSDictionary *parameters = @{@"phone":phoneStr,
                                 @"yzm":md5Code,
                                 @"phonemac":uuidStr,
                                 @"addr":ADDR,
                                 @"lat":LAT,
                                 @"lng":LONG,
                                 @"country":COUNRT,
                                 @"phonezone":PHZONE,
                                 };
    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
    //请求的方式：POST
    [managers POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSString *code =[NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([code isEqualToString:@"1"]) {
            
            
            NSDictionary *dic = responseObject[@"value"];
            NSString *userid =[NSString stringWithFormat:@"%@",dic[@"id"]];
            NSString *userPhone =[NSString stringWithFormat:@"%@",dic[@"userPhone"]];
            NSString *userName =[NSString stringWithFormat:@"kpV%@",dic[@"userName"]];
            
            NSLog(@"id=%@",userid);
            [JPUSHService setAlias:JGPushAlias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                NSLog(@"注册Alias==%ld",(long)iResCode);
            } seq:0];
            NSString *strTag = [NSString stringWithFormat:@"%@%@",JGPushAlias,userid];
            NSSet *set = [[NSSet alloc] initWithObjects:strTag,nil];
            [JPUSHService setTags:set completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
                NSLog(@"注册Tag===%ld",(long)iResCode);
            } seq:0];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:userid forKey:UD_USERID];
            [defaults setObject:userName forKey:UD_USERNAME];
            [defaults setObject:userPhone forKey:UD_USERPHONE];
            
            [defaults synchronize];
            
            [MBManager showBriefAlert:ZBLocalized(@"登录成功", nil)];
            [self back];
        }else{
            [MBManager showBriefAlert:ZBLocalized(@"验证码错误", nil)];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBManager showBriefAlert:ZBLocalized(@"服务器异常", nil)];
    }];
    
}


-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)regis
{
    NewRegisVC *REGIS = [[NewRegisVC alloc]init];
    [self.navigationController pushViewController:REGIS animated:YES];
    
}
-(void)loginByOther{
    LoginByPasswordVC *loginPassword = [[LoginByPasswordVC alloc]init];
    [self.navigationController pushViewController:loginPassword animated:YES];
}
-(void)toChooseCountry{
    ChooseCountryVC *chooseCou  = [[ChooseCountryVC alloc]init];
    if ([self.countryNumLab.text isEqualToString:@"+86"]) {
        chooseCou.hasChooseStr = @"0";
    }else{
        chooseCou.hasChooseStr = @"1";
    }
    chooseCou.blockChooseShow = ^(NSString *country) {
        if ([country isEqualToString:@"0"]) {
           [self.countryBtn setImage:[UIImage imageNamed:@"icon_@3guoqizhongguoxiao"] forState:UIControlStateNormal];
            self.countryNumLab.text = @"+86";
        }else{
          [self.countryBtn setImage:[UIImage imageNamed:@"icon_@3guoqitaiguoxiao"] forState:UIControlStateNormal];
            self.countryNumLab.text = @"+66";
        }
    };
    [self.navigationController pushViewController:chooseCou animated:YES];
}
-(void)seeProtpo{
    UserProtoVC *userProto = [[UserProtoVC alloc]init];
    [self.navigationController pushViewController:userProto animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
