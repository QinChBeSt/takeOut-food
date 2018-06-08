//
//  bzDetailVC.h
//  takeOut
//
//  Created by mac on 2018/6/8.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^blockChooseBz)(NSString *);
@interface bzDetailVC : UIViewController
@property (nonatomic , copy)blockChooseBz blockChooseBz;
@property (nonatomic , strong)NSString *bzStr;
@end
