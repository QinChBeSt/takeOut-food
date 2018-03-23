//
//  EXTabBarVC.h
//  EnjoyXianRoad
//


#import <UIKit/UIKit.h>
#import "HomePageVC.h"
@interface EXTabBarVC : UITabBarController
@property (nonatomic,strong) HomePageVC *homeVC;     //首页  tab 0

//单例
#pragma mark - 单例
#undef    AS_SINGLETON
#define AS_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef    DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}
AS_SINGLETON(EXTabBarVC);

- (void)pushToViewController:(UIViewController *)VC animation:(BOOL)animated;


@end
