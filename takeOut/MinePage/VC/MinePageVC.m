//
//  MinePageVC.m
//  takeOut
//
//  Created by mac on 2018/3/23.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "MinePageVC.h"
#import "NewLoginByPhoneVC.h"
#import "FileTool.h"
#import "MineAddressVC.h"
#import "MyEvaVC.h"
#import "AboutusVC.h"
#import "ChangelanguageVC.h"
#import "CollectionViewCellForHomePageChoose.h"
#import "EXTabBarVC.h"
#import "CellForChooseLag.h"
@interface MinePageVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) UIImageView *headView;
@property (nonatomic , strong) UIImageView *headIamge;
@property (nonatomic , strong) UILabel *userName;
@property (nonatomic , strong) UILabel *userPhone;
//判断是否登录，Cell行数
@property (nonatomic , assign) NSInteger isLoginOut;
//清理缓存
@property (nonatomic, assign) NSInteger totalSize;
@property (nonatomic , strong)UICollectionView *collectionView;
@property (nonatomic , strong)UICollectionView *BUttomcollectionView;
#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
@property (nonatomic , strong)UIButton *LogOutBtn;
@property (nonatomic , strong)UIView *windowBackView;
@property (nonatomic , strong)UIView *changeLagView;
@property (nonatomic , strong)UIView *logOutView;
@property (nonatomic , strong)NSIndexPath *lastIndexPath;
@end

