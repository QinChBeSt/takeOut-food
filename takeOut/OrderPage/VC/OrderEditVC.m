//
//  OrderEditVC.m
//  takeOut
//
//  Created by mac on 2018/4/9.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "OrderEditVC.h"

#define riderIconHeight 130
#define foodBZviewHeight 100
@interface OrderEditVC ()<UITextViewDelegate>
@property (nonatomic , strong)UIView *naviView;

@property (nonatomic , strong)UIView *riderView;
@property (nonatomic , strong)UIImageView *riderIcon;
@property (nonatomic , strong)UILabel *riderName;
@property (nonatomic , strong)UILabel *riderTime;
@property (nonatomic , strong)UIButton *riderGoodBtn;
@property (nonatomic , strong)UIButton *riderMidBtn;
@property (nonatomic , strong)UIButton *riderBadBtn;

@property (nonatomic , strong)UIView *foodView;
@property (nonatomic , strong)UIImageView *foodIcon;
@property (nonatomic , strong)UILabel *foodName;
@property (nonatomic , strong)UIButton *foodGoodBtn;
@property (nonatomic , strong)UIButton *foodMidBtn;
@property (nonatomic , strong)UIButton *foodBadBtn;
@property(nonatomic, strong)UITextView *textView;

@property(nonatomic, strong)UILabel *placeHolder;

@property (nonatomic , strong)NSString *riderSelectStr;
@property (nonatomic , strong)NSString *foodSelectStr;
@property (nonatomic , strong)NSString *BZStr;
@end

