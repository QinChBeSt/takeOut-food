//
//  BaseTabbarVC.m
//  takeOut
//
//  Created by mac on 2018/3/23.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "BaseTabbarVC.h"
//VC
#import "HomePageVC.h"
#import "MinePageVC.h"
#import "OrderPageVC.h"
@interface BaseTabbarVC ()

@end

@implementation BaseTabbarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    HomePageVC *oneVC = [[HomePageVC alloc]init];
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:oneVC];
    nav1.title = @"首页";
    nav1.tabBarItem.image = [UIImage imageNamed:@"tab_home_icon"];
    oneVC.navigationItem.title = @"首页";
    oneVC.view.backgroundColor = [UIColor whiteColor];
    [self addChildViewController:nav1];
  
    OrderPageVC *twoVC = [[OrderPageVC alloc]init];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:twoVC];
    nav2.title = @"订单";
    nav2.tabBarItem.image = [UIImage imageNamed:@"js"];
    twoVC.navigationItem.title = @"订单";
    [self addChildViewController:nav2];
   
    MinePageVC *threeVC = [[MinePageVC alloc]init];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:threeVC];
    nav3.title = @"我的";
    nav3.tabBarItem.image = [UIImage imageNamed:@"qw"];
    threeVC.navigationItem.title = @"我的";
    [self addChildViewController:nav3];
    
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
