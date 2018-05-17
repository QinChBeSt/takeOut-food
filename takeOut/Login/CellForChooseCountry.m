//
//  CellForChooseCountry.m
//  takeOut
//
//  Created by mac on 2018/5/17.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "CellForChooseCountry.h"

@implementation CellForChooseCountry

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
    self.img = [[UIImageView alloc]init];
//    [self.img setImage:[UIImage imageNamed:@"泰国"]];
    [self.contentView addSubview:self.img];
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.contentView.mas_top).offset(10);
        make.height.equalTo(@(30));
        make.width.equalTo(@(45));
        make.left.equalTo(ws.contentView.mas_left).offset(10);
    }];
    self.name = [[UILabel alloc]init];
    [self.contentView addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.img.mas_right).offset(20);
        make.centerY.equalTo(ws.img);
    }];
    
    self.Icon = [[UIImageView alloc]init];
    [self.contentView addSubview:self.Icon];
    [self.Icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-20);
        make.width.and.height.equalTo(@(15));
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
