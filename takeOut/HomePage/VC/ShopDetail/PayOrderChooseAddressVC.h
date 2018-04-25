//
//  PayOrderChooseAddressVC.h
//  takeOut
//
//  Created by mac on 2018/4/4.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ModelForGetAddress.h"
typedef void (^blockChooseAddress)(ModelForGetAddress *);
@interface PayOrderChooseAddressVC : UIViewController
@property (nonatomic , copy)blockChooseAddress blockchooseAddress;
@property (nonatomic , strong)NSString *shopId;
@end
