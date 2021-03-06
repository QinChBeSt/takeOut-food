//
//  CellForHomeType.m
//  takeOut
//
//  Created by mac on 2018/5/16.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "CellForHomeType.h"

@implementation CellForHomeType

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
        make.left.equalTo(@(10));
        make.top.equalTo(@(10));
        make.width.equalTo(@(SCREEN_WIDTH / 4.5));
        make.height.equalTo(@(SCREEN_WIDTH / 4.5));
    }];
    _dyLabel = [[UIImageView alloc]init];
 
    _dyLabel.image = [UIImage imageNamed:ZBLocalized(@"icon_yidayang", nil)];
    [self.bigImage addSubview:_dyLabel];
    [_dyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bigImage);
        make.centerY.equalTo(self.bigImage);
        make.width.equalTo(self.bigImage);
        make.height.equalTo(self.bigImage);
    }];
    
    self.shopName = [[UILabel alloc]init];
    self.shopName.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.shopName];
    [self.shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.contentView.mas_top).offset(10);
        make.left.equalTo(ws.bigImage.mas_right).offset(15);
    }];
    
    self.shopDistance = [[UILabel alloc]init];
    self.shopDistance.font = [UIFont systemFontOfSize:11];
    self.shopDistance.textColor = [UIColor lightGrayColor];
    self.shopDistance.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.shopDistance];
    [self.shopDistance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView.mas_right).offset(-10);
        make.centerY.equalTo(ws.shopName).offset(0);
        make.left.equalTo(ws.shopName.mas_right).offset(10);
    }];
   
    self.shopMassage = [[UILabel alloc]init];
    self.shopMassage.numberOfLines = 2;
    self.shopMassage.textColor = [UIColor lightGrayColor];
    self.shopMassage.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:self.shopMassage];
    [self.shopMassage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.bigImage.mas_right).offset(15);
        make.top.equalTo(ws.shopName.mas_bottom).offset(10);
        make.right.equalTo(ws.contentView.mas_right).offset(-20);
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
    if ([mod.acTypeStr isEqualToString:@"2"]) {
        self.dyLabel.hidden = YES;
        NSString *url = [NSString stringWithFormat:@"%@/%@",IMGBaesURL,mod.store_img];
        
        [self.bigImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"logo"]];
        
        //[self.bigImage sd_setImageWithURL:photourl];
    }else{
        self.dyLabel.hidden = NO;
    }
    

    NSString *time =mod.send_time;
    NSArray *array = [time componentsSeparatedByString:@"m"];
    CGFloat timeInt = [array[0] floatValue];
    
    int disint = [mod.send_dis intValue];
    float disFloat;
    NSString *dis;
    //    if (disint >= 1000) {
    //        disFloat = (float)disint / (float)1000;
    //        dis = [NSString stringWithFormat:@"%.fmin | %.2fKm",timeInt,disFloat];
    //    }else{
    disFloat = disint;
    dis = [NSString stringWithFormat:@"%.fmin | %.f%@",timeInt,disFloat,ZBLocalized(@"Km", nil)];
    // }
    
    self.shopDistance.text = dis;
    self.shopDistance.text = dis;
     NSString *yueShou = [NSString stringWithFormat:@"👍%@",mod.per_mean];
    NSString *msg = [NSString stringWithFormat:@"%@%@ | %@%@ | %@%@",ZBLocalized(@"配送：฿", nil),mod.send_pic,ZBLocalized(@"起送：฿", nil),mod.up_pic,yueShou,ZBLocalized(@"份", nil)];
    self.shopMassage.text = msg;
    
    if (mod.act_list.count == 1) {
        [self.shopPreferentImg1 setHidden:NO];
        [self.shopPreferential1 setHidden:NO];
        [self.shopPreferential2 setHidden:YES];
        [self.shopPreferentImg2 setHidden:YES];
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
