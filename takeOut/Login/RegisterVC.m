//
//  RegisterVC.m
//  takeOut
//
//  Created by mac on 2018/3/28.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "RegisterVC.h"

@interface RegisterVC ()<UITextFieldDelegate>
@property (nonatomic , strong) UITextField *phoneNumTextField;
@property (nonatomic , copy) NSString *phoneNumStr;
@property (nonatomic , strong) UITextField *codeTextField;
@property (nonatomic , copy) NSString *codeNumStr;
@property (nonatomic , strong) UITextField *sureCodeTextField;
@property (nonatomic , copy) NSString *sureCodeNumStr;
@property (nonatomic , strong) UIView *niveView;

@property (nonatomic , strong) UIButton *regisBtn;
@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
    view.backgroundColor = [UIColor whiteColor];
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
    self.phoneNumTextField = [[UITextField alloc]init];
    self.phoneNumTextField.delegate = self;
    self.phoneNumTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.phoneNumTextField.placeholder = ZBLocalized(@"请输入手机号", nil);
    self.phoneNumTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumTextField.returnKeyType = UIReturnKeyNext;
    [self.phoneNumTextField addTarget:self action:@selector(phoneTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.phoneNumTextField];
    [self.phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.niveView.mas_bottom).offset(50);
        make.right.equalTo(ws.view.mas_right).offset(-50);
        make.left.equalTo(ws.view.mas_left).offset(50);
    }];
    
    UIView *phoneLine = [[UIView alloc]init];
    phoneLine.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:phoneLine];
    [phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.left.equalTo(ws.phoneNumTextField);
        make.height.equalTo(@(0.5));
        make.top.equalTo(ws.phoneNumTextField.mas_bottom).offset(10);
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
        make.top.equalTo(phoneLine.mas_bottom).offset(50);
        make.left.equalTo(ws.phoneNumTextField.mas_left);
        make.right.equalTo(ws.phoneNumTextField.mas_right);
    }];
    UIView *codeLine = [[UIView alloc]init];
    codeLine.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:codeLine];
    [codeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(phoneLine);
        make.left.equalTo(phoneLine);
        make.height.equalTo(@(0.5));
        make.top.equalTo(ws.codeTextField.mas_bottom).offset(10);
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
        make.top.equalTo(codeLine.mas_bottom).offset(50);
        make.left.equalTo(ws.phoneNumTextField.mas_left);
        make.right.equalTo(ws.phoneNumTextField.mas_right);
    }];
    UIView *sureCodeLine = [[UIView alloc]init];
    sureCodeLine.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:sureCodeLine];
    [sureCodeLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(phoneLine);
        make.left.equalTo(phoneLine);
        make.height.equalTo(@(0.5));
        make.top.equalTo(ws.sureCodeTextField.mas_bottom).offset(10);
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
        make.right.equalTo(codeLine.mas_right).offset(-5);
        make.top.equalTo(sureCodeLine.mas_bottom).offset(50);
        make.centerX.equalTo(ws.view);
        make.height.equalTo(@(50));
    }];
}

#pragma mark - 监听textFile
-(void)phoneTextFieldDidChange :(UITextField *)theTextField{
    NSLog( @"text changed: %@", theTextField.text);
    self.phoneNumStr = theTextField.text;
    if (self.phoneNumStr != nil && self.codeNumStr != nil && self.sureCodeNumStr != nil && self.phoneNumStr != nil && self.codeNumStr != nil && self.phoneNumStr.length != 0 && self.codeNumStr.length !=0 && self.sureCodeNumStr.length != 0) {
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
    if (self.phoneNumStr != nil && self.codeNumStr != nil && self.sureCodeNumStr != nil && self.phoneNumStr != nil && self.codeNumStr != nil && self.phoneNumStr.length != 0 && self.codeNumStr.length !=0 && self.sureCodeNumStr.length != 0) {
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
    if (self.phoneNumStr != nil && self.codeNumStr != nil && self.sureCodeNumStr != nil && self.phoneNumStr != nil && self.codeNumStr != nil && self.phoneNumStr.length != 0 && self.codeNumStr.length !=0 && self.sureCodeNumStr.length != 0) {
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
    
    NSString *url11 = [NSString stringWithFormat:@"%@%@",BASEURL,RegisUserURL];
    NSDictionary *parameters = @{@"name":self.phoneNumStr,
                                 @"pwd":self.codeNumStr
                                 };
    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
    //请求的方式：POST
    [managers POST:url11 parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *code =[NSString stringWithFormat:@"%@",responseObject[@"code"]];
                if ([code isEqualToString:@"1"]) {
                    [MBManager showBriefAlert:ZBLocalized(@"注册成功", nil)];
                    [self performSelector:@selector(back) withObject:nil/*可传任意类型参数*/ afterDelay:2.0];
                }else{
                    [MBManager showBriefAlert:ZBLocalized(@"注册失败", nil)];
                }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

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
