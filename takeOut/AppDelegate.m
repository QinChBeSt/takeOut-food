//
//  AppDelegate.m
//  takeOut
//
//  Created by mac on 2018/3/23.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "AppDelegate.h"
#import "EXTabBarVC.h"
#import "EXNavigationVC.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>


@interface AppDelegate ()<UITabBarDelegate,JPUSHRegisterDelegate>
@property (strong, nonatomic)NSArray *viewControllers;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
//国际化===============
    [[ZBLocalized sharedInstance]initLanguage];//放在tabbar前初始化
    
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    
    keyboardManager.enable = YES; // 控制整个功能是否启用
    
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    
    keyboardManager.shouldShowTextFieldPlaceholder = YES; // 是否显示占位文字
    
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:15]; // 设置占位文字的字体
    
    keyboardManager.keyboardDistanceFromTextField = 10.0f; // 输入框距离键盘的距离

//极光推送=============
    //初始化APNs
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    }
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    } else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
   [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSString *channel = @"iOS";
// 初始化JPush====================
    [JPUSHService setupWithOption:launchOptions appKey:JPushKey
                          channel:channel
                 apsForProduction:JPushIsProduction
            advertisingIdentifier:advertisingId];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [defaults objectForKey:UD_USERID];
    if (userID == nil || [userID isEqualToString:@""]) {
        [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            
            NSLog(@"删除Alias==%ld",(long)iResCode);
            
        } seq:0];
        
    }
    
    
    EXTabBarVC *tabbar = [EXTabBarVC sharedInstance];
    UIViewController * viewconrtoller = [[EXNavigationVC alloc]initWithRootViewController:tabbar];
    [self.window setRootViewController:viewconrtoller];
    [self.window makeKeyAndVisible];
    
    
    return YES;
    
}

#pragma mark - JPushDelegate
//注册APNs成功并上报DeviceToken
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"deviceToken===========%@",deviceToken);
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
//实现注册APNs失败接口
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
#pragma mark- JPUSHRegisterDelegate

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    NSLog(@"收到的推送消息 userinfo %@",userInfo);
    
    //判断应用是在前台还是后台
    
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        
        //     前台收到消息后，做的对应页面跳转操作
        
          //[self SetMainTabbarController2];
        
         //  [[NSNotificationCenter defaultCenter]postNotificationName:@"REFRESHYUJING" object:nil];
        
        NSLog(@"前台收到消息");
        
    }
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        
        [JPUSHService handleRemoteNotification:userInfo];
        
    }
    
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
    
}
// NS_DEPRECATED_IOS(3_0, 10_0, "Use UserNotifications Framework's -[UNUserNotificationCenterDelegate willPresentNotification:withCompletionHandler:] or -[UNUserNotificationCenterDelegate didReceiveNotificationResponse:withCompletionHandler:] for user visible notifications and -[UIApplicationDelegate application:didReceiveRemoteNotification:fetchCompletionHandler:] for silent remote notifications")
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // 取得 APNs 标准信息内容
    NSDictionary *aps = [userInfo valueForKey:@"aps"];
    NSString *content = [aps valueForKey:@"alert"]; //推送显示的内容
    NSInteger badge = [[aps valueForKey:@"badge"] integerValue]; //badge数量
    NSString *sound = [aps valueForKey:@"sound"]; //播放的声音
    
    // 取得Extras字段内容
    NSString *customizeField1 = [userInfo valueForKey:@"customizeExtras"]; //服务端中Extras字段，key是自己定义的
    NSLog(@"content =[%@], badge=[%d], sound=[%@], customize field  =[%@]",content,badge,sound,customizeField1);
    
    // iOS 10 以下 Required
    [JPUSHService handleRemoteNotification:userInfo];
}
// 通过点击推送弹出的通知调用,包括前台和后台(didReceiveNotificationResponse)

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    
    if ([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        
        [JPUSHService handleRemoteNotification:userInfo];
        
        //[self SetMainTabbarController2]; //收到推送消息，需要调整的界面
        
        // 消息界面监听刷新
        
        //        [[NSNotificationCenter defaultCenter] postNotificationName:ReceiveMessageNotification object:nil];
        
        //        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
        
    }
    
    completionHandler();  // 系统要求执行这个方法
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    
    [JPUSHService setBadge:0];
    

}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//- (BOOL)application:(UIApplication *)application
//
//shouldAllowExtensionPointIdentifier:(NSString *)extensionPointIdentifier
//
//{
//    
//    if ([extensionPointIdentifier isEqualToString:@"com.apple.keyboard-service"]) {
//        
//        return NO;
//        
//    }
//    
//    return YES;
//    
//}

@end
