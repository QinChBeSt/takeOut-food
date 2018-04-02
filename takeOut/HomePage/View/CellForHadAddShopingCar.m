//
//  CellForHadAddShopingCar.m
//  takeOut
//
//  Created by mac on 2018/4/2.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "CellForHadAddShopingCar.h"

@implementation CellForHadAddShopingCar
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
        make.left.equalTo(ws.contentView).offset(10);
    }];
    
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.backgroundColor = [UIColor orangeColor];
    [self.addBtn addTarget:self action:@selector(addToShopingCarAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.addBtn];
    [self.addBtn setHidden:NO];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView.mas_right).offset(-15);
        make.centerY.equalTo(ws.contentView);
        make.width.equalTo(@(25));
        make.height.equalTo(@(25));
    }];
    
    self.goodsCount = [[UILabel alloc]init];
    [self.contentView addSubview:self.goodsCount];
    [self.goodsCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.contentView);
        make.right.equalTo(ws.addBtn.mas_left).offset(-5);
    }];
    
    self.removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.removeBtn.backgroundColor = [UIColor orangeColor];
    [self.removeBtn addTarget:self action:@selector(delectToShopingCarAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.removeBtn];
    [self.removeBtn setHidden:NO];
    [self.removeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.goodsCount.mas_left).offset(-5);
        make.centerY.equalTo(ws.contentView);
        make.width.equalTo(@(25));
        make.height.equalTo(@(25));
    }];
    
    self.goodsMoney = [[UILabel alloc]init];
    self.goodsMoney.textColor = [UIColor redColor];
    [self.contentView addSubview:self.goodsMoney];
    [self.goodsMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.contentView);
        make.left.equalTo(ws.goodsName.mas_right).offset(50);
    }];
    self.typeName = [[UILabel alloc]init];
    self.typeName.font = [UIFont systemFontOfSize:13];
    self.typeName.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.typeName];
    [self.typeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.goodsName);
        make.top.equalTo(ws.contentView.mas_centerY);
        make.centerY.equalTo(ws.contentView.mas_centerY).offset(self.frame.size.height / 4);
    }];
}
-(void)setMod:(ModForHadAddShoppingCar *)Mod{
    NSInteger price = [Mod.g_pic integerValue];
    NSInteger goodscount = [Mod.count integerValue];
    price = price * goodscount;
    NSString *priceStr = [NSString stringWithFormat:@"%ld",(long)price];
    self.goodsName.text = Mod.g_name;
    self.goodsMoney.text =NSLocalizedString(priceStr, nil);
    self.goodsCount.text = [NSString stringWithFormat:@"%@",Mod.count];
    
    if (Mod.g_chooseType == nil) {
        self.goodsName.text = Mod.g_name;
    }else{
        __weak typeof(self) ws = self;
         self.goodsName.text = Mod.g_chooseType;
        self.typeName.text = Mod.g_name;
        [self.goodsName mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(ws.contentView.mas_centerY);
            make.left.equalTo(ws.contentView).offset(10);
        }];
    }
    self.chooseMod = Mod;
}

-(void)addToShopingCarAction:(UIButton *)btn{
    if (self.blockAddHadShopingCar) {
        self.blockAddHadShopingCar(self.chooseMod);
    }
}
-(void)delectToShopingCarAction:(UIButton *)btn{
    if (self.blockDelHadShopingCar) {
        self.blockDelHadShopingCar(self.chooseMod);
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
