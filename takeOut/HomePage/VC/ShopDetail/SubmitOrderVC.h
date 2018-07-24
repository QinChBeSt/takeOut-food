//
//  SubmitOrderVC.h
//  takeOut
//
//  Created by mac on 2018/4/4.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubmitOrderVC : UIViewController
@property (nonatomic , strong)NSString *carid;
@property (nonatomic , strong)NSString *pspic;
@property (nonatomic , strong)NSString *yhpic;
@property (nonatomic , strong)NSString *ypic;
@property (nonatomic , strong)NSMutableArray *arrForOrder;
@property (nonatomic , strong)NSString *shopId;
@property (nonatomic , strong)NSString *boxPic;
@end
