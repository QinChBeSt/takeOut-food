//
//  LoginByPhoneVC.m
//  takeOut
//
//  Created by mac on 2018/3/28.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "LoginByPhoneVC.h"
#import "LoginByPasswordVC.h"
#import "NewRegisVC.h"
#import "UserProtoVC.h"
#import "CellForChooseCountry.h"
@interface LoginByPhoneVC ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITextField *phoneNumTextField;
@property (nonatomic , copy) NSString *phoneNumStr;
@property (nonatomic , strong) UITextField *codeTextField;
@property (nonatomic , copy) NSString *codeNumStr;
@property (nonatomic , strong) UIView *niveView;
@property (nonatomic , strong) UIButton *codeButton;
@property (nonatomic , strong) UIButton *toLoginButton;
@property (nonatomic , strong) UIButton *countyBtn;
@property (nonatomic , strong) UILabel *CNLabel;
@property (nonatomic , strong)UIView *windowBackView;
@property (nonatomic , strong)UIView *changeLagView;
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)NSIndexPath *lastIndexPath;

@end

@implementation LoginByPhoneVC
-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
    view.backgroundColor = [UIColor colorWithHexString:BaseBackgroundGray];
    [self.view addSubview:view];
    [self.view setBackgroundColor:[UIColor colorWithHexString:BaseBackgroundGray]];
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
    __weak typeof(self) ws = self;
    
   
    self.countyBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    NSString *language=[[ZBLocalized sharedInstance]currentLanguage];
    NSLog(@"切换后的语言:%@",language);
    [self.countyBtn addTarget:self action:@selector(tochooseCoun) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.countyBtn];
    [self.countyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.niveView.mas_bottom).offset(50);
        make.left.equalTo(ws.view.mas_left).offset(25);
        make.height.equalTo(@(25));
        make.width.equalTo(@(37.7));
        
    }];
    
    self.CNLabel = [[UILabel alloc]init];
    
    self.CNLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:self.CNLabel];
    [self.CNLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.countyBtn.mas_right).offset(5);
        make.centerY.equalTo(ws.countyBtn);
    }];
    [self.CNLabel setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                      forAxis:UILayoutConstraintAxisHorizontal];
    if ([language isEqualToString:@"zh-Hans"]) {
        [self.countyBtn setImage:[UIImage imageNamed:@"中国"] forState:UIControlStateNormal];
        self.CNLabel.text = @"+86";
        self.lastIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    }else{
        [self.countyBtn setImage:[UIImage imageNamed:@"泰国"] forState:UIControlStateNormal];
        self.CNLabel.text = @"+66";
        self.lastIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    UIView *phoneBackView = [[UIView alloc]init];
    phoneBackView.layer.cornerRadius=5;
    phoneBackView.clipsToBounds = YES;
    phoneBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:phoneBackView];
    [phoneBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.countyBtn);
        make.right.equalTo(ws.view.mas_right).offset(-25);
        make.left.equalTo(ws.CNLabel.mas_right).offset(0);
        make.height.equalTo(@(45));
    }];
    
//手机号
    self.phoneNumTextField = [[UITextField alloc]init];
    
    self.phoneNumTextField.delegate = self;
    self.phoneNumTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.phoneNumTextField.placeholder = ZBLocalized(@"请输入手机号", nil);
    self.phoneNumTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumTextField.returnKeyType = UIReturnKeyNext;
    [self.phoneNumTextField addTarget:self action:@selector(phoneTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:self.phoneNumTextField];
    [self.phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(phoneBackView);
        make.right.equalTo(phoneBackView.mas_right).offset(-5);
        make.left.equalTo(phoneBackView.mas_left).offset(5);
    }];
    
    

    
