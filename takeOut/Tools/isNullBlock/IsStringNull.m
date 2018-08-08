//
//  IsStringNull.m
//  takeOut
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "IsStringNull.h"

@implementation IsStringNull
+(BOOL) isBlankString:(NSString *)string{
    NSString *str = [NSString stringWithFormat:@"%@",string];
    
    if ([str isEqualToString:@""]) {
        return YES;
    }
    
    if ([str isEqualToString:@"<null>"]) {
        return YES;
    }
    
    if ([str isEqualToString:@"(null)"]) {
        return YES;
    }
    
    if ([str isEqualToString:@"<nil>"]) {
        return YES;
    }
    if ([str isEqualToString:@"null"]) {
        return YES;
    }
    if (str == nil || str == NULL) {
        return YES;
    }
    
    if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([str isEqual:[NSNull null]]) {
        return YES;
    }
    
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    
    
    return NO;
}
@end