@implementation OrderEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
    [self createNaviView];
    [self setUpUI];
    // Do any additional setup after loading the view.
}
#pragma mark - ui
-(void)createNaviView{
    self.view.backgroundColor = [UIColor colorWithHexString:@"E8E8E8"];
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
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = ZBLocalized(@"评价", nil);
    titleLabel.textColor = [UIColor blackColor];
    [self.naviView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.centerY.equalTo(backImg);
    }];
}
-(void)setUpUI{
    __weak typeof(self) ws = self;
    self.riderView = [[UIView alloc]initWithFrame:CGRectMake(10, SafeAreaTopHeight + 15, SCREEN_WIDTH - 20,  riderIconHeight)];
    self.riderView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.riderView];
    
    self.riderIcon = [[UIImageView alloc]init];
    self.riderIcon.layer.cornerRadius=(riderIconHeight / 2 - 15 )/2;
    self.riderIcon.clipsToBounds = YES;
    [self.riderIcon setImage:[UIImage imageNamed:@"logo"]];
    [self.riderView addSubview:self.riderIcon];
    [self.riderIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.riderView.mas_left).offset(15);
        make.top.equalTo(ws.riderView.mas_top).offset(10);
        make.bottom.equalTo(ws.riderView.mas_centerY).offset(-5);
        make.width.equalTo(ws.riderIcon.mas_height);
    }];
    
    self.riderName = [[UILabel alloc]init];
    self.riderName.text = @"骑手名称";
    self.riderName.textColor = [UIColor lightGrayColor];
    [self.riderView addSubview:self.riderName];
    [self.riderName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.riderIcon.mas_centerY).offset(-3);
        make.left.equalTo(ws.riderIcon.mas_right).offset(10);
    }];
    
    self.riderTime = [[UILabel alloc]init];
    self.riderTime.text = @"4月1日12：30左右送达";
    self.riderTime.textColor = [UIColor lightGrayColor];
    [self.riderView addSubview:self.riderTime];
    [self.riderTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.riderIcon.mas_centerY).offset(3);
        make.left.equalTo(ws.riderIcon.mas_right).offset(10);
    }];
    
    
    UIView *midLine = [[UIView alloc]init];
    midLine.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
    [self.riderView addSubview:midLine];
    [midLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.riderView);
        make.left.equalTo(ws.riderView.mas_left).offset(15);
        make.top.equalTo(ws.riderView.mas_centerY).offset(10);
        make.height.equalTo(@(0.5));
    }];
    
    self.riderGoodBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.riderView addSubview:self.riderGoodBtn];
    self.riderGoodBtn.layer.cornerRadius=15;
    self.riderGoodBtn.clipsToBounds = YES;
    [self.riderGoodBtn setTitle:@"满意" forState:UIControlStateNormal];
    [self.riderGoodBtn addTarget:self action:@selector(goodForRider) forControlEvents:UIControlEventTouchUpInside];
    [self.riderGoodBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.riderGoodBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@((SCREEN_WIDTH - 20) / 3 - 80/3));
        make.left.equalTo(ws.riderView.mas_left).offset(20);
        make.top.equalTo(midLine.mas_bottom).offset(10);
        make.bottom.equalTo(ws.riderView.mas_bottom).offset(-10);
    }];
    
    self.riderMidBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.riderView addSubview:self.riderMidBtn];
    self.riderMidBtn.layer.cornerRadius=15;
    self.riderMidBtn.clipsToBounds = YES;
    [self.riderMidBtn setTitle:@"一般" forState:UIControlStateNormal];
    [self.riderMidBtn addTarget:self action:@selector(midForRider) forControlEvents:UIControlEventTouchUpInside];
    [self.riderMidBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.riderMidBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@((SCREEN_WIDTH - 20) / 3 - 80/3));
        make.left.equalTo(ws.riderGoodBtn.mas_right).offset(10);
        make.top.equalTo(midLine.mas_bottom).offset(10);
        make.bottom.equalTo(ws.riderView.mas_bottom).offset(-10);
    }];
    
    self.riderBadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.riderView addSubview:self.riderBadBtn];
    self.riderBadBtn.layer.cornerRadius=15;
    self.riderBadBtn.clipsToBounds = YES;
    [self.riderBadBtn setTitle:@"不满意" forState:UIControlStateNormal];
    [self.riderBadBtn addTarget:self action:@selector(badForRider) forControlEvents:UIControlEventTouchUpInside];
    [self.riderBadBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.riderBadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@((SCREEN_WIDTH - 20) / 3 - 80/3));
        make.left.equalTo(ws.riderMidBtn.mas_right).offset(10);
        make.top.equalTo(midLine.mas_bottom).offset(10);
        make.bottom.equalTo(ws.riderView.mas_bottom).offset(-10);
    }];
    
