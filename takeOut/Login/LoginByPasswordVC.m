//
//  LoginByPasswordVC.m
//  takeOut
//
//  Created by mac on 2018/3/28.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "LoginByPasswordVC.h"
#import "NewRegisVC.h"
#import "UserProtoVC.h"
@interface LoginByPasswordVC ()<UITextFieldDelegate>
@property (nonatomic , strong) UITextField *phoneNumTextField;
@property (nonatomic , copy) NSString *phoneNumStr;
@property (nonatomic , strong) UITextField *codeTextField;
@property (nonatomic , copy) NSString *codeNumStr;
@property (nonatomic , strong) UIView *niveView;
@property (nonatomic , strong) UIButton *regisBtn;
@property (nonatomic , strong) UIButton *regisRegisBtn;
@property (nonatomic , strong)UIButton *xuanze;
@end

@implementation LoginByPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
    view.backgroundColor = [UIColor colorWithHexString:BaseBackgroundGray];
    [self.view addSubview:view];
    [self createNaviView];
    [self setupUI];
}
#pragma mark - ui
-(void)createNaviView{
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
        make.centerX.equalTo(ws.niveView);
        make.centerY.equalTo(backImg);
        make.left.equalTo(backImg.mas_right).offset(kWidthScale(45));
    }];
}

