//
//  NewRegisVC.m
//  takeOut
//
//  Created by mac on 2018/7/11.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "NewRegisVC.h"
#import "ChooseCountryVC.h"
#import "UserProtoVC.h"
@interface NewRegisVC ()<UITextFieldDelegate>
@property (nonatomic , strong)UIView *niveView;
@property (nonatomic , strong)UIButton *countryBtn;
@property (nonatomic , strong)UILabel *countryNumLab;
@property (nonatomic , strong) UITextField *phoneNumTextField;
@property (nonatomic , copy) NSString *phoneNumStr;
@property (nonatomic , strong) UITextField *codeTextField;
@property (nonatomic , copy) NSString *codeNumStr;
@property (nonatomic , strong) UITextField *passwordTextField;
@property (nonatomic , strong) NSString *passwordStr;
@property (nonatomic , strong) UITextField *SurePasswordTextField;
@property (nonatomic , strong) NSString *SurePasswordStr;

@property (nonatomic , strong) UIButton *codeButton;
@property (nonatomic , strong) UIButton *regisBtn;
@property (nonatomic , strong)UIButton *xuanze;
@end

@implementation NewRegisVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNaviView];
    [self setupUI];
}
#pragma mark - ui
-(void)createNaviView{
    self.view.backgroundColor = [UIColor colorWithHexString:BaseBackgroundGray];
    self.niveView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SafeAreaTopHeight )];
    self.niveView.backgroundColor = [UIColor colorWithHexString:BaseYellow];
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
    [self.niveView addSubview:backBTN];
    [backBTN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.niveView.mas_top).offset(SafeAreaStatsBarHeight);
        make.left.equalTo(ws.niveView.mas_left).offset(10);
        make.width.equalTo(@(40));
        make.height.equalTo(@(SafeAreaTopHeight - SafeAreaStatsBarHeight));
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = [NSString stringWithFormat:@"%@",ZBLocalized(@"注册", nil)];
    titleLabel.textColor = [UIColor colorWithHexString:BaseTextBlackColor];
    titleLabel.font = [UIFont systemFontOfSize:16];
    [self.niveView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backBTN.mas_right).offset(kWidthScale(30));
        make.centerY.equalTo(backImg);
    }];
}
-(void)setupUI{
    
    __weak typeof(self) ws = self;
    for (int i = 0 ; i < 5; i++) {
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(kWidthScale(40), SafeAreaTopHeight + kWidthScale(50) + kWidthScale(150) * i, SCREEN_WIDTH - kWidthScale(80), kWidthScale(100))];
        backView.tag = 100 + i;
        backView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:backView];
        
        if (i == 0) {
            UILabel *countryTit = [[UILabel alloc]init];
            countryTit.text = ZBLocalized(@"手机号归属地", nil);
            countryTit.numberOfLines = 0;
            countryTit.textColor = [UIColor colorWithHexString:@"626262"];
            [self.view addSubview:countryTit];
            [countryTit mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(backView.mas_left).offset(kWidthScale(20));
                make.top.equalTo(backView.mas_top).offset(kWidthScale(0));
                make.right.equalTo(backView).offset(-kWidthScale(180));
                make.bottom.equalTo(backView);
            }];
            self.countryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.countryBtn setTitleColor:[UIColor colorWithHexString:BaseYellow] forState:UIControlStateNormal];
            self.countryBtn.titleLabel.font = [UIFont systemFontOfSize:16];
            self.countryBtn.titleLabel.numberOfLines = 2;
            [self.countryBtn addTarget:self action:@selector(toChooseCountry) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:self.countryBtn];
            [self.countryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(backView);
                make.centerY.equalTo(countryTit);
                make.width.equalTo(@(kWidthScale(100)));
                make.height.equalTo(@(kWidthScale(66)));
            }];
            
            UIView *countrySx = [[UIView alloc]init];
            countrySx.backgroundColor = [UIColor colorWithHexString:@"e9e9e9"];
            [self.view addSubview:countrySx];
            [countrySx mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(countryTit);
                make.width.equalTo(@(kWidthScale(1)));
                make.bottom.equalTo(backView.mas_top).offset(-kWidthScale(10));
                make.right.equalTo(ws.countryBtn.mas_left).offset(-kWidthScale(2));
            }];
        }
        else if (i == 1){
            self.countryNumLab = [[UILabel alloc]init];
            self.countryNumLab.font = [UIFont systemFontOfSize:14];
            self.countryNumLab.textColor = [UIColor colorWithHexString:@"626262"];
            [self.view addSubview:self.countryNumLab];
            [self.countryNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(backView).offset(kWidthScale(0));
                make.left.equalTo(backView.mas_left).offset(kWidthScale(20));
//make.width.equalTo(@(kWidthScale(150)));
                make.bottom.equalTo(backView);
            }];
            UITapGestureRecognizer *countryNoTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toChooseCountry)];
            [self.countryNumLab addGestureRecognizer:countryNoTapGestureRecognizer];
            self.countryNumLab.userInteractionEnabled = YES; // 可以理解为设置label可
            
            self.phoneNumTextField = [[UITextField alloc]init];
            self.phoneNumTextField.delegate = self;
            self.phoneNumTextField.placeholder = ZBLocalized(@"请输入手机号", nil);
            self.phoneNumTextField.keyboardType = UIKeyboardTypeNumberPad;
            self.phoneNumTextField.returnKeyType = UIReturnKeyNext;
            [self.phoneNumTextField addTarget:self action:@selector(phoneTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            [self.view addSubview:self.phoneNumTextField];
            [self.phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(ws.countryNumLab);
                make.left.equalTo(ws.countryNumLab.mas_right).offset(kWidthScale(5));
                make.right.equalTo(backView.mas_right).offset(-5);
                
            }];
        }
        else if (i == 2){
            UIImageView *yzmIcon = [[UIImageView alloc]init];
            yzmIcon.image = [UIImage imageNamed:@"icon_yanzhengma"];
            [self.view addSubview:yzmIcon];
            [yzmIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(backView);
                make.left.equalTo(backView.mas_left).offset(kWidthScale(20));
                make.width.and.height.equalTo(@(kWidthScale(45)));
            } ];
            
            self.codeTextField = [[UITextField alloc]init];
            self.codeTextField.delegate = self;
            self.codeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            self.codeTextField.placeholder = ZBLocalized(@"请输入验证码", nil);
            self.codeTextField.keyboardType = UIKeyboardTypeNumberPad;
            self.codeTextField.returnKeyType =  UIReturnKeyDone;
            [self.codeTextField addTarget:self action:@selector(codeTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            [self.view addSubview:self.codeTextField];
            [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(backView.mas_top);
                make.left.equalTo(backView.mas_left).offset(kWidthScale(80));
                make.width.equalTo(@(kWidthScale(400)));
                make.bottom.equalTo(backView);
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
                make.right.equalTo(backView.mas_right).offset(0);
                make.bottom.equalTo(backView.mas_bottom);
                make.centerY.equalTo(ws.codeTextField);
                make.width.equalTo(@(kWidthScale(200)));
            }];
            
            
        }
        else if (i == 3){
            UIImageView *mmIcon = [[UIImageView alloc]init];
            mmIcon.image = [UIImage imageNamed:@"icon_mima"];
            [self.view addSubview:mmIcon];
            [mmIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(backView);
                make.left.equalTo(backView.mas_left).offset(kWidthScale(20));
                make.width.and.height.equalTo(@(kWidthScale(45)));
            } ];
            
            self.passwordTextField = [[UITextField alloc]init];
            self.passwordTextField.delegate = self;
            self.passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            self.passwordTextField.secureTextEntry = YES;
            self.passwordTextField.placeholder = ZBLocalized(@"请输入密码", nil);
            self.passwordTextField.keyboardType = UIKeyboardTypeDefault;
            self.passwordTextField.returnKeyType =  UIReturnKeyNext;
            [self.passwordTextField addTarget:self action:@selector(passwordTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            [self.view addSubview:self.passwordTextField];
            [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(backView.mas_top);
                make.right.equalTo(backView.mas_right).offset(-kWidthScale(100));
                make.height.equalTo(backView.mas_height);
                make.left.equalTo(backView.mas_left).offset(kWidthScale(80));
            }];
            
            UIButton *seePassWordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [seePassWordBtn setImage:[UIImage imageNamed:@"icon_buchakn"] forState:UIControlStateNormal];
            [seePassWordBtn setImage:[UIImage imageNamed:@"icon_chakn"] forState:UIControlStateHighlighted];
            //处理按钮点击事件
            [seePassWordBtn addTarget:self action:@selector(TouchDown)forControlEvents:UIControlEventTouchDown];
            //处理按钮松开状态
            [seePassWordBtn addTarget:self action:@selector(TouchUp)forControlEvents: UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
            [self.view addSubview:seePassWordBtn];
            [seePassWordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(backView);
                make.width.equalTo(@(kWidthScale(65)));
                make.height.equalTo(@(kWidthScale(50)));
                make.right.equalTo(backView.mas_right).offset(-kWidthScale(20));
            }];
        }
        else if (i == 4){
            UIImageView *smmIcon = [[UIImageView alloc]init];
            smmIcon.image = [UIImage imageNamed:@"icon_zaicimima"];
            [self.view addSubview:smmIcon];
            [smmIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(backView);
                make.left.equalTo(backView.mas_left).offset(kWidthScale(20));
                make.width.and.height.equalTo(@(kWidthScale(45)));
            } ];
            
            self.SurePasswordTextField = [[UITextField alloc]init];
            self.SurePasswordTextField.delegate = self;
            self.SurePasswordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            self.SurePasswordTextField.secureTextEntry = YES;
            self.SurePasswordTextField.placeholder = ZBLocalized(@"再次输入密码", nil);
            self.SurePasswordTextField.keyboardType = UIKeyboardTypeDefault;
            self.SurePasswordTextField.returnKeyType =  UIReturnKeyNext;
            [self.SurePasswordTextField addTarget:self action:@selector(surepasswordTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
            [self.view addSubview:self.SurePasswordTextField];
            [self.SurePasswordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(backView.mas_top);
                make.right.equalTo(backView.mas_right).offset(-kWidthScale(100));
                make.height.equalTo(backView.mas_height);
                make.left.equalTo(backView.mas_left).offset(kWidthScale(80));
            }];
            
            UIButton *seePassWordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [seePassWordBtn setImage:[UIImage imageNamed:@"icon_buchakn"] forState:UIControlStateNormal];
            [seePassWordBtn setImage:[UIImage imageNamed:@"icon_chakn"] forState:UIControlStateHighlighted];
            //处理按钮点击事件
            [seePassWordBtn addTarget:self action:@selector(sureTouchDown)forControlEvents:UIControlEventTouchDown];
            //处理按钮松开状态
            [seePassWordBtn addTarget:self action:@selector(sureTouchUp)forControlEvents: UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
            [self.view addSubview:seePassWordBtn];
            [seePassWordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(backView);
                make.width.equalTo(@(kWidthScale(65)));
                make.height.equalTo(@(kWidthScale(50)));
                make.right.equalTo(backView.mas_right).offset(-kWidthScale(20));
            }];
            
            self.regisBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.regisBtn setBackgroundColor:[UIColor colorWithHexString:BaseYellow]];
            self.regisBtn.layer.cornerRadius=5;
            self.regisBtn.clipsToBounds = YES;
            [self.regisBtn setTitle:ZBLocalized(@"注册", nil) forState:UIControlStateNormal];
            [self.regisBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.regisBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
            [self.view addSubview:self.regisBtn];
            [self.regisBtn addTarget:self action:@selector(regisAction) forControlEvents:UIControlEventTouchUpInside];
            [self.regisBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(ws.view.mas_left).offset(kWidthScale(65));
                make.top.equalTo(backView.mas_bottom).offset(kWidthScale(90));
                make.centerX.equalTo(ws.view);
                make.height.equalTo(@(kWidthScale(85)));
            }];
   
            
        }
        
    }
    
    UILabel *hintLabel=[[UILabel alloc]initWithFrame:CGRectMake(kWidthScale(150), SCREENH_HEIGHT - SafeAreaTabbarHeight - kWidthScale(120), SCREEN_WIDTH - kWidthScale(190), kWidthScale(80))];
    hintLabel.numberOfLines=0;
    hintLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:hintLabel];
    hintLabel.font = [UIFont systemFontOfSize:14];
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:ZBLocalized(@"注册代表您已同意《BEEORDER用户协议》", nil)];
    //获取要调整颜色的文字位置,调整颜色
    NSRange range1=[[hintString string]rangeOfString:ZBLocalized(@"《BEEORDER用户协议》", nil)];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:BaseYellow] range:range1];
    hintLabel.attributedText=hintString;
    
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeProtpo)];
    [hintLabel addGestureRecognizer:labelTapGestureRecognizer];
    hintLabel.userInteractionEnabled = YES; // 可以理解为设置label可被点击
    
    self.xuanze = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.xuanze addTarget:self action:@selector(xuanzeAcTION) forControlEvents:UIControlEventTouchUpInside];
    [self.xuanze setImage:[UIImage imageNamed:@"ubXIEYI"] forState:UIControlStateNormal];
    [self.xuanze setImage:[UIImage imageNamed:@"xieyi"] forState:UIControlStateSelected];
    self.xuanze.selected = YES;
    [self.view addSubview:self.xuanze];
    [self.xuanze mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(hintLabel);
        make.right.equalTo(hintLabel.mas_left).offset(-kWidthScale(10));
        make.width.and.height.equalTo(@(kWidthScale(40)));
    }];
    
    
    NSString *language=[[ZBLocalized sharedInstance]currentLanguage];
    if ([language isEqualToString:@"zh-Hans"]) {
        //[self.countryBtn setTitle:ZBLocalized(@"中国", nil) forState:UIControlStateNormal];
        [self.countryBtn setImage:[UIImage imageNamed:@"中国"] forState:UIControlStateNormal];
        self.countryNumLab.text = @"+86";
    }else{
        [self.countryBtn setImage:[UIImage imageNamed:@"泰国"] forState:UIControlStateNormal];
        //[self.countryBtn setTitle:ZBLocalized(@"泰国", nil) forState:UIControlStateNormal];
        self.countryNumLab.text = @"+66";
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
                }else {
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
#pragma mark - 点击事件
-(void)regisAction{
    
    if (![self.passwordStr isEqualToString:self.SurePasswordStr]) {
        [MBManager showBriefAlert: ZBLocalized(@"两次密码不相同，请检查输入的密码", nil)];
        return;
    }
    else if (self.xuanze.selected == NO) {
        [MBManager showBriefAlert: ZBLocalized(@"请同意用户协议", nil)];
        return;
    }
    else if (self.passwordStr.length == 0) {
        [MBManager showBriefAlert:ZBLocalized(@"请输入手机号", nil)];
        return;
    }
    else if (_codeNumStr.length == 0) {
        [MBManager showBriefAlert:ZBLocalized(@"请输入验证码", nil)];
        return;
    }
    else if (self.passwordStr.length == 0){
        [MBManager showBriefAlert:ZBLocalized(@"请输入密码", nil)];
        return;
    }
    NSString *url11 = [NSString stringWithFormat:@"%@%@",BASEURL,RegisUserURL];
    NSString * md5Code = [MD5encryption MD5ForLower32Bate:self.codeNumStr];
    
    NSString * md5CodePassword = [MD5encryption MD5ForLower32Bate:self.passwordStr];
    
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
                phoneStr = [NSString stringWithFormat:@"%@",self.phoneNumStr];
            }
        }
    }
    
    NSDictionary *parameters = @{@"name":phoneStr,
                                 @"pwd":md5CodePassword,
                                 @"yzm":md5Code
                                 };
    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
    //请求的方式：POST
    [managers POST:url11 parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *code =[NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([code isEqualToString:@"1"]) {
            [MBManager showBriefAlert:ZBLocalized(@"注册成功", nil)];
            [self performSelector:@selector(back) withObject:nil/*可传任意类型参数*/ afterDelay:2.0];
        }else if ([code isEqualToString:@"2"]){
            // NSString *msg =[NSString stringWithFormat:@"%@",responseObject[@"msg"]];
            NSString *error = [NSString stringWithFormat:@"%@",ZBLocalized(@"账号已存在", nil)];
            [MBManager showBriefAlert:error];
        }else{
             NSString *error = [NSString stringWithFormat:@"%@",ZBLocalized(@"验证码错误", nil)];
            [MBManager showBriefAlert:error];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBManager showBriefAlert:ZBLocalized(@"服务器异常", nil)];
    }];
    
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
    [self performSelector:@selector(reflashGetKeyBt:)withObject:[NSNumber numberWithInt:60] afterDelay:0];
    NSString * uuidStr= [UUID getUUID];
    NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,getsmsMsg];
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    NSString *phoneStr = [[NSString alloc]init];
    NSString *phoneZoneStr = [[NSString alloc]init];
    if ([self.countryNumLab.text isEqualToString:@"+86"]) {
        phoneStr = [NSString stringWithFormat:@"%@",self.phoneNumStr];
        phoneZoneStr = [NSString stringWithFormat:@"86"];
    }else{
        
        NSString *first = [self.phoneNumStr substringToIndex:1];
        if ([first isEqualToString:@"0"]) {
            if (self.phoneNumStr.length >10) {
                [MBManager showBriefAlert:ZBLocalized(@"手机号不能大于10位数", nil) ];
                return;
            }else{
                phoneStr = [NSString stringWithFormat:@"%@",self.phoneNumStr];
            }
        }else  {
            if (self.phoneNumStr.length >9) {
                [MBManager showBriefAlert:ZBLocalized(@"手机号不能大于9位数", nil) ];
                return;
            }else{
                phoneStr = [NSString stringWithFormat:@"0%@",self.phoneNumStr];
            }
        }
       
        phoneZoneStr = [NSString stringWithFormat:@"66"];
    }
    [par setValue:uuidStr forKey:@"phonemac"];
    [par setValue:phoneStr forKey:@"phone"];
    [par setValue:phoneZoneStr forKey:@"phonezone"];
    
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
    //    if (self.phoneNumStr != nil && self.codeNumStr != nil && self.phoneNumStr.length != 0 && self.codeNumStr.length != 0) {
    //        [self.toLoginButton setBackgroundColor:[UIColor colorWithHexString:BaseYellow]];
    //        self.toLoginButton.enabled = YES;
    //    }else{
    //        [self.toLoginButton setBackgroundColor:[UIColor colorWithHexString:BaseYellow]];
    //        self.toLoginButton.enabled = NO;
    //    }
}
-(void)codeTextFieldDidChange :(UITextField *)theTextField{
    NSLog( @"text changed: %@", theTextField.text);
    self.codeNumStr = theTextField.text;
    //    if (self.phoneNumStr != nil && self.codeNumStr != nil && self.phoneNumStr.length != 0 && self.codeNumStr.length != 0) {
    //        [self.toLoginButton setBackgroundColor:[UIColor colorWithHexString:BaseYellow]];
    //        self.toLoginButton.enabled = YES;
    //    }else{
    //        [self.toLoginButton setBackgroundColor:[UIColor grayColor]];
    //        self.toLoginButton.enabled = NO;
    //    }
}
-(void)passwordTextFieldDidChange :(UITextField *)theTextField{
    NSLog( @"text changed: %@", theTextField.text);
    self.passwordStr = theTextField.text;
    
}
-(void)surepasswordTextFieldDidChange :(UITextField *)theTextField{
    NSLog( @"text changed: %@", theTextField.text);
    self.SurePasswordStr = theTextField.text;
    
}
-(void)xuanzeAcTION{
    if (self.xuanze.selected == YES) {
        self.xuanze.selected = NO;
    }
    
    else if (self.xuanze.selected == NO) {
        self.xuanze.selected = YES;
        
    }
    
}
- (void)TouchDown
{
    self.passwordTextField.secureTextEntry = NO;
}

- (void)TouchUp
{
    self.passwordTextField.secureTextEntry = YES;
}

- (void)sureTouchDown
{
    self.SurePasswordTextField.secureTextEntry = NO;
}

- (void)sureTouchUp
{
    self.SurePasswordTextField.secureTextEntry = YES;
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)toChooseCountry{
    ChooseCountryVC *chooseCou  = [[ChooseCountryVC alloc]init];
    chooseCou.blockChooseShow = ^(NSString *country) {
        if ([country isEqualToString:@"0"]) {
            [self.countryBtn setImage:[UIImage imageNamed:@"中国"] forState:UIControlStateNormal];
            self.countryNumLab.text = @"+86";
        }else{
           [self.countryBtn setImage:[UIImage imageNamed:@"泰国"] forState:UIControlStateNormal];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
