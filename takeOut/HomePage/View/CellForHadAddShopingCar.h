//
//  CellForHadAddShopingCar.h
//  takeOut
//
//  Created by mac on 2018/4/2.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModForHadAddShoppingCar.h"
@interface CellForHadAddShopingCar : UITableViewCell
@property (nonatomic , strong)UILabel *goodsName;
@property (nonatomic , strong)UILabel *typeName;
@property (nonatomic , strong)UILabel *goodsMoney;
@property (nonatomic , strong)UILabel *goodsCount;
@property (nonatomic , strong)UIButton *addBtn;
@property (nonatomic , strong)UIButton *removeBtn;
@property (nonatomic , strong)ModForHadAddShoppingCar *Mod;
@end
