//
//  OrderEditVC.m
//  takeOut
//
//  Created by mac on 2018/4/9.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "OrderEditVC.h"

#define riderIconHeight SCREENH_HEIGHT/4
#define foodBZviewHeight SCREENH_HEIGHT* 0.1912 + 20
@interface OrderEditVC ()<UITextViewDelegate>
@property (nonatomic , strong)UIView *naviView;

@property (nonatomic , strong)UIView *riderView;
@property (nonatomic , strong)UIImageView *riderIcon;
@property (nonatomic , strong)UILabel *riderName;
@property (nonatomic , strong)UILabel *riderTime;

@property (nonatomic , strong)UIButton *riderGoodBtn;
@property (nonatomic , strong)UIButton *riderMidBtn;
@property (nonatomic , strong)UIButton *riderBadBtn;
@property (nonatomic , strong)UIImageView *riderGoodImg;
@property (nonatomic , strong)UIImageView *riderMidImg;
@property (nonatomic , strong)UIImageView *riderBadImg;
@property (nonatomic , strong)UILabel *riderGoodLab;
@property (nonatomic , strong)UILabel *riderMidLab;
@property (nonatomic , strong)UILabel *riderBadLab;


@property (nonatomic , strong)UIView *foodView;
@property (nonatomic , strong)UIImageView *foodIcon;
@property (nonatomic , strong)UILabel *foodName;

@property (nonatomic , strong)UIButton *foodGoodBtn;
@property (nonatomic , strong)UIButton *foodMidBtn;
@property (nonatomic , strong)UIButton *foodBadBtn;
@property (nonatomic , strong)UIImageView *foodGoodImg;
@property (nonatomic , strong)UIImageView *foodMidImg;
@property (nonatomic , strong)UIImageView *foodBadImg;
@property (nonatomic , strong)UILabel *foodGoodLab;
@property (nonatomic , strong)UILabel *foodMidLab;
@property (nonatomic , strong)UILabel *foodBadLab;

@property(nonatomic, strong)UITextView *textView;

@property(nonatomic, strong)UILabel *placeHolder;

@property (nonatomic , strong)NSString *riderSelectStr;
@property (nonatomic , strong)NSString *foodSelectStr;
@property (nonatomic , strong)NSString *BZStr;

@property (nonatomic , strong)UIView *SwipeView;
@end

@implementation OrderEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
    [self createNaviView];
    [self setUpUI];
    [self getNetworkForOrderMag];
    
     [self addNoticeForKeyboard];
}

- (void)addNoticeForKeyboard {
    
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view removeGestureRecognizer:singleTapGR];
                }];
}
- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    [self.view endEditing:YES];
}

///键盘显示事件
- (void) keyboardWillShow:(NSNotification *)notification {
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    
    //计算出键盘顶端到inputTextView panel底端的距离(加上自定义的缓冲距离INTERVAL_KEYBOARD)
    CGFloat offset ;
    
    offset =  kbHeight;
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //将视图上移计算好的偏移
    if(offset > 0) {
        [UIView animateWithDuration:duration animations:^{
            self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
    UIWindow*keyWindow = [[UIApplication sharedApplication].windows lastObject];
    
    CGFloat HEIGHT = SCREENH_HEIGHT - 0.6912 * SCREENH_HEIGHT - 40;
    self.SwipeView = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREENH_HEIGHT - SafeAreaTopHeight - offset - HEIGHT)];
    [keyWindow addSubview:self.SwipeView];
    UISwipeGestureRecognizer *recognizer;
    
    
    
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    
    
    
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    
    
    
    [self.SwipeView addGestureRecognizer:recognizer];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    
    
    
    //将手势添加到需要相应的view中去
    
    [self.SwipeView addGestureRecognizer:tapGesture];
    
    
    
    //选择触发事件的方式（默认单机触发）
    
    [tapGesture setNumberOfTapsRequired:1];
    
}
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    // 键盘动画时间
    [self.view endEditing:YES];
    [self.SwipeView removeFromSuperview];
    //视图下沉恢复原状
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [self.SwipeView removeFromSuperview];
    }];
}
///键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
}

