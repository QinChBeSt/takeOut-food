//
//  bzDetailVC.m
//  takeOut
//
//  Created by mac on 2018/6/8.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "bzDetailVC.h"

@interface bzDetailVC ()<UITextViewDelegate>
@property (nonatomic , strong)UIView *naviView;
@property (nonatomic , strong)UITextView *textView;

@property (nonatomic , strong)UILabel *plaLab;
@end

@implementation bzDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNaviView];
    // Do any additional setup after loading the view.
}
#pragma mark - ui
-(void)createNaviView{
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
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
    
    UIButton *SureBTN = [UIButton buttonWithType:UIButtonTypeCustom];
    [SureBTN setTitle:ZBLocalized(@"完成", nil) forState:UIControlStateNormal];
    [SureBTN addTarget:self action:@selector(cheakAdd) forControlEvents:UIControlEventTouchUpInside];
    [SureBTN setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.naviView addSubview:SureBTN];
    [SureBTN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.naviView.mas_top).offset(SafeAreaStatsBarHeight);
        make.right.equalTo(ws.naviView.mas_right).offset(-10);
        make.width.equalTo(@(40));
        make.height.equalTo(@(SafeAreaTopHeight - SafeAreaStatsBarHeight));
    }];
    
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = ZBLocalized(@"提交订单", nil);
    titleLabel.textColor = [UIColor blackColor];
    [self.naviView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.centerY.equalTo(backImg);
    }];
    
       self.textView = [[UITextView alloc]init];
        self.textView.font = [UIFont systemFontOfSize:16];
        self.textView.delegate = self;
        self.textView.layer.cornerRadius=10;
        self.textView.backgroundColor = [UIColor whiteColor];
        self.textView.clipsToBounds = YES;
    self.textView.layer.borderColor = [UIColor colorWithHexString:@"e7e7e7"].CGColor;
    self.textView.layer.borderWidth = 1;
        [self.view addSubview:self.textView];
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(ws.view);
            make.left.equalTo(ws.view.mas_left).offset(20);
            make.top.equalTo(ws.naviView.mas_bottom).offset(20);
            make.height.equalTo(@(SCREENH_HEIGHT / 3));
        }];
    self.plaLab = [[UILabel alloc]init];
    self.plaLab.text = ZBLocalized(@"口味、偏好等要求", nil);
    self.plaLab.textColor = [UIColor colorWithHexString:@"959595"];
    [self.textView addSubview:self.plaLab];
    [self.plaLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.textView.mas_left).offset(5);
        make.top.equalTo(ws.textView.mas_top).offset(6);
    }];
    if (self.bzStr.length != 0) {
        self.plaLab.hidden = YES;
        self.textView.text = self.bzStr;
    }
    
}
#pragma mark - 点击事件
-(void)cheakAdd{
    if (self.blockChooseBz) {
        self.blockChooseBz(self.bzStr);
    }
    [self back];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)textViewDidChange:(UITextView *)textView{
    self.plaLab.hidden =YES;
    self.bzStr = textView.text;
    if (textView.text.length > 0) {
        // 禁止系统表情的输入
        NSString *text = [self disable_emoji:[textView text]];
        if (![text isEqualToString:textView.text]) {
            NSRange textRange = [textView selectedRange];
            textView.text = text;
            [textView setSelectedRange:textRange];
        }
    }
    
}
- (NSString *)disable_emoji:(NSString *)text{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]"options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
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
