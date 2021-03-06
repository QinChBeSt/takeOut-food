//
//  CellForOrderListNoPJ.h
//  takeOut
//
//  Created by mac on 2018/4/11.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewForOrderListFoodsName.h"
#import "ModelForOrderList.h"



@interface CellForOrderListNoPJ : UITableViewCell
@property (nonatomic , strong)UIImageView *shopIcon;
@property (nonatomic , strong)UILabel *shopNameLabel;
@property (nonatomic , strong)UILabel *haveEvaluateLabel;
@property (nonatomic , strong)UIView *topLine;
@property (nonatomic , strong)UIView *foodsViewBackGround;
@property (nonatomic , strong)ViewForOrderListFoodsName *foodsView;
@property (nonatomic , strong)ViewForOrderListFoodsName *foodsView2;
@property (nonatomic , strong)ViewForOrderListFoodsName *foodsView3;
@property (nonatomic , strong)UILabel *foodsTolitLabel;
@property (nonatomic , strong)UILabel *foodsMuch;
@property (nonatomic , assign)int foodTypeCount;
@property (nonatomic , strong)UILabel *orderTimeLabel;
@property (nonatomic , strong)UIView *bottomLine;
@property (nonatomic , strong)ModelForOrderList *mod;


@end
