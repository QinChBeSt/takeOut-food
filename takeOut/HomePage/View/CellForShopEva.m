//
//  CellForShopEva.m
//  takeOut
//
//  Created by mac on 2018/4/8.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "CellForShopEva.h"

@implementation CellForShopEva
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
    self.icon = [[UIImageView alloc]init];
    self.icon.backgroundColor = [UIColor orangeColor];
    self.icon.layer.cornerRadius=25;
    self.icon.clipsToBounds = YES;
    [self.contentView addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView.mas_left).offset(10);
        make.top.equalTo(ws.contentView.mas_top).offset(10);
        make.width.and.height.equalTo(@(50));
    }];
    
    self.userName = [[UILabel alloc]init];
    [self.contentView addSubview:self.userName];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.icon.mas_right).offset(10);
        make.top.equalTo(ws.icon);
    }];
    
    self.evaType = [[UILabel alloc]init];
    self.evaType.font = [UIFont systemFontOfSize:14];
    self.evaType.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.evaType];
    [self.evaType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.icon.mas_right).offset(10);
        make.top.equalTo(ws.userName.mas_bottom).offset(5);
    }];
    
    self.evaTime = [[UILabel alloc]init];
    self.evaTime.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.evaTime];
    [self.evaTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView.mas_right).offset(-10);
        make.top.equalTo(ws.userName.mas_bottom).offset(0);
    }];
    
    self.evaSub = [[UILabel alloc]init];
    self.evaSub.numberOfLines = 3;
    self.evaSub.font = [UIFont systemFontOfSize:14];
    self.evaSub.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.evaSub];
    [self.evaSub mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.icon.mas_right).offset(10);
        make.top.equalTo(ws.icon.mas_bottom);
    }];
}

-(void)setDic:(NSMutableDictionary *)dic{
    NSString *evaTypeStr = dic[@"csi"];
    if ([evaTypeStr isEqualToString:@"1"]) {
        self.evaType.text = [NSString stringWithFormat:@"%@ %@",ZBLocalized(@"评价", nil),ZBLocalized(@"满意", nil)];
    }else if ([evaTypeStr isEqualToString:@"2"]){
         self.evaType.text = [NSString stringWithFormat:@"%@ %@",ZBLocalized(@"评价", nil),ZBLocalized(@"不满意", nil)];
        
    }else if ([evaTypeStr isEqualToString:@"3"]){
        self.evaType.text = [NSString stringWithFormat:@"%@ %@",ZBLocalized(@"评价", nil),ZBLocalized(@"一般", nil)];
    }
    
    self.userName.text = dic[@"holder"];
    self.evaTime.text = dic[@"time"];
    self.evaSub.text = dic[@"content"];
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
