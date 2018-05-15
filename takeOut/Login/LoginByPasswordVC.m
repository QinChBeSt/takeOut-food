//
//  LoginByPasswordVC.m
//  takeOut
//
//  Created by mac on 2018/3/28.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "LoginByPasswordVC.h"
#import "RegisterVC.h"
#import "UserProtoVC.h"
@interface LoginByPasswordVC ()<UITextFieldDelegate>
@property (nonatomic , strong) UITextField *phoneNumTextField;
@property (nonatomic , copy) NSString *phoneNumStr;
@property (nonatomic , strong) UITextField *codeTextField;
@property (nonatomic , copy) NSString *codeNumStr;
@property (nonatomic , strong) UIView *niveView;
@property (nonatomic , strong) UIButton *regisBtn;
@property (nonatomic , strong) UIButton *regisRegisBtn;
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
    titleLabel.text = ZBLocalized(@"登录", nil);
    titleLabel.textColor = [UIColor blackColor];
    [self.niveView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.centerY.equalTo(backImg);
    }];
}

-(void)setupUI{
    //手机号
    __weak typeof(self) ws = self;
    UIView *phoneBackView = [[UIView alloc]init];
    phoneBackView.layer.cornerRadius=5;
    phoneBackView.clipsToBounds = YES;
    phoneBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:phoneBackView];
    [phoneBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.niveView.mas_bottom).offset(45);
        make.right.equalTo(ws.view.mas_right).offset(-25);
        make.left.equalTo(ws.view.mas_left).offset(25);
        make.height.equalTo(@(45));
    }];
    
    UIImageView *phoneImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"用户"]];
    [phoneBackView addSubview:phoneImg];
    [phoneImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(phoneBackView);
        make.left.equalTo(phoneBackView.mas_left).offset(10);
        make.top.equalTo(phoneBackView.mas_top).offset(10);
        make.width.equalTo(phoneImg.mas_height);
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
        make.right.equalTo(phoneBackView.mas_right);
        make.height.equalTo(phoneBackView.mas_height);
        make.left.equalTo(phoneImg.mas_right).offset(10);
    }];
    
    
    
    UIView *phoneLine = [[UIView alloc]init];
    //phoneLine.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:phoneLine];
    [phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.left.equalTo(ws.phoneNumTextField);
        make.height.equalTo(@(0.5));
        make.top.equalTo(ws.phoneNumTextField.mas_bottom).offset(10);
    }];
    
    
    UIView *codeBackView = [[UIView alloc]init];
    codeBackView.layer.cornerRadius=5;
    codeBackView.clipsToBounds = YES;
    codeBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:codeBackView];
    [codeBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneBackView.mas_bottom).offset(50);
        make.left.equalTo(phoneBackView.mas_left);
        make.right.equalTo(phoneBackView.mas_right);
        make.height.equalTo(@(45));
    }];
    
    UIImageView *codeImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"闹钟"]];
    [codeBackView addSubview:codeImg];
    [codeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(codeBackView);
        make.left.equalTo(codeBackView.mas_left).offset(10);
        make.top.equalTo(codeBackView.mas_top).offset(10);
        make.width.equalTo(codeImg.mas_height);
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
        make.right.equalTo(codeBackView.mas_right);
        make.height.equalTo(codeBackView.mas_height);
        make.left.equalTo(codeImg.mas_right).offset(10);
    }];

    
   
    self.regisBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.regisBtn setBackgroundColor:[UIColor grayColor]];
    self.regisBtn.layer.cornerRadius=10;
    self.regisBtn.clipsToBounds = YES;
    self.regisBtn.enabled = NO;
    [self.regisBtn setTitle:ZBLocalized(@"登录", nil) forState:UIControlStateNormal];
    [self.regisBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.regisBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self.view addSubview:self.regisBtn];
    [self.regisBtn addTarget:self action:@selector(regisAction) forControlEvents:UIControlEventTouchUpInside];
    [self.regisBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(codeBackView.mas_right).offset(-5);
        make.top.equalTo(codeBackView.mas_bottom).offset(50);
        make.centerX.equalTo(ws.view);
        make.height.equalTo(@(50));
    }];
    
    self.regisRegisBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.regisRegisBtn setBackgroundColor:[UIColor colorWithHexString:BaseBackgroundGray]];
    self.regisRegisBtn.layer.cornerRadius=10;
    self.regisRegisBtn.clipsToBounds = YES;
    self.regisRegisBtn.layer.borderWidth = 1;
    [self.regisRegisBtn setTitle:ZBLocalized(@"注册", nil) forState:UIControlStateNormal];
    [self.regisRegisBtn setTitleColor:[UIColor colorWithHexString:BaseYellow] forState:UIControlStateNormal];
    self.regisRegisBtn.layer.borderColor = [UIColor colorWithHexString:BaseYellow].CGColor;
    [self.regisRegisBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self.view addSubview:self.regisRegisBtn];
    [self.regisRegisBtn addTarget:self action:@selector(toregisAction) forControlEvents:UIControlEventTouchUpInside];
    [self.regisRegisBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(codeBackView.mas_right).offset(-5);
        make.top.equalTo(ws.regisBtn.mas_bottom).offset(20);
        make.centerX.equalTo(ws.view);
        make.height.equalTo(@(50));
    }];
    
    
    UILabel *hintLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, SCREENH_HEIGHT - TabbarHeight - 30, SCREEN_WIDTH - 60, 50)];
    hintLabel.numberOfLines=0;
    hintLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:hintLabel];
    hintLabel.font = [UIFont systemFontOfSize:14];
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:ZBLocalized(@"登录代表您已同意《BeeOrder用户协议》", nil)];
    //获取要调整颜色的文字位置,调整颜色
    NSRange range1=[[hintString string]rangeOfString:ZBLocalized(@"《BeeOrder用户协议》", nil)];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:BaseYellow] range:range1];
    hintLabel.attributedText=hintString;
    
    UIButton *changeType = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:changeType];
    changeType.frame = CGRectMake(30, SCREENH_HEIGHT - TabbarHeight - 30, SCREEN_WIDTH - 60, 50);
    [changeType addTarget:self action:@selector(toUserProto) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - 监听textFile
-(void)phoneTextFieldDidChange :(UITextField *)theTextField{
    NSLog( @"text changed: %@", theTextField.text);
    self.phoneNumStr = theTextField.text;
    if (self.phoneNumStr != nil && self.codeNumStr != nil && self.phoneNumStr != nil && self.codeNumStr != nil && self.phoneNumStr.length != 0 && self.codeNumStr.length !=0) {
        [self.regisBtn setBackgroundColor:[UIColor colorWithHexString:BaseYellow]];
        self.regisBtn.enabled = YES;
    }else{
        [self.regisBtn setBackgroundColor:[UIColor grayColor]];
        self.regisBtn.enabled = NO;
    }
}
-(void)codeTextFieldDidChange :(UITextField *)theTextField{
    NSLog( @"text changed: %@", theTextField.text);
    self.codeNumStr = theTextField.text;
    if (self.phoneNumStr != nil && self.codeNumStr != nil && self.phoneNumStr.length != 0 && self.codeNumStr.length !=0) {
        [self.regisBtn setBackgroundColor:[UIColor colorWithHexString:BaseYellow]];
        self.regisBtn.enabled = YES;
    }else {
        [self.regisBtn setBackgroundColor:[UIColor grayColor]];
        self.regisBtn.enabled = NO;
    }
}
#pragma mark - 点击事件
-(void)regisAction{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,LoginUserURL];
//    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
//    [par setValue:self.codeNumStr forKey:@"pwd"];
//    [par setValue:self.phoneNumStr forKey:@"name"];
    NSString * md5Code = [MD5encryption MD5ForLower32Bate:self.codeNumStr];
    NSDictionary *parameters = @{@"name":self.phoneNumStr,
                                 @"pwd":md5Code,
                                 };
    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
    //请求的方式：POST
    [managers POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *code =[NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([code isEqualToString:@"1"]) {
            
            
            NSDictionary *dic = responseObject[@"value"];
            NSString *userid =[NSString stringWithFormat:@"%@",dic[@"id"]];
            NSString *userPhone =[NSString stringWithFormat:@"%@",dic[@"userPhone"]];
            NSString *userName =[NSString stringWithFormat:@"%@",dic[@"userName"]];
            
            [JPUSHService setAlias:userid completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                NSLog(@"%ld",(long)seq);
            } seq:0];
            NSString *strTag = [NSString stringWithFormat:@"bee%@",userid];
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
              NSString *msg =[NSString stringWithFormat:@"%@",responseObject[@"msg"]];
            NSString *error = [NSString stringWithFormat:@"%@,code=%@,%@",ZBLocalized(@"登录失败", nil),code,msg];
            [MBManager showBriefAlert:error];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)toUserProto{
    UserProtoVC *userProto = [[UserProtoVC alloc]init];
    [self.navigationController pushViewController:userProto animated:YES];
}
-(void)toregisAction{
    RegisterVC *regi = [[RegisterVC alloc]init];
    [self.navigationController pushViewController:regi animated:YES];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)backToMine{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
