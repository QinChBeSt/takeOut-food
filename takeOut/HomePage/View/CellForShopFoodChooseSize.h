//
//  CellForShopFoodChooseSize.h
//  takeOut
//
//  Created by mac on 2018/3/27.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelForFoodList.h"
typedef void (^blockChooseSize)(ModelForFoodList *);
@interface CellForShopFoodChooseSize : UITableViewCell
@property (nonatomic , copy)blockChooseSize blockChooseSize;
@property (nonatomic , strong) ModelForFoodList *mod;
@property (nonatomic , strong) ModelForFoodList *chooseMod;
@property (nonatomic , strong)UIImageView *bigImage;
@property (nonatomic , strong)UILabel *shopName;
@property (nonatomic , strong)UILabel *priceLabel;
@property (nonatomic , strong)UIButton *chooseSizeBtn;
@property (nonatomic , strong)UIButton *addToShoppingCar;
@end