//////////////////////////////////
    self.foodView = [[UIView alloc]init];
    self.foodView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.foodView];
    [self.foodView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(SCREEN_WIDTH - 20));
        make.top.equalTo(ws.riderView.mas_bottom).offset(20);
        make.centerX.equalTo(ws.view);
        make.height.equalTo(@(riderIconHeight + foodBZviewHeight));
    }];
    
    self.foodIcon = [[UIImageView alloc]init];
    self.foodIcon.layer.cornerRadius=(riderIconHeight / 2 - 15 )/2;
    self.foodIcon.clipsToBounds = YES;
    [self.foodIcon setImage:[UIImage imageNamed:@"logo"]];
    [self.foodView addSubview:self.foodIcon];
    [self.foodIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.foodView.mas_left).offset(15);
        make.top.equalTo(ws.foodView.mas_top).offset(10);
        make.width.equalTo(ws.riderIcon.mas_width);
        make.height.equalTo(ws.riderIcon.mas_height);
    }];
    
    self.foodName = [[UILabel alloc]init];
    self.foodName.text = @"订单";
    self.foodName.textColor = [UIColor lightGrayColor];
    [self.foodView addSubview:self.foodName];
    [self.foodName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.foodIcon.mas_centerY);
        make.left.equalTo(ws.foodIcon.mas_right).offset(10);
    }];
    
    UIView *foodmidLine = [[UIView alloc]init];
    foodmidLine.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
    [self.foodView addSubview:foodmidLine];
    [foodmidLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.foodView);
        make.left.equalTo(ws.foodView.mas_left).offset(15);
        make.top.equalTo(ws.foodName.mas_bottom).offset(15);
        make.height.equalTo(@(0.5));
    }];
    
    self.foodGoodBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.foodView addSubview:self.foodGoodBtn];
    self.foodGoodBtn.layer.cornerRadius=15;
    self.foodGoodBtn.clipsToBounds = YES;
    [self.foodGoodBtn setTitle:@"满意" forState:UIControlStateNormal];
    [self.foodGoodBtn addTarget:self action:@selector(goodForFood) forControlEvents:UIControlEventTouchUpInside];
    [self.foodGoodBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.foodGoodBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@((SCREEN_WIDTH - 20) / 3 - 80/3));
        make.left.equalTo(ws.foodView.mas_left).offset(20);
        make.top.equalTo(foodmidLine.mas_bottom).offset(10);
        make.bottom.equalTo(ws.foodView.mas_bottom).offset(-10 - foodBZviewHeight);
    }];
    
    self.foodMidBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.foodView addSubview:self.foodMidBtn];
    self.foodMidBtn.layer.cornerRadius=15;
    self.foodMidBtn.clipsToBounds = YES;
    [self.foodMidBtn setTitle:@"一般" forState:UIControlStateNormal];
    [self.foodMidBtn addTarget:self action:@selector(midForFood) forControlEvents:UIControlEventTouchUpInside];
    [self.foodMidBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.foodMidBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@((SCREEN_WIDTH - 20) / 3 - 80/3));
        make.left.equalTo(ws.foodGoodBtn.mas_right).offset(10);
        make.top.equalTo(foodmidLine.mas_bottom).offset(10);
        make.bottom.equalTo(ws.foodView.mas_bottom).offset(-10 - foodBZviewHeight);
    }];
    
    self.foodBadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.foodView addSubview:self.foodBadBtn];
    self.foodBadBtn.layer.cornerRadius=15;
    self.foodBadBtn.clipsToBounds = YES;
    [self.foodBadBtn setTitle:@"不满意" forState:UIControlStateNormal];
    [self.foodBadBtn addTarget:self action:@selector(badForFood) forControlEvents:UIControlEventTouchUpInside];
    [self.foodBadBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.foodBadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@((SCREEN_WIDTH - 20) / 3 - 80/3));
        make.left.equalTo(ws.foodMidBtn.mas_right).offset(10);
        make.top.equalTo(foodmidLine.mas_bottom).offset(10);
        make.bottom.equalTo(ws.foodView.mas_bottom).offset(-10 - foodBZviewHeight);
    }];
    
    self.textView = [[UITextView alloc] init];
    self.textView.layer.borderWidth = 1;
    self.textView.delegate = self;
    self.textView.backgroundColor = [UIColor colorWithHexString:@"f2f2f2"];
    self.textView.font = [UIFont systemFontOfSize:14];
    self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
   [self.foodView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.top.equalTo(ws.foodGoodBtn.mas_bottom).offset(15);
        make.bottom.equalTo(ws.foodView.mas_bottom).offset(-10);
        make.left.equalTo(ws.foodView.mas_left).offset(10);
    }];
    
    self.placeHolder = [[UILabel alloc]init];
    self.placeHolder.textColor = [UIColor lightGrayColor];
    self.placeHolder.font = [UIFont systemFontOfSize:14];
    self.placeHolder.text = ZBLocalized(@"对菜品口味，包装服务的还满意吗？您可以在此处输入您的想法与意见~（至少输入8个字）", nil);
    self.placeHolder.numberOfLines = 3;
    [self.foodView addSubview:self.placeHolder];
    [self.placeHolder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.textView.mas_top).offset(8);
        make.left.equalTo(ws.textView.mas_left).offset(8);
        make.right.equalTo(ws.textView.mas_right).offset(-3);
    }];
   
    UIButton *toGetNetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:toGetNetBtn];
    [toGetNetBtn setTitle:@"提交" forState:UIControlStateNormal];
    toGetNetBtn.backgroundColor = [UIColor colorWithHexString:BaseYellow];
    [toGetNetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [toGetNetBtn addTarget:self action:@selector(getNetWork) forControlEvents:UIControlEventTouchUpInside];
    [toGetNetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.top.equalTo(ws.foodView.mas_bottom).offset(20);
        make.left.equalTo(ws.foodView.mas_left).offset(10);
        make.height.equalTo(@(30));
    }];
}
#pragma mark - 点击事件
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)goodForRider{
    self.riderSelectStr = @"1";
    [self.riderGoodBtn setBackgroundColor:[UIColor colorWithHexString:BaseYellow]];
    [self.riderGoodBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.riderMidBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.riderMidBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.riderBadBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.riderBadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}
-(void)midForRider{
    self.riderSelectStr = @"3";
    [self.riderMidBtn setBackgroundColor:[UIColor colorWithHexString:BaseYellow]];
    [self.riderMidBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
   
    
    [self.riderGoodBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.riderGoodBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.riderBadBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.riderBadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
-(void)badForRider{
    self.riderSelectStr = @"2";
    [self.riderBadBtn setBackgroundColor:[UIColor colorWithHexString:BaseYellow]];
    [self.riderBadBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    [self.riderMidBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.riderMidBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.riderGoodBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.riderGoodBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
////////////////

-(void)goodForFood{
    self.foodSelectStr = @"1";
    [self.foodGoodBtn setBackgroundColor:[UIColor colorWithHexString:BaseYellow]];
    [self.foodGoodBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.foodMidBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.foodMidBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.foodBadBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.foodBadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}
-(void)midForFood{
    self.foodSelectStr = @"3";
    [self.foodMidBtn setBackgroundColor:[UIColor colorWithHexString:BaseYellow]];
    [self.foodMidBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    [self.foodGoodBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.foodGoodBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.foodBadBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.foodBadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
-(void)badForFood{
    self.foodSelectStr = @"2";
    [self.foodBadBtn setBackgroundColor:[UIColor colorWithHexString:BaseYellow]];
    [self.foodBadBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    [self.foodMidBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.foodMidBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.foodGoodBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.foodGoodBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //[text isEqualToString:@""] 表示输入的是退格键
    if (![text isEqualToString:@""])
    {
        self.placeHolder.hidden = YES;
       
    }
    
    //range.location == 0 && range.length == 1 表示输入的是第一个字符
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
        
    {
        self.placeHolder.hidden = NO;
    }
    return YES;
    
}
-(void)textViewDidChange:(UITextView *)textView{
    self.BZStr = textView.text;
}
-(void)getNetWork{
    if (_BZStr.length < 8) {
        [MBManager showBriefAlert:ZBLocalized(@"最少输入八个字", nil)];
    }else if (_riderSelectStr.length == 0 ){
        [MBManager showBriefAlert:ZBLocalized(@"请选择配送员评价", nil)];
    }else if (_foodSelectStr.length == 0){
        [MBManager showBriefAlert:ZBLocalized(@"请选择订单评价", nil)];
    }
    else{
        NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,aveOrderUrl];
        NSDictionary *parameters = @{@"ordernum":self.orderId,
                                     @"evatext":self.BZStr,
                                     @"shopeva":self.foodSelectStr,
                                     @"orevas":self.riderSelectStr
                                     };
        AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
        //请求的方式：POST
        [managers POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSString *code =[NSString stringWithFormat:@"%@",responseObject[@"code"]];
            if ([code isEqualToString:@"1"]) {
                [MBManager showBriefAlert:@"评价成功"];
                [self performSelector:@selector(back) withObject:nil/*可传任意类型参数*/ afterDelay:2.0];
            }else{
                [MBManager showBriefAlert:@"评价失败"];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
    
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
