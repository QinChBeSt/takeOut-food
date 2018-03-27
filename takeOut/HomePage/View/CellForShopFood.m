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
        //[self setupUI];
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
    
    
}
-(void)setMod:(ModelForFoodList *)mod{
    __weak typeof(self) ws = self;
    self.shopName.text = mod.godsname;
    self.priceLabel.text = [NSString stringWithFormat:@"%.2f元",mod.pic];
    if (mod.goodspic.count > 1) {
        [self.chooseSizeBtn setHidden:NO];
        [self.chooseSizeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(ws.contentView.mas_right).offset(-15);
            make.centerY.equalTo(ws.priceLabel);
            make.width.equalTo(@(25));
            make.height.equalTo(@(25));
        }];
    }
}

-(instancetype)initWithIntNum:(int)section row:(int)row{
    if (self == [super init]) {
        [self setupUI];
        self.chooseSizeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.chooseSizeBtn.backgroundColor = [UIColor orangeColor];
        self.chooseSizeBtn.tag = section *100+row+1;
        [self.chooseSizeBtn addTarget:self action:@selector(chooseSize:) forControlEvents:UIControlEventTouchUpInside];
        [self.chooseSizeBtn setHidden:YES];
        [self.contentView addSubview:self.chooseSizeBtn];
    }
    return self;
}

-(void)chooseSize:(UIButton *)btn{
    NSLog(@"xxxxxxxxxxx");
    int tag = btn.tag;
    int section = tag/100;
    int row = tag%100;
    [self.btnDelegate cellBtnClicked:section row:row];
    
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
