//
//  CellForMyAddress.h
//  takeOut
//
//  Created by mac on 2018/4/4.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelForGetAddress.h"
@interface CellForMyAddress : UITableViewCell
@property (nonatomic , strong) UILabel *addressLabel;
@property (nonatomic , strong) UILabel *name;
@property (nonatomic , strong) UILabel *phone;
@property (nonatomic , strong)ModelForGetAddress *Mod;
@property (nonatomic , strong) UIImageView *selectImage;
@end
