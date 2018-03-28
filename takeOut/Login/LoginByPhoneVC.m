//
//  LoginByPhoneVC.m
//  takeOut
//
//  Created by mac on 2018/3/28.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "LoginByPhoneVC.h"

@interface LoginByPhoneVC ()<UITextFieldDelegate>
@property (nonatomic , strong) UITextField *phoneNumTextField;
@property (nonatomic , copy) NSString *phoneNumStr;
@property (nonatomic , strong) UITextField *codeTextField;
@property (nonatomic , copy) NSString *codeNumStr;
@property (nonatomic , strong) UIView *niveView;
@property (nonatomic , strong) UIButton *codeButton;
@end

@implementation LoginByPhoneVC
-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self createNaviView];
    [self setupUI];
}
#pragma mark - ui
-(void)createNaviView{
    self.niveView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SafeAreaTopHeight )];
    self.niveView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.niveView];
    
    __weak typeof(self) ws = self;
    UIImageView *backImg = [[UIImageView alloc]init];
    backImg.backgroundColor = [UIColor orangeColor];
    [self.niveView addSubview:backImg];
    [backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.niveView.mas_top).offset(SafeAreaStatsBarHeight + 5);
        make.left.equalTo(ws.niveView.mas_left).offset(15);
        make.width.equalTo(@(25));
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
    titleLabel.text = @"登陆";
    titleLabel.textColor = [UIColor blackColor];
    [self.niveView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.centerY.equalTo(backImg);
    }];
}
-(void)setupUI{
    __weak typeof(self) ws = self;
    UILabel *CNLabel = [[UILabel alloc]init];
    CNLabel.text = @" +86 ";
    CNLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:CNLabel];
    [CNLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.niveView.mas_bottom).offset(50);
        make.left.equalTo(ws.view.mas_left).offset(30);
        make.width.equalTo(@(SCREEN_WIDTH /5));
    }];
//手机号
    self.phoneNumTextField = [[UITextField alloc]init];
    self.phoneNumTextField.delegate = self;
    self.phoneNumTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.phoneNumTextField.placeholder = @"请输入手机号";
    self.phoneNumTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumTextField.returnKeyType = UIReturnKeyNext;
    [self.phoneNumTextField addTarget:self action:@selector(phoneTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.phoneNumTextField];
    [self.phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(CNLabel);
        make.right.equalTo(ws.view.mas_right).offset(-30);
        make.left.equalTo(CNLabel.mas_right).offset(0);
    }];
    UIView *phoneLine = [[UIView alloc]init];
    phoneLine.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:phoneLine];
    [phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.left.equalTo(CNLabel);
        make.height.equalTo(@(0.5));
        make.top.equalTo(ws.phoneNumTextField.mas_bottom).offset(10);
    }];
//验证码
  
    self.codeTextField = [[UITextField alloc]init];
    self.codeTextField.delegate = self;
    self.codeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.codeTextField.placeholder = @"请输入验证码";
    self.codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTextField.returnKeyType =  UIReturnKeyDone;
    [self.codeTextField addTarget:self action:@selector(codeTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.codeTextField];
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneLine.mas_bottom).offset(50);
        make.left.equalTo(CNLabel.mas_right);
        make.right.equalTo(ws.view.mas_right).offset(-SCREEN_WIDTH / 5 - 30);
    }];
    
    self.codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.codeButton setBackgroundColor:[UIColor yellowColor]];
    [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.codeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.codeButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:self.codeButton];
    [self.codeButton addTarget:self action:@selector(verifyEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.view.mas_right).offset(-30);
        make.top.equalTo(phoneLine.mas_bottom).offset(50);
        make.centerY.equalTo(ws.codeTextField);
        make.width.equalTo(@(SCREEN_WIDTH /5));
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
    
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([string isEqualToString:@"\n"])  //按会车可以改变
    {
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.phoneNumTextField == textField)
    {
        if ([toBeString length] > 11) {
            textField.text = [toBeString substringToIndex:11];
            
            NSLog(@"不能大于12");
            return NO;
        }
    }else if (self.codeTextField == textField)
    {
        if ([toBeString length] > 8) {
            textField.text = [toBeString substringToIndex:8];
            
            NSLog(@"不能大于8");
            return NO;
        }
    }
    return YES;
}



#pragma mark - 监听textFile
-(void)phoneTextFieldDidChange :(UITextField *)theTextField{
    NSLog( @"text changed: %@", theTextField.text);
    self.phoneNumStr = theTextField.text;
}
-(void)codeTextFieldDidChange :(UITextField *)theTextField{
    NSLog( @"text changed: %@", theTextField.text);
    self.codeNumStr = theTextField.text;
}

#pragma mark - 倒计时
- (void)verifyEvent
{
    //启动倒计时
    [self performSelector:@selector(reflashGetKeyBt:)withObject:[NSNumber numberWithInt:60] afterDelay:0];
}

//倒数
- (void)reflashGetKeyBt:(NSNumber *)second
{
    if ([second integerValue] == 0)
    {
        _codeButton.selected=YES;
        _codeButton.userInteractionEnabled=YES;
        [_codeButton setTitle:@"重新获取"forState:(UIControlStateNormal)];
        [_codeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    else
    {
        _codeButton.selected=NO;
        _codeButton.userInteractionEnabled=NO;
        int i = [second intValue];
        [_codeButton setBackgroundColor:[UIColor grayColor]];
        [_codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_codeButton setTitle:[NSString stringWithFormat:@"%i",i]forState:(UIControlStateNormal)];
        [self performSelector:@selector(reflashGetKeyBt:)withObject:[NSNumber numberWithInt:i-1] afterDelay:1];
    }
    
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

@end
