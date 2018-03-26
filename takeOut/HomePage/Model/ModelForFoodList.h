//
//  ModelForFoodList.h
//  takeOut
//
//  Created by mac on 2018/3/26.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelForFoodList : NSObject
@property (nonatomic , assign)NSInteger id;
@property (nonatomic , copy) NSString *godsname;
@property (nonatomic , copy) NSString *godslog;
@property (nonatomic , copy) NSString *ys;
@property (nonatomic , assign)CGFloat pic;
@property (nonatomic , strong) NSArray *goodspic;
@end
