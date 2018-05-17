//
//  CellForMyAve.m
//  takeOut
//
//  Created by mac on 2018/4/11.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "CellForMyAve.h"

@implementation CellForMyAve
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    grayView.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
    [self.contentView addSubview:grayView];
    __weak typeof(self) ws = self;
    self.shopIcon = [[UIImageView alloc]init];
    [self.shopIcon setImage:[UIImage imageNamed:@"icon_pinglongdianpu"]];
    [self.contentView addSubview:self.shopIcon];
    [self.shopIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(grayView.mas_bottom).offset(10);
        make.left.equalTo(grayView.mas_left).offset(10);
        make.width.and.height.equalTo(@(20));
    }];
    
    self.shopName = [[UILabel alloc]init];
    [self.contentView addSubview:_shopName];
    [self.shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.shopIcon);
        make.left.equalTo(ws.shopIcon.mas_right).offset(10);
    }];
    
    UIView *topLine = [[UIView alloc]init];
    topLine.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.contentView);
        make.top.equalTo(ws.shopName.mas_bottom).offset(10);
        make.height.equalTo(@(0.5));
        make.left.equalTo(ws.contentView.mas_left).offset(20);
        
    }];
    
    self.shopBigImage = [[UIImageView alloc]init];
     self.shopBigImage.layer.cornerRadius=20;
     self.shopBigImage.clipsToBounds = YES;
    [self.shopBigImage setImage:[UIImage imageNamed:@"icon_touxiang"]];
    [self.contentView addSubview:self.shopBigImage];
    [self.shopBigImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLine.mas_bottom).offset(10);
        make.left.equalTo(ws.contentView.mas_left).offset(10);
        make.width.and.height.equalTo(@(40));
    }];
    
    self.userName = [[UILabel alloc]init];
    [self.contentView addSubview:_userName];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.shopBigImage.mas_centerY).offset(-10);
        make.left.equalTo(ws.shopBigImage.mas_right).offset(15);
    }];
    
    self.aveType = [[UILabel alloc]init];
    self.aveType.font = [UIFont systemFontOfSize:15];
    self.aveType.textColor = [UIColor colorWithHexString:BaseYellow];
    [self.contentView addSubview:_aveType];
    [self.aveType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.shopBigImage.mas_centerY).offset(10);
        make.left.equalTo(ws.shopBigImage.mas_right).offset(15);
    }];
    
    self.aveDate = [[UILabel alloc]init];
    self.aveDate.font = [UIFont systemFontOfSize:15];
    self.aveDate.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_aveDate];
    [self.aveDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.userName.mas_centerY);
        make.right.equalTo(ws.contentView.mas_right).offset(-20);
    }];
    
    UILabel *beeOrder = [[UILabel alloc]init];
    beeOrder.text = ZBLocalized(@"BeeOrder配送", nil);
    [self.contentView addSubview:beeOrder];
   beeOrder.font = [UIFont systemFontOfSize:14];
    beeOrder.textColor = [UIColor lightGrayColor];
    [beeOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.aveType.mas_centerY);
        make.right.equalTo(ws.contentView.mas_right).offset(-20);
    }];
    
    
    self.aveText = [[UILabel alloc]init];
    self.aveText.font = [UIFont systemFontOfSize:15];
  
    [self.contentView addSubview:_aveText];
    [self.aveText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.shopBigImage.mas_bottom).offset(10);
        make.left.equalTo(ws.aveType);
        make.bottom.equalTo(ws.contentView.mas_bottom).offset(-10);
    }];
}
-(void)setDic:(NSMutableDictionary *)dic{
    NSLog(@"%@",dic[@"txt"]);
    self.shopName.text = dic[@"shopname"];
    self.aveDate.text = dic[@"time"];
    self.aveText.text = dic[@"txt"];
    self.aveType.text = dic[@"eva"];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [defaults objectForKey:UD_USERNAME];
    self.userName.text = username;
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