//验证码
  
   
    
    self.codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.codeButton setBackgroundColor:[UIColor colorWithHexString:BaseYellow]];
    [self.codeButton setTitle:ZBLocalized(@"获取验证码", nil) forState:UIControlStateNormal];
    [self.codeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.codeButton.layer.cornerRadius=5;
    
    self.codeButton.clipsToBounds = YES;
    [self.codeButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    self.codeButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:self.codeButton];
    [self.codeButton addTarget:self action:@selector(verifyEvent) forControlEvents:UIControlEventTouchUpInside];
    [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.view.mas_right).offset(-30);
        make.top.equalTo(phoneBackView.mas_bottom).offset(40);
        make.height.equalTo(@(45));
        make.width.equalTo(@(SCREEN_WIDTH /4));
    }];
    UIView *codeBackView = [[UIView alloc]init];
    codeBackView.layer.cornerRadius=5;
    codeBackView.clipsToBounds = YES;
    codeBackView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:codeBackView];
    [codeBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneBackView.mas_bottom).offset(40);
        make.right.equalTo(ws.codeButton.mas_left).offset(-5);
        make.left.equalTo(phoneBackView.mas_left).offset(0);
        make.height.equalTo(@(45));
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
        make.centerY.equalTo(codeBackView);
        make.left.equalTo(codeBackView.mas_left).offset(5);
        make.right.equalTo(codeBackView.mas_right).offset(-5);
    }];
    
    
    UIButton *loginByOthr = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *str = ZBLocalized(@"其他登录", nil);
    [loginByOthr setTitle:str forState:UIControlStateNormal];
    [loginByOthr addTarget:self action:@selector(loginByOther) forControlEvents:UIControlEventTouchUpInside];
    [loginByOthr setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    CGSize titleSize = [str sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:loginByOthr.titleLabel.font.fontName size:loginByOthr.titleLabel.font.pointSize]}];
    
    titleSize.height = 20;
    titleSize.width += 20;
    [self.view addSubview:loginByOthr];
    [loginByOthr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.view.mas_left).offset(30);
        make.top.equalTo(codeBackView.mas_bottom).offset(30);
        make.height.equalTo(@(30));
        make.width.equalTo(@(titleSize.width));
    }];
    
    
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setTitle:ZBLocalized(@"注册", nil) forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.view.mas_right).offset(-30);
        make.top.equalTo(codeBackView.mas_bottom).offset(30);
        make.height.equalTo(@(30));
        make.width.equalTo(@(SCREEN_WIDTH / 5));
    }];
    
    self.toLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.toLoginButton setBackgroundColor:[UIColor grayColor]];
    self.toLoginButton.layer.cornerRadius=10;
    self.toLoginButton.clipsToBounds = YES;
    self.toLoginButton.enabled = NO;
    [self.toLoginButton setTitle:ZBLocalized(@"登录", nil) forState:UIControlStateNormal];
    [self.toLoginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.toLoginButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self.view addSubview:self.toLoginButton];
    [self.toLoginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.toLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.view.mas_left).offset(30);
        make.top.equalTo(registerBtn.mas_bottom).offset(50);
        make.centerX.equalTo(ws.view);
        make.height.equalTo(@(50));
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
//        if ([toBeString length] > 11) {
//            textField.text = [toBeString substringToIndex:11];
//            NSLog(@"不能大于12");
//            [MBManager showBriefAlert:@"手机号不能大于12位数"];
//            return NO;
//        }
    }else if (self.codeTextField == textField)
    {
//        if ([toBeString length] > 8) {
//            textField.text = [toBeString substringToIndex:8];
//
//            NSLog(@"不能大于8");
//            [MBManager showBriefAlert:@"请输入正确验证码"];
//            return NO;
//        }
    }
    return YES;
}

#pragma mark - 监听textFile
-(void)phoneTextFieldDidChange :(UITextField *)theTextField{
    NSLog( @"text changed: %@", theTextField.text);
    self.phoneNumStr = theTextField.text;
    if (self.phoneNumStr != nil && self.codeNumStr != nil && self.phoneNumStr.length != 0 && self.codeNumStr.length != 0) {
        [self.toLoginButton setBackgroundColor:[UIColor colorWithHexString:BaseYellow]];
        self.toLoginButton.enabled = YES;
    }else{
        [self.toLoginButton setBackgroundColor:[UIColor grayColor]];
        self.toLoginButton.enabled = NO;
    }
}
-(void)codeTextFieldDidChange :(UITextField *)theTextField{
    NSLog( @"text changed: %@", theTextField.text);
    self.codeNumStr = theTextField.text;
    if (self.phoneNumStr != nil && self.codeNumStr != nil && self.phoneNumStr.length != 0 && self.codeNumStr.length != 0) {
        [self.toLoginButton setBackgroundColor:[UIColor colorWithHexString:BaseYellow]];
        self.toLoginButton.enabled = YES;
    }else{
        [self.toLoginButton setBackgroundColor:[UIColor grayColor]];
        self.toLoginButton.enabled = NO;
    }
}

#pragma mark - 倒计时

