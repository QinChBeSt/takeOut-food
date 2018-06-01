//
//  EXTabBarVC.m
//  EnjoyXianRoad
//
//

#import "EXTabBarVC.h"

//vc
#import "OrderPageVC.h"

#import "MinePageVC.h"

@interface EXTabBarVC ()

@property (nonatomic,strong) OrderPageVC * orderVC;
@property (nonatomic,strong) MinePageVC *userCenterVC;

@end

@implementation EXTabBarVC

DEF_SINGLETON(EXTabBarVC);


#pragma mark --- LifeCycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    //创建子VC
    [self createViewControllers];
   [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [UITabBar appearance].translucent = NO;
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    
   
    //tincolor设置
    [[UITabBarItem appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:11], NSFontAttributeName,nil] forState: UIControlStateSelected];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:11], NSFontAttributeName, nil] forState:UIControlStateNormal];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.selectedViewController viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.navigationController.navigationBar setHidden:YES];
    [self.selectedViewController viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:[UIColor orangeColor]];

    self.navigationController.navigationBar.translucent = NO;

}

#pragma mark ---
#pragma mark --- Private Methods

- (void)pushToViewController:(UIViewController *)VC animation:(BOOL)animated{
    [self.navigationController pushViewController:VC animated:animated];
}

- (void)createViewControllers
{
    
    UIEdgeInsets inserts = UIEdgeInsetsMake(-1, 0, 1, 0);
    
    NSMutableArray *mArray = @[].mutableCopy;
    self.homeVC = [[HomePageVC alloc] init];
    
    UINavigationController *naviHome = [[UINavigationController alloc]initWithRootViewController:self.homeVC];
    
    naviHome.tabBarItem = [[UITabBarItem alloc] initWithTitle:ZBLocalized(@"首页", nil) image:[self configureImage:@"icon_shouye"] selectedImage:[self configureImage:@"icon_shouyedown"]];
    naviHome.tabBarItem.imageInsets = inserts;
    
    [mArray addObject:naviHome];
    
    self.orderVC = [[OrderPageVC alloc] init];
    UINavigationController *naviorder = [[UINavigationController alloc]initWithRootViewController:self.orderVC];
    naviorder.tabBarItem = [[UITabBarItem alloc] initWithTitle:ZBLocalized(@"订单", nil) image:[self configureImage:@"icon_dingdan"] selectedImage:[self configureImage:@"icon_dingdandown"]];
    UIEdgeInsets insertsDis = UIEdgeInsetsMake(0, 0, 0, 0);

    naviorder.tabBarItem.imageInsets = insertsDis;
    [mArray addObject:naviorder];
    
    
    
    
    self.userCenterVC = [[MinePageVC alloc] init];
    UINavigationController *naviUsercenter = [[UINavigationController alloc]initWithRootViewController:self.userCenterVC];
    naviUsercenter.tabBarItem = [[UITabBarItem alloc] initWithTitle:ZBLocalized(@"我的", nil) image:[self configureImage:@"icon_wode"] selectedImage:[self configureImage:@"icon_wodedown"]];
    naviUsercenter.tabBarItem.imageInsets = inserts;
    [mArray addObject:naviUsercenter];
    
    self.viewControllers  = mArray;
    
    
    
}

- (UIImage *)configureImage:(NSString *)imageName
{
    return [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
