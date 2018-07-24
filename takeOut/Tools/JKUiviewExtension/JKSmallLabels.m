//
//  JKSmallLabels.m
//  JKSmallLabels
//
//  Created by 王冲 on 2018/5/19.
//  Copyright © 2018年 JK科技有限公司. All rights reserved.
//

#import "JKSmallLabels.h"

@implementation JKSmallLabels

/**
 根据传进来的数组来计算标签的视图，返回一个整理好标签的view
 
 @param labelArray 标签数组
 @param font 标签的字体大小
 @param teColor 标签的字体颜色
 @param bkColor 标签的背景颜色
 @param height 标签的高度
 @param maxWidth 整个view最大宽度
 @param labelx 大视图的X
 @param labely 大视图的Y
 @return 返回一个大视图
 */
-(JKSmallLabels *)createEveryLabel:(NSArray *)labelArray withlabelFont:(CGFloat)font withlabelTextColor:(UIColor *)teColor withlabelBackgroundColor:(UIColor *)bkColor withlabelHeight:(CGFloat)height withMaxWidth:(CGFloat)maxWidth withlabelX:(CGFloat)labelx withlabelY:(CGFloat)labely{
    
    JKSmallLabels *bottom = [[JKSmallLabels alloc]initWithFrame:CGRectMake(labelx, labely, maxWidth, 200)];
    bottom.backgroundColor = [UIColor whiteColor];
    
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    
    for (int i = 0; i<labelArray.count; i++) {
        
        CGFloat smallLabelWidth = [self calculationLabelWidthString:labelArray[i] withLabelFont:font];
        
        CGFloat maxX = labelX+8+smallLabelWidth;
        
        if (maxX > maxWidth) {
            
            labelY = labelY + 22 + 8;
            labelX = 0;
            
        }else{
            
        }
        
        UILabel *topLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(labelX+8, labelY, smallLabelWidth, height)];
        topLabel1.layer.cornerRadius = 2;
        topLabel1.clipsToBounds = YES;
        topLabel1.font = [UIFont systemFontOfSize:font];
        topLabel1.textAlignment = NSTextAlignmentCenter;
        topLabel1.text = labelArray[i];
        topLabel1.textColor = [UIColor colorWithHexString:@"dd4545"];
        topLabel1.clipsToBounds = YES;
        topLabel1.layer.borderWidth = 1;
        topLabel1.layer.borderColor = [UIColor colorWithHexString:@"dd4545" alpha:0.5].CGColor;
        topLabel1.backgroundColor = [UIColor whiteColor];
        [bottom addSubview:topLabel1];
        [bottom addSubview:topLabel1];
        
        labelX = labelX+8+smallLabelWidth;
    }
    
    bottom.height = labelY + 22;
    
    return bottom;
}

#pragma mark 根据 文字和字体大小计算 标签的宽度
-(CGFloat)calculationLabelWidthString:(NSString *)labelStr withLabelFont:(CGFloat)font{
    
    CGFloat smallLabelWidth = [self string:labelStr sizeWithFont:[UIFont systemFontOfSize:font] maxSize:CGSizeMake(SCREEN_WIDTH,font+2)].width;
    return 4+smallLabelWidth+4;
    
}

//确定高度的设置
-(CGSize)string:(NSString *)string sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize{
    
    
    NSDictionary *attrs = @{NSFontAttributeName:font};
    
    return [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading |NSLineBreakByCharWrapping attributes:attrs context:nil].size;
}

@end

