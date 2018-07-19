//
//  ChoosePayType.h
//  takeOut
//
//  Created by mac on 2018/6/29.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^blockChooseBz)(NSString *);
@interface ChoosePayType : UIViewController
@property (nonatomic , copy)blockChooseBz blockChooseBz;
@end
