//
//  CellForShopFood.h
//  takeOut
//
//  Created by mac on 2018/3/26.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelForFoodList.h"
typedef void (^blockChooseSize)(ModelForFoodList *);
typedef void (^blockAddShopingCar)(ModelForFoodList *);
@interface CellForShopFood : UITableViewCell
@property (nonatomic , copy)blockChooseSize blockChooseSize;
@property (nonatomic , copy)blockAddShopingCar blockAddShopingCar;
@property (nonatomic , strong) ModelForFoodList *mod;
@property (nonatomic , strong) ModelForFoodList *chooseMod;
@property (nonatomic , strong)UIImageView *bigImage;
@property (nonatomic , strong)UILabel *shopName;
@property (nonatomic , strong)UILabel *priceLabel;
@property (nonatomic , strong)UIButton *chooseSizeBtn;
@property (nonatomic , strong)UIButton *addToShoppingCar;
@property (nonatomic , strong)UIButton *delectToShoppingCar;
@property (nonatomic , assign)NSInteger ChooseCount;
@property (nonatomic , strong)UILabel *chooseCountLabel;

@end