-(void)getNetworkForOrderMag{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,getOrderDetailURL];
    NSDictionary *parameters = @{@"ordernum":self.orderId,
                                
                                 };
    AFHTTPSessionManager *managers = [AFHTTPSessionManager manager];
    //请求的方式：POST
    [managers POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([code isEqualToString:@"1"]) {
            NSDictionary *dic = responseObject[@"value"];
            self.riderName.text = dic[@"originallyname"];
            self.riderTime.text = dic[@"orderdt"];
            self.foodName.text = dic[@"shopname"];
        }else{
            [MBManager showBriefAlert:responseObject[@"msg"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
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
    self.riderView = [[UIView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + 10, SCREEN_WIDTH,  riderIconHeight)];
    self.riderView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.riderView];
    
    self.riderIcon = [[UIImageView alloc]init];
    self.riderIcon.layer.cornerRadius=(0.0712* SCREENH_HEIGHT )/2;
    self.riderIcon.clipsToBounds = YES;
    [self.riderIcon setImage:[UIImage imageNamed:@"logo"]];
    [self.riderView addSubview:self.riderIcon];
    [self.riderIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.riderView.mas_left).offset(15);
        make.top.equalTo(ws.riderView.mas_top).offset(10);
        make.height.equalTo(@(0.0712* SCREENH_HEIGHT));
        make.width.equalTo(ws.riderIcon.mas_height);
    }];
    
    self.riderName = [[UILabel alloc]init];
    self.riderName.text = @"骑手名称";
    self.riderName.font = [UIFont systemFontOfSize:14];
    self.riderName.textColor = [UIColor colorWithHexString:@"4b4b4b"];
    [self.riderView addSubview:self.riderName];
    [self.riderName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.riderIcon.mas_centerY).offset(-3);
        make.left.equalTo(ws.riderIcon.mas_right).offset(20);
    }];
    
    self.riderTime = [[UILabel alloc]init];
    self.riderTime.text = @"4月1日12：30左右送达";
    self.riderTime.font = [UIFont systemFontOfSize:14];
    self.riderTime.textColor = [UIColor colorWithHexString:@"4b4b4b"];
    [self.riderView addSubview:self.riderTime];
    [self.riderTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.riderIcon.mas_centerY).offset(3);
        make.left.equalTo(ws.riderIcon.mas_right).offset(20);
    }];
    
    
    UIView *midLine = [[UIView alloc]init];
    midLine.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
    [self.riderView addSubview:midLine];
    [midLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.riderView);
        make.left.equalTo(ws.riderView.mas_left).offset(15);
        make.top.equalTo(ws.riderIcon.mas_bottom).offset(10);
        make.height.equalTo(@(0.5));
    }];
    
    self.riderGoodImg = [[UIImageView alloc]init];
    self.riderGoodImg.image = [UIImage imageNamed:@"icon_pingjiamanyi"];
    [self.riderView addSubview:self.riderGoodImg];
    [self.riderGoodImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(0.36 * SCREEN_WIDTH / 3));
        make.left.equalTo(ws.riderView.mas_left).offset(0.16 *SCREEN_WIDTH);
        make.top.equalTo(midLine.mas_bottom).offset(SCREENH_HEIGHT * 0.0112);
        make.height.equalTo(@(0.36 * SCREEN_WIDTH / 3 / 90 * 103));
    }];
    
    self.riderGoodLab = [[UILabel alloc]init];
    self.riderGoodLab.textAlignment = NSTextAlignmentCenter;
    self.riderGoodLab.textColor = [UIColor colorWithHexString:@"959595"];
    self.riderGoodLab.text = ZBLocalized(@"满意", nil);
    [self.riderView addSubview:self.riderGoodLab];
    [self.riderGoodLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.riderGoodImg);
        make.top.equalTo(ws.riderGoodImg.mas_bottom).offset(5);
        make.bottom.equalTo(ws.riderView.mas_bottom).offset(-5);
        make.right.equalTo(ws.riderGoodImg.mas_right).offset(0.075 *SCREEN_WIDTH);
    }];
    self.riderGoodBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.riderView addSubview:self.riderGoodBtn];
    [self.riderGoodBtn addTarget:self action:@selector(goodForRider) forControlEvents:UIControlEventTouchUpInside];
    //[self.riderGoodBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.riderGoodBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.riderGoodLab);
        make.left.equalTo(ws.riderGoodLab.mas_left);
        make.top.equalTo(midLine.mas_bottom).offset(5);
        make.bottom.equalTo(ws.riderView.mas_bottom).offset(-5);
    }];
    
    
    self.riderMidImg = [[UIImageView alloc]init];
    self.riderMidImg.image = [UIImage imageNamed:@"icon_pingjiayiban"];
    [self.riderView addSubview:self.riderMidImg];
    [self.riderMidImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(0.36 * SCREEN_WIDTH / 3));
        make.left.equalTo(ws.riderGoodImg.mas_right).offset(0.16 *SCREEN_WIDTH);
        make.top.equalTo(midLine.mas_bottom).offset(SCREENH_HEIGHT * 0.0112);
        make.height.equalTo(@(0.36 * SCREEN_WIDTH / 3 / 90 * 103));
    }];
    
    self.riderMidLab = [[UILabel alloc]init];
    self.riderMidLab.textAlignment = NSTextAlignmentCenter;
    self.riderMidLab.textColor = [UIColor colorWithHexString:@"959595"];
    self.riderMidLab.text = ZBLocalized(@"一般", nil);
    [self.riderView addSubview:self.riderMidLab];
    [self.riderMidLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.riderMidImg);
        make.top.equalTo(ws.riderMidImg.mas_bottom).offset(5);
        make.bottom.equalTo(ws.riderView.mas_bottom).offset(-5);
        make.right.equalTo(ws.riderMidImg.mas_right).offset(0.075 *SCREEN_WIDTH);
    }];
    
    self.riderMidBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.riderView addSubview:self.riderMidBtn];
    [self.riderMidBtn addTarget:self action:@selector(midForRider) forControlEvents:UIControlEventTouchUpInside];
    //[self.riderMidBtn setBackgroundColor:[UIColor lightGrayColor]];
    [self.riderMidBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.riderMidImg);
        make.left.equalTo(ws.riderMidLab.mas_left);
        make.top.equalTo(midLine.mas_bottom).offset(5);
        make.bottom.equalTo(ws.riderView.mas_bottom).offset(-5);
    }];
    
    
    self.riderBadImg = [[UIImageView alloc]init];
    self.riderBadImg.image = [UIImage imageNamed:@"icon_pingjiabumanyi"];
    [self.riderView addSubview:self.riderBadImg];
    [self.riderBadImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(0.36 * SCREEN_WIDTH / 3));
        make.left.equalTo(ws.riderMidImg.mas_right).offset(0.16 *SCREEN_WIDTH);
        make.top.equalTo(midLine.mas_bottom).offset(SCREENH_HEIGHT * 0.0112);
        make.height.equalTo(@(0.36 * SCREEN_WIDTH / 3 / 90 * 103));
    }];
    
    self.riderBadLab = [[UILabel alloc]init];
    self.riderBadLab.textAlignment = NSTextAlignmentCenter;
    self.riderBadLab.textColor = [UIColor colorWithHexString:@"959595"];
    self.riderBadLab.text = ZBLocalized(@"不满意", nil);
    [self.riderView addSubview:self.riderBadLab];
    [self.riderBadLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.riderBadImg);
        make.top.equalTo(ws.riderBadImg.mas_bottom).offset(5);
        make.bottom.equalTo(ws.riderView.mas_bottom).offset(-5);
        make.right.equalTo(ws.riderBadImg.mas_right).offset(0.075 *SCREEN_WIDTH);
    }];

    self.riderBadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.riderView addSubview:self.riderBadBtn];
    [self.riderBadBtn addTarget:self action:@selector(badForRider) forControlEvents:UIControlEventTouchUpInside];
    [self.riderBadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.riderBadImg);
        make.left.equalTo(ws.riderBadLab.mas_left);
        make.top.equalTo(midLine.mas_bottom).offset(5);
        make.bottom.equalTo(ws.riderView.mas_bottom).offset(-5);
    }];
    
