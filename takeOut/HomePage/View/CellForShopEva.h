//
//  CellForShopEva.h
//  takeOut
//
//  Created by mac on 2018/4/8.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellForShopEva : UITableViewCell
@property (nonatomic , strong)NSMutableDictionary *dic;
@property (nonatomic , strong)UIImageView *icon;
@property (nonatomic , strong)UILabel *userName;
@property (nonatomic , strong)UILabel *evaType;
@property (nonatomic , strong)UILabel *evaSub;
@property (nonatomic , strong)UILabel *evaTime;
@end