-(void)setupUI{
    //手机号
    __weak typeof(self) ws = self;
    UIView *phoneBackView = [[UIView alloc]init];
    phoneBackView.layer.cornerRadius=0;
    phoneBackView.clipsToBounds = YES;
    phoneBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:phoneBackView];
    [phoneBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.niveView.mas_bottom).offset(kWidthScale(60));
        make.right.equalTo(ws.view.mas_right).offset(-kWidthScale(50));
        make.left.equalTo(ws.view.mas_left).offset(kWidthScale(50));
        make.height.equalTo(@(kWidthScale(100)));
    }];
    
    UIImageView *phoneImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_zhanghap"]];
    [phoneBackView addSubview:phoneImg];
    [phoneImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(phoneBackView);
        make.left.equalTo(phoneBackView.mas_left).offset(kWidthScale(20));
        make.width.and.height.equalTo(@(kWidthScale(45)));
    }];
    
    self.phoneNumTextField = [[UITextField alloc]init];
    self.phoneNumTextField.delegate = self;
    self.phoneNumTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.phoneNumTextField.placeholder = ZBLocalized(@"请输入手机号", nil);
    self.phoneNumTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumTextField.returnKeyType = UIReturnKeyNext;

    [self.phoneNumTextField addTarget:self action:@selector(phoneTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.phoneNumTextField];
    [self.phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneBackView.mas_top);
        make.right.equalTo(phoneBackView.mas_right).offset(-kWidthScale(100));
        make.height.equalTo(phoneBackView.mas_height);
        make.left.equalTo(phoneBackView.mas_left).offset(kWidthScale(80));
    }];
    
    

    
    UIView *codeBackView = [[UIView alloc]init];
    codeBackView.layer.cornerRadius=0;
    codeBackView.clipsToBounds = YES;
    codeBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:codeBackView];
    [codeBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneBackView.mas_bottom).offset(kWidthScale(50));
        make.left.equalTo(phoneBackView.mas_left);
        make.right.equalTo(phoneBackView.mas_right);
        make.height.equalTo(phoneBackView);
    }];
    
    UIImageView *codeImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_mima"]];
    [codeBackView addSubview:codeImg];
    [codeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(codeBackView);
        make.left.equalTo(codeBackView.mas_left).offset(kWidthScale(20));
        make.width.and.height.equalTo(@(kWidthScale(45)));
    }];
    
    self.codeTextField = [[UITextField alloc]init];
    self.codeTextField.delegate = self;
    self.codeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.codeTextField.placeholder = ZBLocalized(@"请输入密码", nil);
    self.codeTextField.secureTextEntry = YES;
    self.codeTextField.keyboardType = UIKeyboardTypeDefault;
    self.codeTextField.returnKeyType =  UIReturnKeyNext;
    [self.codeTextField addTarget:self action:@selector(codeTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.codeTextField];
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeBackView.mas_top);
        make.right.equalTo(codeBackView.mas_right).offset(-kWidthScale(100));
        make.height.equalTo(codeBackView.mas_height);
        make.left.equalTo(codeBackView.mas_left).offset(kWidthScale(80));
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
        make.centerY.equalTo(codeBackView);
        make.width.equalTo(@(kWidthScale(55)));
        make.height.equalTo(@(kWidthScale(40)));
        make.right.equalTo(codeBackView.mas_right).offset(-kWidthScale(20));
    }];
    
   
    self.regisBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.regisBtn setBackgroundColor:[UIColor colorWithHexString:@"c9c9c9"]];
    self.regisBtn.layer.cornerRadius=kWidthScale(5);
    self.regisBtn.clipsToBounds = YES;
    [self.regisBtn setTitle:ZBLocalized(@"登录", nil) forState:UIControlStateNormal];
    [self.regisBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.regisBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self.view addSubview:self.regisBtn];
    [self.regisBtn addTarget:self action:@selector(regisAction) forControlEvents:UIControlEventTouchUpInside];
    [self.regisBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(ws.view.mas_left).offset(kWidthScale(65));
        make.top.equalTo(codeBackView.mas_bottom).offset(kWidthScale(55));
        make.centerX.equalTo(ws.view);
        make.height.equalTo(@(kWidthScale(85)));
    }];
    
    self.regisRegisBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.regisRegisBtn setBackgroundColor:[UIColor clearColor]];
    self.regisRegisBtn.layer.cornerRadius=kWidthScale(5);
    self.regisRegisBtn.clipsToBounds = YES;
    self.regisRegisBtn.layer.borderWidth = 1;
    [self.regisRegisBtn setTitle:ZBLocalized(@"注册", nil) forState:UIControlStateNormal];
    [self.regisRegisBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.regisRegisBtn.layer.borderColor = [UIColor colorWithHexString:BaseYellow].CGColor;
    [self.regisRegisBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self.view addSubview:self.regisRegisBtn];
    [self.regisRegisBtn addTarget:self action:@selector(toregisAction) forControlEvents:UIControlEventTouchUpInside];
    [self.regisRegisBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.view.mas_left).offset(kWidthScale(65));
        make.top.equalTo(ws.regisBtn.mas_bottom).offset(kWidthScale(40));
        make.centerX.equalTo(ws.view);
        make.height.equalTo(@(kWidthScale(85)));
    }];
    
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
//    beeOrderArget *hintLabel=[[UILabel alloc]initWithFrame:CGRectMake(kWidthScale(150), SCREENH_HEIGHT - SafeAreaTabbarHeight - kWidthScale(120), SCREEN_WIDTH - kWidthScale(190), kWidthScale(80))];
//    hintLabel.numberOfLines=0;
//    hintLabel.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:hintLabel];
//    hintLabel.font = [UIFont systemFontOfSize:14];
//    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:ZBLocalized(@"登录代表您已同意", nil)];
//    //获取要调整颜色的文字位置,调整颜色
//    NSRange range1=[[hintString string]rangeOfString:ZBLocalized(@"《BEEORDER用户协议》", nil)];
//    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:BaseYellow] range:range1];
//    hintLabel.attributedText=hintString;
//
//    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeProtpo)];
//    [hintLabel addGestureRecognizer:labelTapGestureRecognizer];
//    hintLabel.userInteractionEnabled = YES; // 可以理解为设置label可被点击
//
//    self.xuanze = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.xuanze addTarget:self action:@selector(xuanzeAcTION) forControlEvents:UIControlEventTouchUpInside];
//    [self.xuanze setImage:[UIImage imageNamed:@"ubXIEYI"] forState:UIControlStateNormal];
//    [self.xuanze setImage:[UIImage imageNamed:@"xieyi"] forState:UIControlStateSelected];
//    self.xuanze.selected = YES;
//    [self.view addSubview:self.xuanze];
//    [self.xuanze mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(hintLabel);
//        make.right.equalTo(hintLabel.mas_left).offset(-kWidthScale(10));
//        make.width.and.height.equalTo(@(kWidthScale(40)));
//    }];
    
}
- (void)TouchDown
{
    self.codeTextField.secureTextEntry = NO;
}

- (void)TouchUp
{
    self.codeTextField.secureTextEntry = YES;
}