//////////////////////////////////
    self.foodView = [[UIView alloc]init];
    self.foodView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.foodView];
    [self.foodView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(SCREEN_WIDTH ));
        make.top.equalTo(ws.riderView.mas_bottom).offset(10);
        make.centerX.equalTo(ws.view);
        make.height.equalTo(@(riderIconHeight + foodBZviewHeight));
    }];
    
    self.foodIcon = [[UIImageView alloc]init];
    self.foodIcon.layer.cornerRadius=(0.0712* SCREENH_HEIGHT )/2;
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
    self.foodName.textColor = [UIColor colorWithHexString:@"4b4b4b"];
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
        make.top.equalTo(ws.foodIcon.mas_bottom).offset(10);
        make.height.equalTo(@(0.5));
    }];
    
    self.foodGoodImg = [[UIImageView alloc]init];
    self.foodGoodImg.image = [UIImage imageNamed:@"icon_pingjiamanyi"];
    [self.foodView addSubview:self.foodGoodImg];
    [self.foodGoodImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(0.36 * SCREEN_WIDTH / 3));
        make.left.equalTo(ws.foodView.mas_left).offset(0.16 *SCREEN_WIDTH);
        make.top.equalTo(foodmidLine.mas_bottom).offset(SCREENH_HEIGHT * 0.0112);
        make.height.equalTo(@(0.36 * SCREEN_WIDTH / 3 / 90 * 103));
    }];
    
    self.foodGoodLab = [[UILabel alloc]init];
    self.foodGoodLab.textAlignment = NSTextAlignmentCenter;
    self.foodGoodLab.textColor = [UIColor colorWithHexString:@"959595"];
    self.foodGoodLab.text = ZBLocalized(@"满意", nil);
    [self.foodView addSubview:self.foodGoodLab];
    [self.foodGoodLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.foodGoodImg);
        make.top.equalTo(ws.foodGoodImg.mas_bottom).offset(5);
        make.height.equalTo(ws.riderGoodLab);
        make.right.equalTo(ws.foodGoodImg.mas_right).offset(0.075 *SCREEN_WIDTH);
    }];
    
    self.foodGoodBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.foodView addSubview:self.foodGoodBtn];
   
    [self.foodGoodBtn addTarget:self action:@selector(goodForFood) forControlEvents:UIControlEventTouchUpInside];
    [self.foodGoodBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@((SCREEN_WIDTH - 20) / 3 - 80/3));
        make.left.equalTo(ws.foodView.mas_left).offset(20);
        make.top.equalTo(foodmidLine.mas_bottom).offset(10);
        make.bottom.equalTo(ws.foodView.mas_bottom).offset(-10 - foodBZviewHeight);
    }];
    
    
    self.foodMidImg = [[UIImageView alloc]init];
    self.foodMidImg.image = [UIImage imageNamed:@"icon_pingjiamanyi"];
    [self.foodView addSubview:self.foodMidImg];
    [self.foodMidImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(0.36 * SCREEN_WIDTH / 3));
        make.left.equalTo(ws.foodGoodImg.mas_right).offset(0.16 *SCREEN_WIDTH);
        make.top.equalTo(foodmidLine.mas_bottom).offset(SCREENH_HEIGHT * 0.0112);
        make.height.equalTo(@(0.36 * SCREEN_WIDTH / 3 / 90 * 103));
    }];
    
    self.foodMidLab = [[UILabel alloc]init];
    self.foodMidLab.textAlignment = NSTextAlignmentCenter;
    self.foodMidLab.textColor = [UIColor colorWithHexString:@"959595"];
    self.foodMidLab.text = ZBLocalized(@"一般", nil);
    [self.foodView addSubview:self.foodMidLab];
    [self.foodMidLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.foodMidImg);
        make.top.equalTo(ws.foodMidImg.mas_bottom).offset(5);
        make.height.equalTo(ws.riderMidLab);
        make.right.equalTo(ws.foodMidImg.mas_right).offset(0.075 *SCREEN_WIDTH);
    }];
    
    self.foodMidBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.foodView addSubview:self.foodMidBtn];
    [self.foodMidBtn addTarget:self action:@selector(midForFood) forControlEvents:UIControlEventTouchUpInside];
    [self.foodMidBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.foodMidImg);
        make.left.equalTo(ws.foodMidLab.mas_left);
        make.top.equalTo(foodmidLine.mas_bottom).offset(5);
        make.height.equalTo(ws.riderMidBtn.mas_height);
    }];
    
    
    self.foodBadImg = [[UIImageView alloc]init];
    self.foodBadImg.image = [UIImage imageNamed:@"icon_pingjiamanyi"];
    [self.foodView addSubview:self.foodBadImg];
    [self.foodBadImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(0.36 * SCREEN_WIDTH / 3));
        make.left.equalTo(ws.foodMidImg.mas_right).offset(0.16 *SCREEN_WIDTH);
        make.top.equalTo(foodmidLine.mas_bottom).offset(SCREENH_HEIGHT * 0.0112);
        make.height.equalTo(@(0.36 * SCREEN_WIDTH / 3 / 90 * 103));
    }];
    
    self.foodBadLab = [[UILabel alloc]init];
    self.foodBadLab.textAlignment = NSTextAlignmentCenter;
    self.foodBadLab.textColor = [UIColor colorWithHexString:@"959595"];
    self.foodBadLab.text = ZBLocalized(@"不满意", nil);
    [self.foodView addSubview:self.foodBadLab];
    [self.foodBadLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.foodBadImg);
        make.top.equalTo(ws.foodMidImg.mas_bottom).offset(5);
        make.height.equalTo(ws.riderMidLab);
        make.right.equalTo(ws.foodBadImg.mas_right).offset(0.075 *SCREEN_WIDTH);
    }];
    self.foodBadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.foodView addSubview:self.foodBadBtn];
    [self.foodBadBtn addTarget:self action:@selector(badForFood) forControlEvents:UIControlEventTouchUpInside];
    [self.foodBadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.foodBadImg);
        make.left.equalTo(ws.foodBadLab.mas_left);
        make.top.equalTo(foodmidLine.mas_bottom).offset(5);
        make.height.equalTo(ws.riderMidBtn.mas_height);
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
        make.top.equalTo(ws.foodMidLab.mas_bottom).offset(15);
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
    toGetNetBtn.layer.cornerRadius=10;
    
    toGetNetBtn.clipsToBounds = YES;
    [toGetNetBtn setTitle:ZBLocalized(@"提交", nil) forState:UIControlStateNormal];
    toGetNetBtn.backgroundColor = [UIColor colorWithHexString:BaseYellow];
    [toGetNetBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [toGetNetBtn addTarget:self action:@selector(getNetWork) forControlEvents:UIControlEventTouchUpInside];
    [toGetNetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.top.equalTo(ws.foodView.mas_bottom).offset(20);
        make.left.equalTo(ws.foodView.mas_left).offset(10);
        make.height.equalTo(@(40));
    }];
}
#pragma mark - 点击事件
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)goodForRider{
    self.riderSelectStr = @"1";
    self.riderGoodLab.textColor = [UIColor colorWithHexString:BaseYellow];
    self.riderGoodImg.image = [UIImage imageNamed:@"icon_pingjiamanyi_down"];
    
    self.riderMidLab.textColor = [UIColor colorWithHexString:@"959595"];
    self.riderMidImg.image = [UIImage imageNamed:@"icon_pingjiayiban"];
    
    self.riderBadLab.textColor = [UIColor colorWithHexString:@"959595"];
    self.riderBadImg.image = [UIImage imageNamed:@"icon_pingjiabumanyi"];
}
-(void)midForRider{
    self.riderSelectStr = @"3";
    self.riderGoodLab.textColor = [UIColor colorWithHexString:@"959595"];
    self.riderGoodImg.image = [UIImage imageNamed:@"icon_pingjiamanyi"];
    
    self.riderMidLab.textColor = [UIColor colorWithHexString:BaseYellow];
    self.riderMidImg.image = [UIImage imageNamed:@"icon_pingjiayiban_down"];
    
    self.riderBadLab.textColor = [UIColor colorWithHexString:@"959595"];
    self.riderBadImg.image = [UIImage imageNamed:@"icon_pingjiabumanyi"];
}
-(void)badForRider{
    self.riderSelectStr = @"2";
    self.riderGoodLab.textColor = [UIColor colorWithHexString:@"959595"];
    self.riderGoodImg.image = [UIImage imageNamed:@"icon_pingjiamanyi"];
    
    self.riderMidLab.textColor = [UIColor colorWithHexString:@"959595"];
    self.riderMidImg.image = [UIImage imageNamed:@"icon_pingjiayiban"];
    
    self.riderBadLab.textColor = [UIColor colorWithHexString:BaseYellow];
    self.riderBadImg.image = [UIImage imageNamed:@"icon_pingjiabumanyi_down"];
}
////////////////

