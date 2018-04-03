//
//  LocationMapVC.h
//  takeOut
//
//  Created by mac on 2018/4/3.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ReturnValueBlock) (NSString *strValue);
@interface LocationMapVC : UIViewController
@property(nonatomic, copy) ReturnValueBlock returnValueBlock;
@end
