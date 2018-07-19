//
//  ZHPlaceInfoModel.h
//  takeOut
//
//  Created by 钱程 on 2018/7/19.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface ZHPlaceInfoModel : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *thoroughfare;
@property (nonatomic, strong) NSString *subThoroughfare;
@property (nonatomic, strong) NSString *city;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@end
