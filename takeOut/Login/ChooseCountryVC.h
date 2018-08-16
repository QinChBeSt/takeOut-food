//
//  ChooseCountryVC.h
//  takeOut
//
//  Created by mac on 2018/7/10.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^blockChooseShow)(NSString *);
@interface ChooseCountryVC : UIViewController
@property (nonatomic , copy)blockChooseShow blockChooseShow;
@property (nonatomic , strong)NSString *hasChooseStr;
@end
