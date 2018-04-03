//
//  ModelForShopList.h
//  takeOut
//
//  Created by mac on 2018/3/26.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelForShopList : NSObject
@property (nonatomic , copy) NSString *per_mean;
@property (nonatomic , copy) NSString *send_dis;
@property (nonatomic , copy) NSString *send_pic;
@property (nonatomic , copy) NSString *send_time;
@property (nonatomic , copy) NSString *store_id;
@property (nonatomic , copy) NSString *store_name;
@property (nonatomic , copy) NSString *store_img;
@property (nonatomic , copy) NSString *up_pic;
@property (nonatomic , strong)NSArray *act_list;
@property (nonatomic , copy)NSString *opentime;
@end
