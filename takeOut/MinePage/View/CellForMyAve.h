//
//  CellForMyAve.h
//  takeOut
//
//  Created by mac on 2018/4/11.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellForMyAve : UITableViewCell
@property (nonatomic , strong)NSMutableDictionary *dic;
@property (nonatomic , strong)UIImageView *shopIcon;
@property (nonatomic , strong)UILabel *shopName;
@property (nonatomic , strong)UIImageView *shopBigImage;
@property (nonatomic , strong)UILabel *userName;
@property (nonatomic , strong)UILabel *aveDate;
@property (nonatomic , strong)UILabel *aveType;
@property (nonatomic , strong)UILabel *aveText;
@end
