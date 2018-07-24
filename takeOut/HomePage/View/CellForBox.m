//
//  CellForBox.m
//  takeOut
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "CellForBox.h"

@implementation CellForBox
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    __weak typeof(self) ws = self;
    self.goodsName = [[UILabel alloc]init];
    [self.contentView addSubview:self.goodsName];
    [self.goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.contentView);
        make.left.equalTo(ws.contentView).offset(20);
    }];
    
    self.goodsMoney = [[UILabel alloc]init];
    self.goodsMoney.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.goodsMoney];
    [self.goodsMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.contentView);
        make.left.equalTo(ws.contentView.mas_centerX).offset(0);
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
