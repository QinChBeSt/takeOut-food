//
//  CellForHomeType.h
//  takeOut
//
//  Created by mac on 2018/5/16.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelForShopList.h"
@interface CellForHomeType : UITableViewCell
@property (nonatomic , strong) UIImageView *bigImage;
@property (nonatomic , strong) UILabel *shopName;
@property (nonatomic , strong) UILabel *shopDistance;
@property (nonatomic , strong) UILabel *shopMassage;
@property (nonatomic , strong) UIImageView *shopPreferentImg1;
@property (nonatomic , strong) UILabel *shopPreferential1;
@property (nonatomic , strong) UIImageView *shopPreferentImg2;
@property (nonatomic , strong) UILabel *shopPreferential2;
@property (nonatomic , strong) UIImageView *dyLabel;
@property (nonatomic , strong) ModelForShopList *mod;
@end
