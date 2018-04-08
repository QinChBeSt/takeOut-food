//
//  ModelForOrderList.h
//  takeOut
//
//  Created by 钱程 on 2018/4/6.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelForOrderList : NSObject
@property (nonatomic , strong)NSString *ordenum;
@property (nonatomic , strong)NSString *shopname;
@property (nonatomic , strong)NSString *shopstart;
@property (nonatomic , strong)NSString *goodsnum;
@property (nonatomic , strong)NSString *totalpic;
@property (nonatomic , strong)NSArray *godslist;
@end