//倒数
- (void)reflashGetKeyBt:(NSNumber *)second
{
    if ([second integerValue] == 0)
    {
        _codeButton.selected=YES;
        _codeButton.userInteractionEnabled=YES;
        [_codeButton setTitle:ZBLocalized(@"重新获取", nil) forState:(UIControlStateNormal)];
        [_codeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_codeButton setBackgroundColor:[UIColor colorWithHexString:BaseYellow]];
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
    
    if ([self.CNLabel.text isEqualToString:@"+86"]) {
        phoneStr = [NSString stringWithFormat:@"86:%@",self.phoneNumStr];
    }else{
        phoneStr = [NSString stringWithFormat:@"66:%@",self.phoneNumStr];
    }
    [par setValue:uuidStr forKey:@"phonemac"];
    [par setValue:phoneStr forKey:@"phone"];
    
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
-(void)login{
    if (_phoneNumStr.length == 0) {
        [MBManager showBriefAlert:ZBLocalized(@"请输入手机号", nil)];
        return;
    }else if (_codeNumStr.length == 0) {
        [MBManager showBriefAlert:ZBLocalized(@"请输入验证码", nil)];
        return;
    }
     NSString *phoneStr = [[NSString alloc]init];
    if ([self.CNLabel.text isEqualToString:@"+86"]) {
        phoneStr = [NSString stringWithFormat:@"86:%@",self.phoneNumStr];
    }else{
        phoneStr = [NSString stringWithFormat:@"66:%@",self.phoneNumStr];
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
            NSString *userName =[NSString stringWithFormat:@"kpV%@",dic[@"userName"]];
            
        
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
            [self performSelector:@selector(back) withObject:nil/*可传任意类型参数*/ afterDelay:2.0];
        }else{
            [MBManager showBriefAlert:ZBLocalized(@"账号或密码错误", nil)];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      [MBManager showBriefAlert:ZBLocalized(@"服务器异常", nil)];
    }];
    
}
-(void)loginByOther{
    LoginByPasswordVC *loginPassword = [[LoginByPasswordVC alloc]init];
    [self.navigationController pushViewController:loginPassword animated:YES];
}
-(void)registerUser{
    NewRegisVC  *registerVC = [[NewRegisVC alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}
-(void)createwindowBackView{
    self.windowBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
    self.windowBackView.backgroundColor = [UIColor colorWithHexString:@"363636" alpha:0.3];
    [[UIApplication sharedApplication].keyWindow addSubview:self.windowBackView];
    
}
-(void)tochooseCoun{
    [self createwindowBackView];
    __weak typeof(self) ws = self;
    self.changeLagView = [[UIView alloc]init];
    self.changeLagView.layer.cornerRadius=10;
    
    self.changeLagView.clipsToBounds = YES;
    self.changeLagView.backgroundColor = [UIColor whiteColor];
    [self.windowBackView addSubview:self.changeLagView];
    [self.changeLagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.centerY.equalTo(ws.windowBackView);
        make.left.equalTo(ws.view.mas_left).offset(30);
        make.height.equalTo(@(140));
    }];
    UIButton *backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.layer.cornerRadius=15;
    [backBtn setImage:[UIImage imageNamed:@"icon_guanbianniu"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(closeWindow) forControlEvents:UIControlEventTouchUpInside];
    backBtn.backgroundColor = [UIColor colorWithHexString:BaseBackgroundGray];
    backBtn.clipsToBounds = YES;
    [self.windowBackView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.changeLagView.mas_right).offset(-5);
        make.centerY.equalTo(ws.changeLagView.mas_top).offset(5);
        make.width.and.height.equalTo(@(30));
    }];
    
    [self createTableView];
   
}

-(void)createTableView{
    __weak typeof(self) ws = self;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.windowBackView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(ws.changeLagView);
        make.top.equalTo(ws.changeLagView).offset(20) ;
        make.left.equalTo(ws.changeLagView).offset(5);
        make.bottom.equalTo(ws.changeLagView).offset(-20);
    }];
}
#pragma mark- UITabelViewDataSource/delegat
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellForChooseCountry *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if(cell == nil)
    {
        cell = [[CellForChooseCountry alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    if (indexPath == self.lastIndexPath) {
        [cell.Icon setImage:[UIImage imageNamed:@"icon_xuankuang_down"]];
    }else{
        [cell.Icon setImage:[UIImage imageNamed:@"icon_xuankuang"]];
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0){
            cell.name.text = @"+66";
            [cell.img setImage:[UIImage imageNamed:@"泰国"]];
        }else if (indexPath.row == 1){
            cell.name.text = @"+86";
             [cell.img setImage:[UIImage imageNamed:@"中国"]];
        }
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.lastIndexPath = indexPath;
    if (indexPath.row == 0) {
        self.CNLabel.text = @"+66";
        [self.countyBtn setImage:[UIImage imageNamed:@"泰国"]forState:UIControlStateNormal];
    }else{
        self.CNLabel.text = @"+86";
        [self.countyBtn setImage:[UIImage imageNamed:@"中国"]forState:UIControlStateNormal];
    }
    [self.tableView reloadData];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(void)closeWindow{
    [self.windowBackView removeFromSuperview];
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
