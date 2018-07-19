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
    titleLabel.text = [NSString stringWithFormat:@"%@BEEORDER",ZBLocalized(@"登录", nil)];
    titleLabel.textColor = [UIColor colorWithHexString:BaseTextBlackColor];
    titleLabel.font = [UIFont systemFontOfSize:16];
    [self.niveView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backBTN.mas_right).offset(kWidthScale(30));
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
    UILabel *countryTit = [[UILabel alloc]init];
    countryTit.text = ZBLocalized(@"手机号归属地", nil);
    countryTit.numberOfLines = 0;
    countryTit.textColor = [UIColor colorWithHexString:@"626262"];
    [self.view addSubview:countryTit];
    [countryTit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.view.mas_left).offset(kWidthScale(65));
        make.top.equalTo(ws.niveView.mas_bottom).offset(kWidthScale(130));
        make.right.equalTo(ws.view).offset(-kWidthScale(225));
    }];
    
    UIView *countryLine = [[UIView alloc]init];
    countryLine.backgroundColor = [UIColor colorWithHexString:@"e9e9e9"];
    [self.view addSubview:countryLine];
    [countryLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.left.equalTo(countryTit);
        make.top.equalTo(countryTit.mas_bottom).offset(kWidthScale(15));
        make.height.equalTo(@(1));
    }];
    
    self.countryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.countryBtn setTitleColor:[UIColor colorWithHexString:BaseYellow] forState:UIControlStateNormal];
    self.countryBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.countryBtn.titleLabel.numberOfLines = 2;
    [self.countryBtn addTarget:self action:@selector(toChooseCountry) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.countryBtn];
    [self.countryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(countryLine);
        make.centerY.equalTo(countryTit);
        make.width.equalTo(@(kWidthScale(100)));
        make.height.equalTo(@(kWidthScale(66)));
    }];
    
    UIView *countrySx = [[UIView alloc]init];
    countrySx.backgroundColor = [UIColor clearColor];
    [self.view addSubview:countrySx];
    [countrySx mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(countryTit);
        make.width.equalTo(@(kWidthScale(1)));
        make.bottom.equalTo(countryLine.mas_top).offset(-kWidthScale(10));
        make.right.equalTo(ws.countryBtn.mas_left).offset(-kWidthScale(2));
    }];
    
    self.countryNumLab = [[UILabel alloc]init];
    self.countryNumLab.font = [UIFont systemFontOfSize:14];
    self.countryNumLab.textColor = [UIColor colorWithHexString:@"626262"];
    [self.view addSubview:self.countryNumLab];
    [self.countryNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(countryLine.mas_bottom).offset(kWidthScale(60));
        make.left.equalTo(countryTit);
        make.width.equalTo(@(kWidthScale(150)));
        
    }];
    UITapGestureRecognizer *countryNoTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toChooseCountry)];
    [self.countryNumLab addGestureRecognizer:countryNoTapGestureRecognizer];
    self.countryNumLab.userInteractionEnabled = YES; // 可以理解为设置label可
    
    UIView *phoneLine = [[UIView alloc]init];
    phoneLine.backgroundColor = [UIColor colorWithHexString:@"e9e9e9"];
    [self.view addSubview:phoneLine];
    [phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.left.equalTo(countryTit);
        make.top.equalTo(ws.countryNumLab.mas_bottom).offset(kWidthScale(15));
        make.height.equalTo(@(1));
    }];
    
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
        make.right.equalTo(phoneLine.mas_right).offset(-5);
        
    }];
    
    self.codeTextField = [[UITextField alloc]init];
    self.codeTextField.delegate = self;
    self.codeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.codeTextField.placeholder = ZBLocalized(@"请输入验证码", nil);
    self.codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTextField.returnKeyType =  UIReturnKeyDone;
    [self.codeTextField addTarget:self action:@selector(codeTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.codeTextField];
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneLine.mas_bottom).offset(kWidthScale(60));
        make.left.equalTo(ws.countryNumLab.mas_left).offset(0);
        make.width.equalTo(@(kWidthScale(400)));
    }];
    
    UIView *codeLine = [[UIView alloc]init];
    codeLine.backgroundColor = [UIColor colorWithHexString:@"e9e9e9"];
    [self.view addSubview:codeLine];
    [codeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.left.equalTo(countryTit);
        make.top.equalTo(ws.codeTextField.mas_bottom).offset(kWidthScale(15));
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
    [self.toLoginButton setBackgroundColor:[UIColor colorWithHexString:BaseYellow]];
    self.toLoginButton.layer.cornerRadius=kWidthScale(5);
    self.toLoginButton.clipsToBounds = YES;
    //self.toLoginButton.enabled = NO;
    [self.toLoginButton setTitle:ZBLocalized(@"登录", nil) forState:UIControlStateNormal];
    [self.toLoginButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.toLoginButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self.view addSubview:self.toLoginButton];
    [self.toLoginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.toLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.view.mas_left).offset(kWidthScale(65));
        make.top.equalTo(codeLine.mas_bottom).offset(kWidthScale(90));
        make.centerX.equalTo(ws.view);
        make.height.equalTo(@(kWidthScale(85)));
    }];
    
    UIButton *loginByOthr = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *str = ZBLocalized(@"使用其他登录", nil);
    [loginByOthr setTitle:str forState:UIControlStateNormal];
    [loginByOthr addTarget:self action:@selector(loginByOther) forControlEvents:UIControlEventTouchUpInside];
    [loginByOthr setTitleColor:[UIColor colorWithHexString:BaseYellow] forState:UIControlStateNormal];
    loginByOthr.titleLabel.font = [UIFont systemFontOfSize:14];
    CGSize titleSize = [str sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:loginByOthr.titleLabel.font.fontName size:loginByOthr.titleLabel.font.pointSize]}];
    
    titleSize.height = 20;
    titleSize.width += 20;
    [self.view addSubview:loginByOthr];
    [loginByOthr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.top.equalTo(ws.toLoginButton.mas_bottom).offset(kWidthScale(24));
        make.height.equalTo(@(30));
        make.width.equalTo(@(titleSize.width));
    }];
    
     NSString *language=[[ZBLocalized sharedInstance]currentLanguage];
    if ([language isEqualToString:@"zh-Hans"]) {

        [self.countryBtn setImage:[UIImage imageNamed:@"中国"] forState:UIControlStateNormal];
        self.countryNumLab.text = @"+86";
    }else{
       [self.countryBtn setImage:[UIImage imageNamed:@"泰国"] forState:UIControlStateNormal];
        self.countryNumLab.text = @"+66";
    }
    
    
    UILabel *hintLabel=[[UILabel alloc]initWithFrame:CGRectMake(kWidthScale(150), SCREENH_HEIGHT - SafeAreaTabbarHeight - kWidthScale(120), SCREEN_WIDTH - kWidthScale(190), kWidthScale(80))];
    hintLabel.numberOfLines=0;
    hintLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:hintLabel];
    hintLabel.font = [UIFont systemFontOfSize:14];
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:ZBLocalized(@"登陆代表您已同意《BEEORDER用户协议》", nil)];
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
        }else {
            if (self.phoneNumStr.length >9) {
                [MBManager showBriefAlert:ZBLocalized(@"手机号不能大于9位数", nil) ];
                return;
            }else{
                 phoneStr = [NSString stringWithFormat:@"0%@",self.phoneNumStr];
            }
        }
       
        phoneZoneStr = [NSString stringWithFormat:@"66"];
    }
   
    
    
    
    //[par setValue:uuidStr forKey:@"phonemac"];
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
        [MBManager showBriefAlert:ZBLocalized(@"获取验证码失败，请检查网络", nil)];
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
    }else if(_xuanze.selected == NO){
        [MBManager showBriefAlert:ZBLocalized(@"请同意用户协议", nil)];
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
    NSString * uuidStr= [UUID getUUID];
    NSString * md5Code = [MD5encryption MD5ForLower32Bate:self.codeNumStr];
    NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,setsmsMsg];
    NSDictionary *parameters = @{@"phone":phoneStr,
                                 @"yzm":md5Code,
                                 @"phonemac":uuidStr
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
            NSString *userName =[NSString stringWithFormat:@"%@",dic[@"userName"]];
            
            
            [JPUSHService setAlias:@"bee" completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                NSLog(@"注册Alias==%ld",(long)iResCode);
            } seq:0];
            NSString *strTag = [NSString stringWithFormat:@"bee%@",userid];
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
