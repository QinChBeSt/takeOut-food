//
//  CellForMyAddress.m
//  takeOut
//
//  Created by mac on 2018/4/4.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "CellForMyAddress.h"
#define Cellheight 90
#define listHeight 40
@implementation CellForMyAddress

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setupUI];
    }
    return self;
}
-(void)setupUI{
    UIView *backGroundView = [[UIView alloc]initWithFrame:CGRectMake(5, 0, SCREEN_WIDTH - 10, Cellheight - 10)];
    backGroundView.layer.cornerRadius=10;
    backGroundView.backgroundColor = [UIColor whiteColor];
    backGroundView.clipsToBounds = YES;
    [self.contentView addSubview:backGroundView];
    
    self.addressLabel = [[UILabel alloc]init];
    self.addressLabel.font = [UIFont systemFontOfSize:14];
    [backGroundView addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backGroundView.mas_left).offset(15);
        make.centerY.equalTo(backGroundView.mas_top).offset(listHeight / 2);
    }];
    
    UIView *midLine = [[UIView alloc]initWithFrame:CGRectMake(15, listHeight, SCREEN_WIDTH - 30, 0.5)];
    midLine.backgroundColor = [UIColor lightGrayColor];
    [backGroundView addSubview:midLine];
    
    self.name = [[UILabel alloc]init];
    self.name.font = [UIFont systemFontOfSize:14];
    [backGroundView addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backGroundView.mas_left).offset(15);
        make.centerY.equalTo(backGroundView.mas_top).offset(listHeight * 1.5);
    }];
    
    self.phone = [[UILabel alloc]init];
    self.phone.font = [UIFont systemFontOfSize:14];
    [backGroundView addSubview:self.phone];
    [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.name.mas_right).offset(25);
       make.centerY.equalTo(backGroundView.mas_top).offset(listHeight * 1.5);
    }];
}
-(void)setMod:(ModelForGetAddress *)Mod{
   NSString *add = [NSString stringWithFormat:@"%@ %@",Mod.userAddrsAddr,Mod.userAddrsAddrText];
    self.addressLabel.text = add;
    NSString *nameStr ;
    NSString *SexStr = [NSString stringWithFormat:@"%@",Mod.userAddrsUsex];
    if ([SexStr isEqualToString:@"1"]) {
        nameStr = [NSString stringWithFormat:@"%@  %@",Mod.userAddrsUname,NSLocalizedString(@"先生", nil)];
    }else{
         nameStr = [NSString stringWithFormat:@"%@  %@",Mod.userAddrsUname,NSLocalizedString(@"女士", nil)];
    }
    self.name.text = nameStr;
    self.phone.text = Mod.userAddrsUphone;
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
