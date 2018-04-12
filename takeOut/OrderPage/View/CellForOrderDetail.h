//
//  CellForOrderDetail.h
//  takeOut
//
//  Created by mac on 2018/4/8.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellForOrderDetail : UITableViewCell
@property (nonatomic , strong)UIImageView *bigImage;
@property (nonatomic , strong)UILabel *foodName;
@property (nonatomic , strong)UILabel *foodPic;
@property (nonatomic , strong)UILabel *foodCount;

@property (nonatomic , strong)NSMutableDictionary *dic;
@end