-(void)goodForFood{
    self.foodSelectStr = @"1";
    self.foodGoodLab.textColor = [UIColor colorWithHexString:BaseYellow];
    self.foodGoodImg.image = [UIImage imageNamed:@"icon_pingjiamanyi_down"];
    
    self.foodMidLab.textColor = [UIColor colorWithHexString:@"959595"];
    self.foodMidImg.image = [UIImage imageNamed:@"icon_pingjiayiban"];
    
    self.foodBadLab.textColor = [UIColor colorWithHexString:@"959595"];
    self.foodBadImg.image = [UIImage imageNamed:@"icon_pingjiabumanyi"];
    
}
-(void)midForFood{
    self.foodSelectStr = @"3";
    self.foodGoodLab.textColor = [UIColor colorWithHexString:@"959595"];
    self.foodGoodImg.image = [UIImage imageNamed:@"icon_pingjiamanyi"];
    
    self.foodMidLab.textColor = [UIColor colorWithHexString:BaseYellow];
    self.foodMidImg.image = [UIImage imageNamed:@"icon_pingjiayiban_down"];
    
    self.foodBadLab.textColor = [UIColor colorWithHexString:@"959595"];
    self.foodBadImg.image = [UIImage imageNamed:@"icon_pingjiabumanyi"];
}
-(void)badForFood{
    self.foodSelectStr = @"2";
    self.foodGoodLab.textColor = [UIColor colorWithHexString:@"959595"];
    self.foodGoodImg.image = [UIImage imageNamed:@"icon_pingjiamanyi"];
    
    self.foodMidLab.textColor = [UIColor colorWithHexString:@"959595"];
    self.foodMidImg.image = [UIImage imageNamed:@"icon_pingjiayiban"];
    
    self.foodBadLab.textColor = [UIColor colorWithHexString:BaseYellow];
    self.foodBadImg.image = [UIImage imageNamed:@"icon_pingjiabumanyi_down"];
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
