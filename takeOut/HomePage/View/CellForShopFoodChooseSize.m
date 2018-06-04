//
//  CellForShopFoodChooseSize.m
//  takeOut
//
//  Created by mac on 2018/3/27.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "CellForShopFoodChooseSize.h"

@implementation CellForShopFoodChooseSize
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    self.bigImage = [[UIImageView alloc]init];
     __weak typeof(self) ws = self;
    [self.contentView addSubview:self.bigImage];
    [self.bigImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView.mas_left).offset(15);
        make.top.equalTo(ws.contentView.mas_top).offset(10);
        make.bottom.equalTo(ws.contentView.mas_bottom).offset(-10);
        make.width.equalTo(ws.bigImage.mas_height);
    }];
   
    self.shopName = [[UILabel alloc]init];
    [self.contentView addSubview:self.shopName];
    [self.shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.bigImage.mas_right).offset(10);
        make.top.equalTo(ws.bigImage);
        make.bottom.equalTo(ws.bigImage.mas_centerY);
    }];
    self.priceLabel = [[UILabel alloc]init];
    self.priceLabel.numberOfLines = 2;
    self.priceLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.bigImage.mas_right).offset(10);
        make.bottom.equalTo(ws.contentView.mas_bottom).offset(-10);
        make.top.equalTo(ws.bigImage.mas_centerY);
    }];
    self.chooseSizeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.chooseSizeBtn.backgroundColor = [UIColor colorWithHexString:BaseYellow];
    [self.chooseSizeBtn addTarget:self action:@selector(chooseSize:) forControlEvents:UIControlEventTouchUpInside];
    
   // self.chooseSizeBtn.layer.cornerRadius = 5;
    [self.chooseSizeBtn setImage:[UIImage imageNamed:@"icon_shangguige"] forState:UIControlStateNormal];
    self.chooseSizeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.chooseSizeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.contentView addSubview:self.chooseSizeBtn];
    [self.chooseSizeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView.mas_right).offset(-10);
        make.centerY.equalTo(ws.priceLabel);
        make.width.equalTo(@(44));
        make.height.equalTo(@(30));
    }];
    
}
-(void)setMod:(ModelForFoodList *)mod{
    self.chooseMod = mod;
    self.shopName.text = mod.godsname;
    self.priceLabel.text = [NSString stringWithFormat:@"%@ %.2f",ZBLocalized(@"¥", nil),mod.pic];
    NSString *url = [NSString stringWithFormat:@"%@/%@",IMGBaesURL,mod.godslog];
     [self.bigImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"logo"]];
}


-(void)chooseSize:(UIButton *)btn{
    if (self.blockChooseSize) {
        self.blockChooseSize(self.chooseMod);
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
