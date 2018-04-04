//
//  CellForSubmitOrder.h
//  takeOut
//
//  Created by mac on 2018/4/4.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModForHadAddShoppingCar.h"
@interface CellForSubmitOrder : UITableViewCell
@property (nonatomic , strong) ModForHadAddShoppingCar *mod;
@property (nonatomic , strong)UIImageView *shopIcon;
@property (nonatomic , strong)UILabel *foodsName;
@property (nonatomic , strong)UILabel *foodsMoney;
@property (nonatomic , strong)UILabel *foodsCount;
@end