#pragma mark - 监听textFile
-(void)phoneTextFieldDidChange:(UITextField *)theTextField{
    NSLog( @"text changed: %@", theTextField.text);
    
    self.phoneNumStr = theTextField.text;
    if (self.phoneNumStr.length >= 9 && self.codeNumStr.length >= 1 ) {
        self.regisBtn.enabled = YES;
        self.regisBtn.backgroundColor =[ UIColor colorWithHexString:BaseYellow];
    }else{
        self.regisBtn.enabled = NO;
        self.regisBtn.backgroundColor =[ UIColor colorWithHexString:@"c9c9c9"];
    }
}
-(void)codeTextFieldDidChange:(UITextField *)theTextField{
    NSLog( @"text changed: %@", theTextField.text);
    self.codeNumStr = theTextField.text;
    if (self.phoneNumStr.length >= 9 && self.codeNumStr.length >= 1 ) {
        self.regisBtn.enabled = YES;
        self.regisBtn.backgroundColor =[ UIColor colorWithHexString:BaseYellow];
    }else{
        self.regisBtn.enabled = NO;
        self.regisBtn.backgroundColor =[ UIColor colorWithHexString:@"c9c9c9"];
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
        if ([toBeString length] > 11) {
            textField.text = [toBeString substringToIndex:11];
            NSLog(@"不能大于11");
            [MBManager showBriefAlert:ZBLocalized(@"手机号应该为9~11位数字", nil)];
            return NO;
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
#pragma mark - 点击事件
-(void)regisAction{
    
    if (self.phoneNumStr.length == 0) {
        [MBManager showBriefAlert:ZBLocalized(@"请输入手机号", nil)];
        return;
    }else if (self.phoneNumStr.length < 9 || self.phoneNumStr.length >11){
        [MBManager showBriefAlert:ZBLocalized(@"手机号应该为9~11位数字", nil)];
        return;
    }
    
    else if (self.codeNumStr.length == 0){
        [MBManager showBriefAlert:ZBLocalized(@"请输入密码", nil)];
        return;
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,LoginUserURL];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *ADDR = [NSString stringWithFormat:@"%@",[defaults objectForKey:UD_AddR]];
    NSString *LAT = [NSString stringWithFormat:@"%@",[defaults objectForKey:UD_lat]];
    NSString *LONG = [NSString stringWithFormat:@"%@",[defaults objectForKey:UD_long]];
//    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
//    [par setValue:self.codeNumStr forKey:@"pwd"];
//    [par setValue:self.phoneNumStr forKey:@"name"];
    NSString * md5Code = [MD5encryption MD5ForLower32Bate:self.codeNumStr];
    NSDictionary *parameters = @{@"name":self.phoneNumStr,
                                 @"pwd":md5Code,
                                 @"addr":ADDR,
                                 @"lat":LAT,
                                 @"lng":LONG,
                                 
                                 };
    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
    //请求的方式：POST
    [managers POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *code =[NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([code isEqualToString:@"1"]) {
            
            
            NSDictionary *dic = responseObject[@"value"];
            NSString *userid =[NSString stringWithFormat:@"%@",dic[@"id"]];
            NSString *userPhone =[NSString stringWithFormat:@"%@",dic[@"userPhone"]];
            NSString *userName =[NSString stringWithFormat:@"kpV%@",dic[@"userName"]];
            NSLog(@"id%@",userid);
            [JPUSHService setAlias:JGPushAlias completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                NSLog(@"%ld",(long)seq);
            } seq:0];
            NSString *strTag = [NSString stringWithFormat:@"%@%@",JGPushAlias,userid];
            NSSet *set = [[NSSet alloc] initWithObjects:strTag,nil];
            [JPUSHService setTags:set completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
                NSLog(@"%ld",(long)seq);
            } seq:0];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:userid forKey:UD_USERID];
            [defaults setObject:userName forKey:UD_USERNAME];
            [defaults setObject:userPhone forKey:UD_USERPHONE];
            
            [defaults synchronize];
            
            [MBManager showBriefAlert:ZBLocalized(@"登录成功", nil)];
            [self performSelector:@selector(backToMine) withObject:nil/*可传任意类型参数*/ afterDelay:2.0];
        }else{
             [MBManager showBriefAlert:ZBLocalized(@"账号或密码错误", nil)];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [MBManager showBriefAlert:ZBLocalized(@"服务器异常", nil)];
    }];
}
-(void)toUserProto{
    UserProtoVC *userProto = [[UserProtoVC alloc]init];
    [self.navigationController pushViewController:userProto animated:YES];
}
-(void)toregisAction{
    NewRegisVC *regi = [[NewRegisVC alloc]init];
    [self.navigationController pushViewController:regi animated:YES];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)backToMine{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)seeProtpo{
    UserProtoVC *userProto = [[UserProtoVC alloc]init];
    [self.navigationController pushViewController:userProto animated:YES];
}
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
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