@implementation MinePageVC
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:YES];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [defaults objectForKey:UD_USERNAME];
    NSString *userID = [defaults objectForKey:UD_USERID];
    NSString *userPhine = [defaults objectForKey:UD_USERPHONE];
    if (userID == nil || [userID isEqualToString:@""]) {
        self.userName.text = ZBLocalized(@"登录", nil);
        self.userPhone.text = @"";
        _isLoginOut = 0;
        self.LogOutBtn.hidden = YES;
    }else{
    self.userName.text = userName;
    self.userPhone.text = userPhine;
        _isLoginOut = 1;
        self.LogOutBtn.hidden = NO;
    }
    //[self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:BaseBackgroundGray];
    [FileTool getFileSize:CachePath completion:^(NSInteger totalSize) {
        
        _totalSize = totalSize;
        
        //[self.tableView reloadData];
        
    }];
    [self createHeadView];
    
    [self createMidView];
    [self createButtomTools];
    
    self.LogOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.LogOutBtn.backgroundColor = [UIColor whiteColor];
    [self.LogOutBtn setTitle:ZBLocalized(@"退出登录", nil) forState:UIControlStateNormal];
    [self.LogOutBtn addTarget:self action:@selector(createLogoutView) forControlEvents:UIControlEventTouchUpInside];
    [self.LogOutBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.view addSubview:self.LogOutBtn];
    [self.LogOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset( - 10);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@(45));
    }];
    //[self createTableView];
    // Do any additional setup after loading the view.
}
-(void)createHeadView{
    self.headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SafeAreaStatsBarHeight + SCREENH_HEIGHT/3)];
    [self.headView setImage:[UIImage imageNamed:@"bg_gerenzhongxin"]];
    [self.view addSubview:self.headView];
    __weak typeof(self) ws = self;
    self.headIamge = [[UIImageView alloc]init];
    self.headIamge.layer.cornerRadius=35;
    self.headIamge.clipsToBounds = YES;
    self.headIamge.layer.borderWidth = 0.5;
    self.headIamge.layer.borderColor = [[UIColor blackColor] CGColor];
    [self.headIamge setImage:[UIImage imageNamed:@"icon_touxiang"]];
    [self.headView addSubview:self.headIamge];
    [self.headIamge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.headView);
        make.centerY.equalTo(ws.headView.mas_centerY).offset(-10);
        make.width.equalTo(@(70));
        make.height.equalTo(@(70));
    }];
    
   
    self.userName = [[UILabel alloc]init];
    self.userName.font = [UIFont systemFontOfSize:18];
    [self.headView addSubview:self.userName];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.headIamge);
        make.top.equalTo(ws.headIamge.mas_bottom).offset(10);
    }];
    
    self.userPhone = [[UILabel alloc]init];
    self.userPhone.font = [UIFont systemFontOfSize:16];
    [self.headView addSubview:self.userPhone];
    [self.userPhone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.headIamge);
        make.top.equalTo(ws.userName.mas_bottom).offset(5);
    }];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn addTarget:self action:@selector(toLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.headIamge);
        make.width.equalTo(ws.headView);
        make.top.equalTo(ws.headIamge.mas_bottom).offset(5);
        make.bottom.equalTo(ws.headView.mas_bottom);
    }];
    
    UIButton *iconLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [iconLoginBtn addTarget:self action:@selector(toLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:iconLoginBtn];
    [iconLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.headView);
        make.centerY.equalTo(ws.headView.mas_centerY).offset(-10);
        make.width.equalTo(@(70));
        make.height.equalTo(@(70));
    }];
}
-(void)createMidView{
    __weak typeof(self) ws = self;
    UIView *topLine = [[UIView alloc]init];
    [self.view addSubview:topLine];
    topLine.backgroundColor = [UIColor colorWithHexString:BaseBackgroundGray];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.width.equalTo(ws.view);
        make.top.equalTo(ws.headView.mas_bottom);
        make.height.equalTo(@(10));
    }];
    CGFloat itemWidth = (SCREEN_WIDTH - 3 )/ 4;
    CGFloat itemHeight = (SCREEN_WIDTH - 3 ) / 4 + 10;
    UICollectionViewFlowLayout *shareflowLayout = [[UICollectionViewFlowLayout alloc] init];
    shareflowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    shareflowLayout.sectionInset = UIEdgeInsetsMake(1, (SCREEN_WIDTH - 3) / 4 / 3/2, 1,(SCREEN_WIDTH - 3) / 4 / 3/2);
    shareflowLayout.itemSize =CGSizeMake(itemWidth, itemHeight);
    // 1.设置列间距
    shareflowLayout.minimumInteritemSpacing = (SCREEN_WIDTH - 3) / 4 / 3;
    // 2.设置行间距
    shareflowLayout.minimumLineSpacing = 0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:shareflowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[CollectionViewCellForHomePageChoose class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.delaysContentTouches = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLine.mas_bottom);
        make.width.equalTo(ws.view);
        make.centerX.equalTo(ws.view);
        make.height.equalTo(@(SCREEN_WIDTH / 4 + 10));
    }];
    
}
-(void)createButtomTools{
    __weak typeof(self) ws = self;
    UIView *topLine = [[UIView alloc]init];
    [self.view addSubview:topLine];
    topLine.backgroundColor = [UIColor colorWithHexString:BaseBackgroundGray];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.width.equalTo(ws.view);
        make.top.equalTo(ws.collectionView.mas_bottom);
        make.height.equalTo(@(10));
    }];
    
    UIView * backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.view.mas_left).offset(0);
        make.top.equalTo(topLine.mas_bottom);
        make.height.equalTo(@(30));
        make.width.equalTo(@(SCREEN_WIDTH));
        
    }];
    UILabel *buttomTit = [[UILabel alloc]init];
    buttomTit.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:buttomTit];
    buttomTit.text = ZBLocalized(@"更多推荐", nil);
    [buttomTit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.view.mas_left).offset(20);
        make.top.equalTo(topLine.mas_bottom);
        make.height.equalTo(@(30));
        make.width.equalTo(@(SCREEN_WIDTH));
        
    }];
    UIView *line = [[UIView alloc]init];
    [self.view addSubview:line];
    line.backgroundColor = [UIColor colorWithHexString:BaseBackgroundGray];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.left.equalTo(ws.view.mas_left).offset(20);
        make.height.equalTo(@(0.5));
        make.top.equalTo(buttomTit.mas_bottom);
    }];
    
    CGFloat itemWidth = (SCREEN_WIDTH - 4 )/ 4;
    CGFloat itemHeight = (SCREEN_WIDTH - 4 ) / 4;
    UICollectionViewFlowLayout *shareflowLayout = [[UICollectionViewFlowLayout alloc] init];
    shareflowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    shareflowLayout.sectionInset = UIEdgeInsetsMake(1, 1, 1,1);
    shareflowLayout.itemSize =CGSizeMake(itemWidth, itemHeight);
    // 1.设置列间距
    shareflowLayout.minimumInteritemSpacing = 0;
    // 2.设置行间距
    shareflowLayout.minimumLineSpacing = 0;
    self.BUttomcollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:shareflowLayout];
    self.BUttomcollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.BUttomcollectionView];
    [self.BUttomcollectionView registerClass:[CollectionViewCellForHomePageChoose class] forCellWithReuseIdentifier:@"cell"];
    self.BUttomcollectionView.delaysContentTouches = NO;
    self.BUttomcollectionView.delegate = self;
    self.BUttomcollectionView.dataSource = self;
    self.BUttomcollectionView.scrollEnabled = NO;
    self.BUttomcollectionView.showsHorizontalScrollIndicator = NO;
    [self.BUttomcollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom);
        make.width.equalTo(ws.view);
        make.centerX.equalTo(ws.view);
        make.height.equalTo(@(SCREEN_WIDTH / 4+ 10) );
    }];
}
#pragma mark collectionView代理方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == self.collectionView) {
        return 3;
    }else if (collectionView == self.BUttomcollectionView){
        return 4;
    }
    return 0;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCellForHomePageChoose *cell = (CollectionViewCellForHomePageChoose *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //设置数据
    //cell.mod = [self.arrForHomePageTypeName objectAtIndex:indexPath.row];
    cell.titleLable.numberOfLines = 2;
    if (collectionView == self.collectionView) {
        if (indexPath.row == 0) {
           cell.titleLable.text = ZBLocalized(@"语言切换", nil);
            [cell.iconImg setImage:[UIImage imageNamed:@"icon_shangyongyuyan"]];
        }else if (indexPath.row == 1){
            cell.titleLable.text = ZBLocalized(@"我的地址", nil);
            [cell.iconImg setImage:[UIImage imageNamed:@"icon_shangyongdizhi"]];
        }else if (indexPath.row == 2){
            cell.titleLable.text = ZBLocalized(@"我的评价", nil);
            [cell.iconImg setImage:[UIImage imageNamed:@"icon_shangyongxiaoxi"]];
        }
    }
    else if (collectionView == self.BUttomcollectionView){
        if (indexPath.row == 0) {
            cell.titleLable.text = ZBLocalized(@"关于我们", nil);
            [cell.iconImg setImage:[UIImage imageNamed:@"icon_tuijianguanyuwom"]];
        }else if (indexPath.row == 1){
            cell.titleLable.text = ZBLocalized(@"清除缓存", nil);
            [cell.iconImg setImage:[UIImage imageNamed:@"icon_tuijianbangzhufankui"]];
            
        }else if (indexPath.row == 2){
             cell.titleLable.text = ZBLocalized(@"骑手招募", nil);
            [cell.iconImg setImage:[UIImage imageNamed:@"icon_tuijianqishizhaoma"]];
            
        }else if (indexPath.row == 3){
            cell.titleLable.text = ZBLocalized(@"我要合作", nil);
            [cell.iconImg setImage:[UIImage imageNamed:@"icon_tuijianwoyaohezuo"]];
            
        }
        
    }
    
   
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.collectionView) {
        if (indexPath.row == 0) {
//            ChangelanguageVC *vc= [[ChangelanguageVC alloc]init];
//            vc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController presentViewController:vc animated:YES completion:nil];
            [self createChangeLag];
        }else if (indexPath.row == 1){
           
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *userID = [defaults objectForKey:UD_USERID];
            if (userID == nil || [userID isEqualToString:@""]) {
                NewLoginByPhoneVC *login = [[NewLoginByPhoneVC alloc]init];
                login.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:login animated:YES];
                
            }else{
                MineAddressVC *myaddress = [[MineAddressVC alloc]init];
                myaddress.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:myaddress animated:YES];
                
            }
            
        }else if (indexPath.row == 2){
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *userID = [defaults objectForKey:UD_USERID];
            if (userID == nil || [userID isEqualToString:@""]) {
                NewLoginByPhoneVC *login = [[NewLoginByPhoneVC alloc]init];
                login.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:login animated:YES];
               
            }else{
                MyEvaVC *eva = [[MyEvaVC alloc]init];
                eva.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:eva animated:YES];
            }
      
            
        }
    }
    else if (collectionView == self.BUttomcollectionView){
        if (indexPath.row == 0) {
            AboutusVC *about = [[AboutusVC alloc]init];
            about.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:about animated:YES];
        }else if (indexPath.row == 1){
            if (_totalSize == 0) {
                [MBManager showBriefAlert:ZBLocalized(@"没有缓存", nil)];
                return;
            }
            [FileTool removeDirectoryPath:CachePath];
            NSInteger totalSize = _totalSize;
            NSString *sizeStr = ZBLocalized(@"清除缓存", nil);
            // MB KB B
            if (totalSize > 1000 * 1000) {
                // MB
                CGFloat sizeF = totalSize / 1000.0 / 1000.0;
                sizeStr = [NSString stringWithFormat:@"%@%.1fMB",sizeStr,sizeF];
            } else if (totalSize > 1000) {
                // KB
                CGFloat sizeF = totalSize / 1000.0;
                sizeStr = [NSString stringWithFormat:@"%@%.1fKB",sizeStr,sizeF];
            } else if (totalSize > 0) {
                // B
                sizeStr = [NSString stringWithFormat:@"%@%.ldB",sizeStr,totalSize];
            }
            NSString *cleanSize = [NSString stringWithFormat:@"%@%@",sizeStr,ZBLocalized(@"成功", nil)];
            [MBManager showBriefAlert:cleanSize];
            _totalSize = 0;
            
        }else if (indexPath.row == 2){
            [MBManager showBriefAlert:ZBLocalized(@"敬请期待", nil)];
            
        }else if (indexPath.row == 3){
            [MBManager showBriefAlert:ZBLocalized(@"敬请期待", nil)];
            
        }
        
    }
}
-(void)createwindowBackView{
    self.windowBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
    self.windowBackView.backgroundColor = [UIColor colorWithHexString:@"363636" alpha:0.3];
    [[UIApplication sharedApplication].keyWindow addSubview:self.windowBackView];
    
}
-(void)createChangeLag{
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
        make.height.equalTo(@(185));
    }];
    
    
    [self createTableView];
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
    NSString *language=[[ZBLocalized sharedInstance]currentLanguage];
    NSLog(@"切换后的语言:%@",language);
    if ([language isEqualToString:@"th"]) {
        self.lastIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    else if ([language isEqualToString:@"zh-Hans"]) {
        self.lastIndexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    }
    else if ([language isEqualToString:@"en"]) {
        self.lastIndexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    }
    [self.tableView reloadData];
    
    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [okBtn addTarget:self action:@selector(chooseLugOk) forControlEvents:UIControlEventTouchUpInside];
    okBtn.layer.cornerRadius=5;
    okBtn.clipsToBounds = YES;
    [okBtn setTitle:ZBLocalized(@"确定", nil) forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okBtn setBackgroundColor:[UIColor colorWithHexString:BaseYellow]];
    okBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.windowBackView addSubview:okBtn];
    [okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.top.equalTo(ws.tableView.mas_bottom).offset(5);
        make.bottom.equalTo(ws.changeLagView.mas_bottom).offset(-15);
        make.left.equalTo(ws.changeLagView.mas_centerX).offset(10);
        make.right.equalTo(ws.changeLagView.mas_right).offset(-15);
    }];
    
    UIButton *cleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cleanBtn addTarget:self action:@selector(closeWindow) forControlEvents:UIControlEventTouchUpInside];
    cleanBtn.layer.cornerRadius=5;
    cleanBtn.clipsToBounds = YES;
    [cleanBtn setTitle:ZBLocalized(@"取消", nil) forState:UIControlStateNormal];
    [cleanBtn setTitleColor:[UIColor colorWithHexString:BaseYellow] forState:UIControlStateNormal];
    [cleanBtn setBackgroundColor:[UIColor whiteColor]];
    cleanBtn.layer.borderColor = [UIColor colorWithHexString:BaseYellow].CGColor;
    cleanBtn.layer.borderWidth = 1;
    okBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.windowBackView addSubview:cleanBtn];
    [cleanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.tableView.mas_bottom).offset(5);
        make.bottom.equalTo(ws.changeLagView.mas_bottom).offset(-15);
        make.right.equalTo(ws.changeLagView.mas_centerX).offset(-10);
        make.left.equalTo(ws.changeLagView.mas_left).offset(15);
    }];
    
}
-(void)createLogoutView{
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
        make.height.equalTo(@(185));
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
    
   
    
    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [okBtn addTarget:self action:@selector(logOUt) forControlEvents:UIControlEventTouchUpInside];
    okBtn.layer.cornerRadius=5;
    okBtn.clipsToBounds = YES;
    [okBtn setTitle:ZBLocalized(@"确定", nil) forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okBtn setBackgroundColor:[UIColor colorWithHexString:BaseYellow]];
    okBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.windowBackView addSubview:okBtn];
    [okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(40));
        make.bottom.equalTo(ws.changeLagView.mas_bottom).offset(-15);
        make.left.equalTo(ws.changeLagView.mas_centerX).offset(10);
        make.right.equalTo(ws.changeLagView.mas_right).offset(-15);
    }];
    
    UIButton *cleanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cleanBtn addTarget:self action:@selector(closeWindow) forControlEvents:UIControlEventTouchUpInside];
    cleanBtn.layer.cornerRadius=5;
    cleanBtn.clipsToBounds = YES;
    [cleanBtn setTitle:ZBLocalized(@"取消", nil) forState:UIControlStateNormal];
    [cleanBtn setTitleColor:[UIColor colorWithHexString:BaseYellow] forState:UIControlStateNormal];
    [cleanBtn setBackgroundColor:[UIColor whiteColor]];
    cleanBtn.layer.borderColor = [UIColor colorWithHexString:BaseYellow].CGColor;
    cleanBtn.layer.borderWidth = 1;
    cleanBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.windowBackView addSubview:cleanBtn];
    [cleanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(40));
        make.bottom.equalTo(ws.changeLagView.mas_bottom).offset(-15);
        make.right.equalTo(ws.changeLagView.mas_centerX).offset(-10);
        make.left.equalTo(ws.changeLagView.mas_left).offset(15);
       
    }];
    
    UILabel *subText = [[UILabel alloc]init];
    subText.numberOfLines = 0;
    subText.text = ZBLocalized(@"确定要退出吗？", nil);
    subText.textAlignment = NSTextAlignmentCenter;
    subText.textColor = [UIColor blackColor];
    subText.font = [UIFont systemFontOfSize:14];
    [self.windowBackView addSubview:subText];
    [subText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(okBtn.mas_top).offset(-15);
        make.top.equalTo(ws.changeLagView.mas_top).offset(15);
        make.centerX.equalTo(ws.changeLagView);
        make.left.equalTo(ws.changeLagView.mas_left).offset(20);
    }];
}
-(void)chooseLugOk{
    NSIndexPath *indexPath = self.lastIndexPath;
    if (indexPath.row==0) {
        
        [[ZBLocalized sharedInstance]setLanguage:@"th"];
        
    }
    if (indexPath.row==1) {
        
        [[ZBLocalized sharedInstance]setLanguage:@"zh-Hans"];
        
    }
    if (indexPath.row==2) {
        
        [[ZBLocalized sharedInstance]setLanguage:@"en"];
    }
    
    [self initRootVC];
    
    NSString *language=[[ZBLocalized sharedInstance]currentLanguage];
    NSLog(@"切换后的语言:%@",language);
}

