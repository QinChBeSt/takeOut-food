//
//  CellForShopFood.h
//  takeOut
//
//  Created by mac on 2018/3/26.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelForFoodList.h"
@interface CellForShopFood : UITableViewCell
@property (nonatomic , strong) ModelForFoodList *mod;

@property (nonatomic , strong)UIImageView *bigImage;
@property (nonatomic , strong)UILabel *shopName;
@end
