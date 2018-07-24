//
//  JKSmallLabels.h
//  JKSmallLabels
//
//  Created by 王冲 on 2018/5/19.
//  Copyright © 2018年 JK科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JKSmallLabels : UIView

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
-(JKSmallLabels *)createEveryLabel:(NSArray *)labelArray withlabelFont:(CGFloat)font withlabelTextColor:(UIColor *)teColor withlabelBackgroundColor:(UIColor *)bkColor withlabelHeight:(CGFloat)height withMaxWidth:(CGFloat)maxWidth withlabelX:(CGFloat)labelx withlabelY:(CGFloat)labely;

@end

