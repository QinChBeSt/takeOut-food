//
//  TableViewCellForHomepageList.m
//  takeOut
//
//  Created by mac on 2018/3/24.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "TableViewCellForHomepageList.h"

@implementation TableViewCellForHomepageList

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
    self.bigImage.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:self.bigImage];
    [self.bigImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(10));
        make.top.equalTo(@(10));
        make.width.equalTo(@(80));
        make.height.equalTo(@(80));
    }];
    
    self.shopName = [[UILabel alloc]init];
    self.shopName.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.shopName];
    [self.shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.contentView.mas_top).offset(10);
        make.left.equalTo(ws.bigImage.mas_right).offset(15);
    }];

    self.shopDistance = [[UILabel alloc]init];
    self.shopDistance.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.shopDistance];
    [self.shopDistance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView.mas_right).offset(-10);
        make.top.equalTo(ws.shopName);
    }];
    
    self.shopMassage = [[UILabel alloc]init];
    self.shopMassage.textColor = [UIColor lightGrayColor];
    self.shopMassage.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.shopMassage];
    [self.shopMassage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.bigImage.mas_right).offset(15);
        make.top.equalTo(ws.shopName.mas_bottom).offset(10);
    }];
    
    self.shopPreferentImg1 = [[UIImageView alloc]init];
    self.shopPreferentImg1.hidden = YES;
    [self.contentView addSubview:self.shopPreferentImg1];
    [self.shopPreferentImg1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.bigImage.mas_right).offset(15);
        make.top.equalTo(ws.shopMassage.mas_bottom).offset(10);
        make.width.equalTo(@(15));
        make.height.equalTo(@(15));
    }];
    
    self.shopPreferential1 = [[UILabel alloc]init];
    self.shopPreferential1.hidden = YES;
    self.shopPreferential1.text = @"满10-5";
    self.shopPreferential1.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.shopPreferential1];
    [self.shopPreferential1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopPreferentImg1.mas_right).offset(10);
        make.centerY.equalTo(ws.shopPreferentImg1);
    }];
    
    self.shopPreferentImg2 = [[UIImageView alloc]init];
    self.shopPreferentImg1.hidden = YES;
    [self.contentView addSubview:self.shopPreferentImg2];
    [self.shopPreferentImg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.bigImage.mas_right).offset(15);
        make.top.equalTo(ws.shopPreferentImg1.mas_bottom).offset(10);
        make.width.equalTo(@(15));
        make.height.equalTo(@(15));
    }];
    
    self.shopPreferential2 = [[UILabel alloc]init];
    self.shopPreferential2.hidden = YES;
    self.shopPreferential2.text = @"满10-5";
    self.shopPreferential2.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.shopPreferential2];
    [self.shopPreferential2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shopPreferentImg2.mas_right).offset(10);
        make.centerY.equalTo(ws.shopPreferentImg2);
    }];
}
-(void)setMod:(ModelForShopList *)mod{
    self.shopName.text = mod.store_name;
    [self.bigImage sd_setImageWithURL:[NSURL URLWithString:mod.store_img] placeholderImage:[UIImage imageNamed:@""]];
    int disint = [mod.send_dis intValue];
    
    float disFloat = (float)disint / (float)1000;
    NSString *dis = [NSString stringWithFormat:@"%@ | %.2fKm",mod.send_time,disFloat];
    self.shopDistance.text = dis;
    NSString *msg = [NSString stringWithFormat:@"%@%@ | %@%@ | %@%@",NSLocalizedString(@"配送：￥", nil),mod.send_pic,NSLocalizedString(@"起送：￥", nil),mod.up_pic,NSLocalizedString(@"月售：", nil),mod.per_mean];
    self.shopMassage.text = msg;
    
    if (mod.act_list.count == 1) {
        [self.shopPreferentImg1 setHidden:NO];
        [self.shopPreferential1 setHidden:NO];
        NSString *imgUrl =[NSString stringWithFormat:@"%@/%@",BASEURL,mod.act_list[0][@"img"]] ;
        [self.shopPreferentImg1 sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
        
        self.shopPreferential1.text = mod.act_list[0][@"content"];
    }else if (mod.act_list.count > 1){
        [self.shopPreferentImg1 setHidden:NO];
        [self.shopPreferential1 setHidden:NO];
        [self.shopPreferential2 setHidden:NO];
        [self.shopPreferentImg2 setHidden:NO];
        
        NSString *imgUrl =[NSString stringWithFormat:@"%@/%@",BASEURL,mod.act_list[0][@"img"]] ;
        [self.shopPreferentImg1 sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
        self.shopPreferential1.text = mod.act_list[0][@"content"];
        
        NSString *imgUrl1 =[NSString stringWithFormat:@"%@/%@",BASEURL,mod.act_list[1][@"img"]] ;
        [self.shopPreferentImg2 sd_setImageWithURL:[NSURL URLWithString:imgUrl1]];
        self.shopPreferential2.text = mod.act_list[1][@"content"];
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
