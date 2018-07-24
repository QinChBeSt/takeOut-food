//
//  ModForHadAddShoppingCar.h
//  takeOut
//
//  Created by mac on 2018/4/2.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModForHadAddShoppingCar : NSObject
@property (nonatomic , assign)NSNumber *count;
@property (nonatomic , assign)NSNumber *g_id;
@property (nonatomic , assign)NSString *g_pic;
@property (nonatomic , strong)NSString *g_name;
@property (nonatomic , strong)NSString *g_log;
@property (nonatomic , strong)NSIndexPath *seleIndex;
@property (nonatomic , strong)NSString *g_chooseType;
@property (nonatomic , strong)NSDictionary *g_goodsPic;
@end
