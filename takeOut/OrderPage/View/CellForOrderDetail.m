//
//  CellForOrderDetail.m
//  takeOut
//
//  Created by mac on 2018/4/8.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "CellForOrderDetail.h"

@implementation CellForOrderDetail
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
        make.top.equalTo(ws.contentView.mas_top).offset(10);
        make.left.equalTo(ws.contentView.mas_left).offset(24);
        make.centerY.equalTo(ws.contentView);
        make.width.equalTo(ws.bigImage.mas_height);
    }];
    
    self.foodName = [[UILabel alloc]init];
    self.foodName.textColor = [UIColor colorWithHexString:@"4b4b4b"];
    self.foodName.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.foodName];
    [self.foodName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.bigImage.mas_right).offset(15);
        make.centerY.equalTo(ws.contentView.mas_centerY).offset(-25);
    }];
    
   
    
    self.foodCount = [[UILabel alloc]init];
    self.foodCount.textColor = [UIColor colorWithHexString:@"4b4b4b"];
    self.foodCount.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.foodCount];
    [self.foodCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.bigImage.mas_right).offset(15);
        make.centerY.equalTo(ws.contentView.mas_centerY).offset(25);
    }];
    
    self.foodPic = [[UILabel alloc]init];
    self.foodPic.textColor = [UIColor redColor];
    self.foodPic.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:self.foodPic];
    [self.foodPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView.mas_right).offset(-30);
        make.centerY.equalTo(ws.foodCount.mas_centerY).offset(0);
    }];
}
-(void)setDic:(NSMutableDictionary *)dic{
    self.foodName.text = dic[@"ordersGoodsName"];
    self.foodCount.text = [NSString stringWithFormat:@"x %@",dic[@"ordersGoodsNum"]];
    NSString *picStr = dic[@"ordersGoodsPic"];
    CGFloat picF  = [picStr floatValue];
    self.foodPic.text = [NSString stringWithFormat:@"%@ %.2f",ZBLocalized(@"￥", nil),picF];
    NSString *imgUrl = [NSString stringWithFormat:@"%@/%@",IMGBaesURL,dic[@"ordersGoodsLog"]];
    [self.bigImage sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"logo"]];
    
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
