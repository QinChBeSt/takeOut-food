//
//  CellForShopFood.h
//  takeOut
//
//  Created by mac on 2018/3/26.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelForFoodList.h"

@protocol btnClickedDelegate <NSObject>
-(void)cellBtnClicked:(int)section row:(int)row;
@end

@interface CellForShopFood : UITableViewCell
@property (nonatomic , strong) ModelForFoodList *mod;

@property (nonatomic , strong)UIImageView *bigImage;
@property (nonatomic , strong)UILabel *shopName;
@property (nonatomic , strong)UILabel *priceLabel;
@property (nonatomic , strong)UIButton *chooseSizeBtn;

@property (nonatomic , weak)id<btnClickedDelegate> btnDelegate;
-(instancetype)initWithIntNum:(int)section row:(int)row;
@end
