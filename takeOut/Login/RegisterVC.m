//
//  RegisterVC.m
//  takeOut
//
//  Created by mac on 2018/3/28.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "RegisterVC.h"
#import "UserProtoVC.h"
@interface RegisterVC ()<UITextFieldDelegate>
@property (nonatomic , strong) UITextField *phoneNumTextField;
@property (nonatomic , copy) NSString *phoneNumStr;
@property (nonatomic , strong) UITextField *codeTextField;
@property (nonatomic , copy) NSString *codeNumStr;
@property (nonatomic , strong) UITextField *sureCodeTextField;
@property (nonatomic , copy) NSString *sureCodeNumStr;
@property (nonatomic , strong) UIView *niveView;

@property (nonatomic , strong) UIButton *regisBtn;

@property (nonatomic , strong)UIButton *xuanze;
@end

@implementation RegisterVC

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
    titleLabel.text = ZBLocalized(@"注册", nil);
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
    
    UIImageView *phoneImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_zhanghao"]];
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
        
    [self.phoneNumTextField addTarget:self action:@selector(phoneTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.phoneNumTextField];
    [self.phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneBackView.mas_top);
        make.right.equalTo(phoneBackView.mas_right);
        make.height.equalTo(phoneBackView.mas_height);
        make.left.equalTo(phoneImg.mas_right).offset(10);
    }];
    
    
    
    UIView *codeBackView = [[UIView alloc]init];
    codeBackView.layer.cornerRadius=5;
    codeBackView.clipsToBounds = YES;
    codeBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:codeBackView];
    [codeBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneBackView.mas_bottom).offset(20);
        make.left.equalTo(phoneBackView.mas_left);
        make.right.equalTo(phoneBackView.mas_right);
        make.height.equalTo(@(45));
    }];
    
    UIImageView *codeImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_mima"]];
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
    self.codeTextField.secureTextEntry = YES;
    self.codeTextField.placeholder = ZBLocalized(@"请输入密码", nil);
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
   
    UIView *surecodeBackView = [[UIView alloc]init];
    surecodeBackView.layer.cornerRadius=5;
    surecodeBackView.clipsToBounds = YES;
    surecodeBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:surecodeBackView];
    [surecodeBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeBackView.mas_bottom).offset(20);
        make.left.equalTo(codeBackView.mas_left);
        make.right.equalTo(codeBackView.mas_right);
        make.height.equalTo(@(45));
    }];
    
    UIImageView *surecodeImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_chongfumima"]];
    [surecodeBackView addSubview:surecodeImg];
    [surecodeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(surecodeBackView);
        make.left.equalTo(surecodeBackView.mas_left).offset(10);
        make.top.equalTo(surecodeBackView.mas_top).offset(10);
        make.width.equalTo(surecodeImg.mas_height);
    }];
    
    self.sureCodeTextField = [[UITextField alloc]init];
    self.sureCodeTextField.delegate = self;
    self.sureCodeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.sureCodeTextField.secureTextEntry = YES;
    self.sureCodeTextField.placeholder = ZBLocalized(@"请确认密码", nil);
    self.sureCodeTextField.keyboardType = UIKeyboardTypeDefault;
    self.sureCodeTextField.returnKeyType =  UIReturnKeyDone;
    [self.sureCodeTextField addTarget:self action:@selector(sureCodeTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.sureCodeTextField];
    [self.sureCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(surecodeBackView.mas_top);
        make.right.equalTo(codeBackView.mas_right);
        make.height.equalTo(codeBackView.mas_height);
        make.left.equalTo(surecodeImg.mas_right).offset(10);
    }];
   
    
    self.regisBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.regisBtn setBackgroundColor:[UIColor grayColor]];
    self.regisBtn.layer.cornerRadius=10;
    self.regisBtn.clipsToBounds = YES;
    self.regisBtn.enabled = NO;
    [self.regisBtn setTitle:ZBLocalized(@"注册", nil) forState:UIControlStateNormal];
    [self.regisBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.regisBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self.view addSubview:self.regisBtn];
    [self.regisBtn addTarget:self action:@selector(regisAction) forControlEvents:UIControlEventTouchUpInside];
    [self.regisBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(surecodeBackView.mas_right).offset(-5);
        make.top.equalTo(surecodeBackView.mas_bottom).offset(50);
        make.centerX.equalTo(ws.view);
        make.height.equalTo(@(50));
    }];
    UILabel *hintLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, SCREENH_HEIGHT - TabbarHeight - 30, SCREEN_WIDTH - 60, 50)];
    hintLabel.numberOfLines=0;
    hintLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:hintLabel];
    hintLabel.font = [UIFont systemFontOfSize:14];
    NSMutableAttributedString *hintString=[[NSMutableAttributedString alloc]initWithString:ZBLocalized(@"注册代表您已同意《BEEORDER用户协议》", nil)];
    //获取要调整颜色的文字位置,调整颜色
    NSRange range1=[[hintString string]rangeOfString:ZBLocalized(@"《BEEORDER用户协议》", nil)];
    [hintString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:BaseYellow] range:range1];
    hintLabel.attributedText=hintString;
    
    UIButton *changeType = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:changeType];
    changeType.frame = CGRectMake(30, SCREENH_HEIGHT - TabbarHeight - 30, SCREEN_WIDTH - 60, 50);
    [changeType addTarget:self action:@selector(toysxieView) forControlEvents:UIControlEventTouchUpInside];
    
    self.xuanze = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.xuanze addTarget:self action:@selector(xuanzeAcTION) forControlEvents:UIControlEventTouchUpInside];
    [self.xuanze setImage:[UIImage imageNamed:@"icon_xuankuang"] forState:UIControlStateNormal];
    [self.xuanze setImage:[UIImage imageNamed:@"icon_xuankuang_down"] forState:UIControlStateSelected];
    [self.view addSubview:self.xuanze];
    [self.xuanze mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(hintLabel);
        make.right.equalTo(hintLabel.mas_left);
        make.width.and.height.equalTo(@(20));
    }];
}
-(void)xuanzeAcTION{
    if (self.xuanze.selected == YES) {
        self.xuanze.selected = NO;
        if (self.phoneNumStr != nil && self.codeNumStr != nil && self.sureCodeNumStr != nil && self.phoneNumStr != nil && self.codeNumStr != nil && self.phoneNumStr.length != 0 && self.codeNumStr.length !=0 && self.sureCodeNumStr.length != 0 &&self.xuanze.selected == YES) {
            [self.regisBtn setBackgroundColor:[UIColor colorWithHexString:BaseYellow]];
            self.regisBtn.enabled = YES;
        }else{
            [self.regisBtn setBackgroundColor:[UIColor grayColor]];
            self.regisBtn.enabled = NO;
        }
    }
    
   else if (self.xuanze.selected == NO) {
        self.xuanze.selected = YES;
       
       if (self.phoneNumStr != nil && self.codeNumStr != nil && self.sureCodeNumStr != nil && self.phoneNumStr != nil && self.codeNumStr != nil && self.phoneNumStr.length != 0 && self.codeNumStr.length !=0 && self.sureCodeNumStr.length != 0 &&self.xuanze.selected == YES) {
           [self.regisBtn setBackgroundColor:[UIColor colorWithHexString:BaseYellow]];
           self.regisBtn.enabled = YES;
       }else{
           [self.regisBtn setBackgroundColor:[UIColor grayColor]];
           self.regisBtn.enabled = NO;
       }
    }
    
}
#pragma mark - 监听textFile
-(void)phoneTextFieldDidChange :(UITextField *)theTextField{
    NSLog( @"text changed: %@", theTextField.text);
    self.phoneNumStr = theTextField.text;
    if (self.phoneNumStr != nil && self.codeNumStr != nil && self.sureCodeNumStr != nil && self.phoneNumStr != nil && self.codeNumStr != nil && self.phoneNumStr.length != 0 && self.codeNumStr.length !=0 && self.sureCodeNumStr.length != 0 &&self.xuanze.selected == YES) {
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
    if (self.phoneNumStr != nil && self.codeNumStr != nil && self.sureCodeNumStr != nil && self.phoneNumStr != nil && self.codeNumStr != nil && self.phoneNumStr.length != 0 && self.codeNumStr.length !=0 && self.sureCodeNumStr.length != 0&&self.xuanze.selected == YES) {
        [self.regisBtn setBackgroundColor:[UIColor colorWithHexString:BaseYellow]];
        self.regisBtn.enabled = YES;
    }else{
        [self.regisBtn setBackgroundColor:[UIColor grayColor]];
        self.regisBtn.enabled = NO;
    }
}
-(void)sureCodeTextFieldDidChange :(UITextField *)theTextField{
    NSLog( @"text changed: %@", theTextField.text);
    self.sureCodeNumStr = theTextField.text;
    if (self.phoneNumStr != nil && self.codeNumStr != nil && self.sureCodeNumStr != nil && self.phoneNumStr != nil && self.codeNumStr != nil && self.phoneNumStr.length != 0 && self.codeNumStr.length !=0 && self.sureCodeNumStr.length != 0&&self.xuanze.selected == YES) {
        [self.regisBtn setBackgroundColor:[UIColor colorWithHexString:BaseYellow]];
        self.regisBtn.enabled = YES;
    }else{
        [self.regisBtn setBackgroundColor:[UIColor grayColor]];
        self.regisBtn.enabled = NO;
    }
}

#pragma mark - 点击事件
-(void)regisAction{
    
    if (![self.codeNumStr isEqualToString:self.sureCodeNumStr]) {
        [MBManager showBriefAlert: ZBLocalized(@"两次密码不相同，请检查输入的密码", nil)];
        return;
    }
    if (self.xuanze.selected == NO) {
        [MBManager showBriefAlert: ZBLocalized(@"请同意用户协议", nil)];
        return;
    }
    NSString *url11 = [NSString stringWithFormat:@"%@%@",BASEURL,RegisUserURL];
     NSString * md5Code = [MD5encryption MD5ForLower32Bate:self.codeNumStr];
    NSDictionary *parameters = @{@"name":self.phoneNumStr,
                                 @"pwd":md5Code
                                 };
    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
    //请求的方式：POST
    [managers POST:url11 parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *code =[NSString stringWithFormat:@"%@",responseObject[@"code"]];
                if ([code isEqualToString:@"1"]) {
                    [MBManager showBriefAlert:ZBLocalized(@"注册成功", nil)];
                    [self performSelector:@selector(back) withObject:nil/*可传任意类型参数*/ afterDelay:2.0];
                }else{
                   // NSString *msg =[NSString stringWithFormat:@"%@",responseObject[@"msg"]];
                    NSString *error = [NSString stringWithFormat:@"%@",ZBLocalized(@"注册失败", nil)];
                    [MBManager showBriefAlert:error];
                }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [MBManager showBriefAlert:ZBLocalized(@"服务器异常", nil)];
    }];

}
-(void)toysxieView{
    UserProtoVC *userProto = [[UserProtoVC alloc]init];
    [self.navigationController pushViewController:userProto animated:YES];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
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

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
//{
//    if ([string isEqualToString:@"\n"])  //按会车可以改变
//    {
//        return YES;
//    }
//    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
//
//    if (self.phoneNumTextField == textField)
//    {
//        if ([toBeString length] > 11) {
//            textField.text = [toBeString substringToIndex:11];
//            NSLog(@"不能大于12");
//            [MBManager showBriefAlert:@"手机号不能大于12位数"];
//            return NO;
//        }
//    }else if (self.codeTextField == textField)
//    {
//        if ([toBeString length] > 8) {
//            textField.text = [toBeString substringToIndex:8];
//
//            NSLog(@"不能大于8");
//            [MBManager showBriefAlert:@"请输入正确验证码"];
//            return NO;
//        }
//    }
//    return YES;
//}

@end
