//
//  TableViewCellForHomepageList.h
//  takeOut
//
//  Created by mac on 2018/3/24.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelForShopList.h"
typedef void (^blockChooseShow)(NSString *);
@interface TableViewCellForHomepageList : UITableViewCell
@property (nonatomic , copy)blockChooseShow blockChooseShow;
@property (nonatomic , strong) UIImageView *bigImage;
@property (nonatomic , strong) UILabel *shopName;
@property (nonatomic , strong) UILabel *shopDistance;
@property (nonatomic , strong) UILabel *shopMassage;
@property (nonatomic , strong) UILabel *shopLikeLab;
@property (nonatomic , strong) UIImageView *shopPreferentImg1;
@property (nonatomic , strong) UILabel *shopPreferential1;
@property (nonatomic , strong) UIImageView *shopPreferentImg2;
@property (nonatomic , strong) UILabel *shopPreferential2;
@property (nonatomic , strong) UIImageView *dyLabel;
@property (nonatomic , strong) ModelForShopList *mod;
@property (nonatomic , strong) NSNumber *isShowLong;
@property (nonatomic , strong)UIView *longSaveView;
@property (nonatomic , strong)UIView *shortSaceView;
@property (nonatomic , strong)UIButton *showMoreBtn;
@property (nonatomic , strong)UIImageView *showMoreImg;
@end