-(void)closeWindow{
    [self.windowBackView removeFromSuperview];
}
-(void)createTableView{
    __weak typeof(self) ws = self;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[CellForChooseLag class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.windowBackView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.centerX.equalTo(ws.changeLagView);
        make.top.equalTo(ws.changeLagView).offset(10) ;
        make.left.equalTo(ws.changeLagView).offset(5);
        make.bottom.equalTo(ws.changeLagView).offset(-55);
    }];
   
 
}
#pragma mark- UITabelViewDataSource/delegat
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellForChooseLag *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if(cell == nil)
    {
        cell = [[CellForChooseLag alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    if (indexPath == self.lastIndexPath) {
        [cell.img setImage:[UIImage imageNamed:@"icon_xuankuang_down"]];
    }else{
        [cell.img setImage:[UIImage imageNamed:@"icon_xuankuang"]];
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0){
            cell.name.text = @"ภาษาไทย";
        }else if (indexPath.row == 1){
            cell.name.text = @"简体中文";
        }else if (indexPath.row == 2){
            cell.name.text = @"English";
        }
    }

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
-(void)toLogin{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [defaults objectForKey:UD_USERNAME];
    NSString *userID = [defaults objectForKey:UD_USERID];
    if (userID == nil || [userID isEqualToString:@""]) {
        NewLoginByPhoneVC *login = [[NewLoginByPhoneVC alloc]init];
        login.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:login animated:YES];
    }else{
        NSLog(@"========去设置个人信息");
    }
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.lastIndexPath = indexPath;
    [self.tableView reloadData];
 
}
- (void)initRootVC{
    EXTabBarVC *tab=[[EXTabBarVC alloc]init];
    
    /*
     LanguageViewController*LanguageVC=[[LanguageViewController alloc]init];
     LanguageVC=tab.selectedViewController;
     */
    [self.windowBackView removeFromSuperview];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = tab;
        tab.selectedIndex=2;
   
}
-(void)logOUt{
    [self.windowBackView removeFromSuperview ];
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        
        NSLog(@"删除Alias==%ld",(long)iResCode);
        
    } seq:0];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [defaults objectForKey:UD_USERID];
    NSString *strTag = [NSString stringWithFormat:@"bee%@",userId];
    NSSet *set = [[NSSet alloc] initWithObjects:strTag,nil];
    [JPUSHService deleteTags:set completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        
        NSLog(@"删除Tag====%ld",(long)iResCode);
    } seq:0];
    
    
    [defaults setObject:nil forKey:UD_USERID];
    [defaults setObject:nil forKey:UD_USERNAME];
    [defaults setObject:nil forKey:UD_USERPHONE];
    
    [defaults synchronize];
    
    self.userName.text = ZBLocalized(@"登录", nil);
    self.userPhone.text = @"";
    self.LogOutBtn.hidden = YES;
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
