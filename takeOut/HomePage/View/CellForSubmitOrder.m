//
//  CellForSubmitOrder.m
//  takeOut
//
//  Created by mac on 2018/4/4.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "CellForSubmitOrder.h"
@implementation CellForSubmitOrder

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
    self.shopIcon = [[UIImageView alloc]init];
    [self.contentView addSubview:self.shopIcon];
    [self.shopIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView.mas_left).offset(20);
        make.top.equalTo(ws.contentView.mas_top).offset(10);
        make.width.and.height.equalTo(@(70));
    }];
    
    self.foodsName = [[UILabel alloc]init];
    self.foodsName.textColor = [UIColor colorWithHexString:@"4b4b4b"];
    [self.contentView addSubview:self.foodsName];
    [self.foodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.shopIcon.mas_right).offset(25);
        make.centerY.equalTo(ws.contentView.mas_centerY).offset(-10);
    }];
    
    self.foodsMoney = [[UILabel alloc]init];
    self.foodsMoney.textColor = [UIColor redColor];
    [self.contentView addSubview:self.foodsMoney];
    [self.foodsMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView.mas_right).offset(-20);
        make.centerY.equalTo(ws.foodsName);
    }];
    
    self.foodsCount = [[UILabel alloc]init];
    self.foodsCount.textColor = [UIColor colorWithHexString:@"4b4b4b"];
    [self.contentView addSubview:self.foodsCount];
    [self.foodsCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView.mas_right).offset(-20);
        make.top.equalTo(ws.foodsMoney.mas_bottom);
        make.bottom.equalTo(ws.contentView);
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
