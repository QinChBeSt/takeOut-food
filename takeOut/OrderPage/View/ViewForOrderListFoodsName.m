//
//  ViewForOrderListFoodsName.m
//  takeOut
//
//  Created by 钱程 on 2018/4/6.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "ViewForOrderListFoodsName.h"

@implementation ViewForOrderListFoodsName

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.foodsName = [[UILabel alloc]init];
        self.foodsName.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.foodsName];
        self.foodsCount = [[UILabel alloc]init];
        [self addSubview:self.foodsCount];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.foodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(25);
        make.centerY.equalTo(self);
    }];
    
    [self.foodsCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.centerY.equalTo(self);
    }];
    
}

@end
