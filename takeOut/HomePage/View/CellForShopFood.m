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
      __weak typeof(self) ws = self;
    self.bigImage = [[UIImageView alloc]init];
    
    [self.contentView addSubview:self.bigImage];
    [self.bigImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView.mas_left).offset(15);
        make.top.equalTo(ws.contentView.mas_top).offset(10);
        make.bottom.equalTo(ws.contentView.mas_bottom).offset(-10);
        make.width.equalTo(ws.bigImage.mas_height);
    }];
  
    self.shopName = [[UILabel alloc]init];
    self.shopName.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    self.shopName.numberOfLines = 2;
    [self.contentView addSubview:self.shopName];
    [self.shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.bigImage.mas_right).offset(10);
        make.top.equalTo(ws.bigImage);
        make.right.equalTo(ws.contentView.mas_right).offset(-10);
        //make.bottom.equalTo(ws.bigImage.mas_centerY);
    }];
    self.priceLabel = [[UILabel alloc]init];
    self.priceLabel.numberOfLines = 2;
    self.priceLabel.font = [UIFont systemFontOfSize:18];
    self.priceLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.bigImage.mas_right).offset(10);
        make.bottom.equalTo(ws.contentView.mas_bottom).offset(-10);
        // make.top.equalTo(ws.bigImage.mas_centerY);
    }];

    
    self.addToShoppingCar = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addToShoppingCar setImage:[UIImage imageNamed:@"icon_shangjiajiahao"] forState:UIControlStateNormal];
    [self.addToShoppingCar addTarget:self action:@selector(addToShopingCarAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.addToShoppingCar];
    [self.addToShoppingCar setHidden:NO];
    [self.addToShoppingCar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView.mas_right).offset(-15);
        make.centerY.equalTo(ws.priceLabel);
        make.width.equalTo(@(28));
        make.height.equalTo(@(20));
    }];
    
    
    
}
-(void)setAcType:(NSString *)acType{
    self.acTypeStr = acType;
}
-(void)setMod:(ModelForFoodList *)mod{
    self.chooseMod = mod;
    self.shopName.text = mod.godsname;
     self.priceLabel.text = [NSString stringWithFormat:@"%@ %.2f",ZBLocalized(@"฿", nil),mod.pic];
    NSString *ImgUrl = [NSString stringWithFormat:@"%@/%@",IMGBaesURL,mod.godslog];
    
    ImgUrl =  [ImgUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
  
    [self.bigImage sd_setImageWithURL:[NSURL URLWithString:ImgUrl] placeholderImage:[UIImage imageNamed:@"logo"]];
    //self.acType = self.acTypeStr;
    NSArray *arritem = mod.goodspic;
    for (NSDictionary *dic1 in arritem) {
    
        self.modId = [NSString stringWithFormat:@"%@",dic1[@"id"]];
    }
}

-(void)addToShopingCarAction:(UIButton *)btn{
    if ([self.modId isEqualToString:@"0"]) {
        [MBManager showBriefAlert:ZBLocalized(@"此商品不能选择", nil) ];
        return;
    }
     if (![self.acTypeStr isEqualToString:@"2"]) {
         [MBManager showBriefAlert:ZBLocalized(@"该商家已打烊", nil) ];
         return;
    }
    if ([self.acTypeStr isEqualToString:@"2"]) {
        if (!_delectToShoppingCar) {
            __weak typeof(self) ws = self;
            
            self.chooseCountLabel = [[UILabel alloc]init];
            self.chooseCountLabel.text = [NSString stringWithFormat:@" %ld ",(long)self.ChooseCount];
            [self.contentView addSubview:self.chooseCountLabel];
            [self.chooseCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(ws.priceLabel);
                make.right.equalTo(ws.addToShoppingCar.mas_left).offset(-5);
            }];
            self.delectToShoppingCar = [UIButton buttonWithType:UIButtonTypeCustom];
           
            self.delectToShoppingCar.layer.cornerRadius=10;
            self.delectToShoppingCar.clipsToBounds = YES;
            [self.delectToShoppingCar setImage:[UIImage imageNamed:@"icon_shangjiajianhao"] forState:UIControlStateNormal];
            [self.delectToShoppingCar addTarget:self action:@selector(delectToShopingCarAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:self.delectToShoppingCar];
            [self.delectToShoppingCar setHidden:NO];
            [self.delectToShoppingCar mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(ws.chooseCountLabel.mas_left).offset(-5);
                make.centerY.equalTo(ws.priceLabel);
                make.width.equalTo(@(28));
                make.height.equalTo(@(20));
            }];
            
        }
    }
    
    
    if (self.blockAddShopingCar) {
        self.blockAddShopingCar(self.chooseMod);
    }
}
-(void)delectToShopingCarAction:(UIButton *)btn{
    if (self.blockDelShopingCar) {
        self.blockDelShopingCar(self.chooseMod);
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
