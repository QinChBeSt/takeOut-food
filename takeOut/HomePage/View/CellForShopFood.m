//
//  CellForShopFood.m
//  takeOut
//
//  Created by mac on 2018/3/26.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "CellForShopFood.h"

@implementation CellForShopFood
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    self.bigImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    [self.bigImage setBackgroundColor:[UIColor orangeColor]];
    [self.contentView addSubview:self.bigImage];
    __weak typeof(self) ws = self;
    self.shopName = [[UILabel alloc]init];
    [self.contentView addSubview:self.shopName];
    [self.shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.bigImage.mas_right).offset(10);
        make.top.equalTo(ws.bigImage);
    }];
    self.priceLabel = [[UILabel alloc]init];
    self.priceLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.bigImage.mas_right).offset(10);
        make.bottom.equalTo(ws.contentView.mas_bottom).offset(-10);
    }];

    
    self.addToShoppingCar = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addToShoppingCar.backgroundColor = [UIColor orangeColor];
    [self.addToShoppingCar addTarget:self action:@selector(addToShopingCarAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.addToShoppingCar];
    [self.addToShoppingCar setHidden:NO];
    [self.addToShoppingCar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView.mas_right).offset(-15);
        make.centerY.equalTo(ws.priceLabel);
        make.width.equalTo(@(25));
        make.height.equalTo(@(25));
    }];
    
}
-(void)setMod:(ModelForFoodList *)mod{
    self.chooseMod = mod;
    self.shopName.text = mod.godsname;
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f元",mod.pic];
}

-(void)addToShopingCarAction:(UIButton *)btn{
    if (self.blockAddShopingCar) {
        self.blockAddShopingCar(self.chooseMod);
    }
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