//
//  CollectionViewCellForHomePageChoose.h
//  takeOut
//
//  Created by mac on 2018/3/24.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelForHomeType.h"

@interface CollectionViewCellForHomePageChoose : UICollectionViewCell
@property (nonatomic , strong)UIImageView *iconImg;
@property (nonatomic , strong)UILabel *titleLable;

@property (nonatomic , strong)ModelForHomeType *mod;

@end
