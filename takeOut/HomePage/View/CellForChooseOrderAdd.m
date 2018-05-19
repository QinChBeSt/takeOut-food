//
//  CellForChooseOrderAdd.m
//  takeOut
//
//  Created by mac on 2018/5/19.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "CellForChooseOrderAdd.h"
#define Cellheight 141
#define listHeight 40
@implementation CellForChooseOrderAdd
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
    UIView *backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 13, SCREEN_WIDTH , Cellheight - 13)];
    backGroundView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backGroundView];
    
    self.name = [[UILabel alloc]init];
    self.name.textColor = [UIColor colorWithHexString:@"4b4b4b"];
    self.name.font = [UIFont systemFontOfSize:14];
    [backGroundView addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backGroundView.mas_left).offset(20);
        make.height.equalTo(@(45));
        make.top.equalTo(backGroundView.mas_top);
    }];
    
    self.phone = [[UILabel alloc]init];
    self.phone.textColor = [UIColor colorWithHexString:@"4b4b4b"];
    self.phone.font = [UIFont systemFontOfSize:14];
    [backGroundView addSubview:self.phone];
    [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.name.mas_right).offset(25);
        make.centerY.equalTo(ws.name);
    }];
    
    self.addressLabel = [[UILabel alloc]init];
    self.addressLabel.textColor = [UIColor colorWithHexString:@"4b4b4b"];
    self.addressLabel.numberOfLines = 2;
    self.addressLabel.font = [UIFont systemFontOfSize:14];
    [backGroundView addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backGroundView.mas_left).offset(20);
        make.top.equalTo(self.phone.mas_bottom).offset(5) ;
        make.right.equalTo(backGroundView.mas_right).offset(-15);
        make.height.equalTo(@(37.5));
    }];
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor colorWithHexString:@"e7e7e7"];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.contentView);
        make.bottom.equalTo(ws.contentView.mas_bottom).offset(-50);
        make.height.equalTo(@(0.5));
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    
    self.selectImage = [[UIImageView alloc]init];
    [self.contentView addSubview:self.selectImage];
    [self.selectImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).offset(20);
        make.bottom.equalTo(ws.contentView).mas_offset(-17.5);
        make.width.and.height.equalTo(@(15));
    }];
    
    UILabel *chooseAdd = [[UILabel alloc]init];
    chooseAdd.textColor = [UIColor colorWithHexString:@"4b4b4b"];
    chooseAdd.font = [UIFont systemFontOfSize:14];
    chooseAdd.text = ZBLocalized(@"选择地址", nil);
    [self.contentView addSubview:chooseAdd];
    [chooseAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.selectImage);
        make.left.equalTo(ws.selectImage.mas_right).offset(10);
    }];
    
    UILabel *edit = [[UILabel alloc]init];
    edit.textColor = [UIColor colorWithHexString:@"4b4b4b"];
    edit.text = ZBLocalized(@"编辑", nil);
    edit.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:edit];
    [edit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(chooseAdd);
        make.right.equalTo(ws.contentView.mas_right).offset(-15);
    }];
    UIImageView *editImg = [[UIImageView alloc]init];
    editImg.image = [UIImage imageNamed:@"编辑"];
    [self.contentView addSubview:editImg];
    [editImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(edit);
        make.right.equalTo(edit.mas_left).offset(-5);
        make.height.equalTo(@(11));
        make.width.equalTo(@(14));
    }];
    
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [editBtn addTarget:self action:@selector(toEdit) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:editBtn];
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.contentView);
        make.right.equalTo(ws.contentView);
        make.left.equalTo(editImg.mas_left).offset(-3);
        make.top.equalTo(line.mas_bottom);
    }];
}
-(void)toEdit{
    if (self.blockChooseSize) {
        self.blockChooseSize(@"1");
    }
}
-(void)setMod:(ModelForGetAddress *)Mod{
    NSString *add = [NSString stringWithFormat:@"%@ %@",Mod.userAddrsAddr,Mod.userAddrsAddrText];
    self.addressLabel.text = add;
    NSString *nameStr ;
    NSString *SexStr = [NSString stringWithFormat:@"%@",Mod.userAddrsUsex];
    if ([SexStr isEqualToString:@"1"]) {
        nameStr = [NSString stringWithFormat:@"%@  %@",Mod.userAddrsUname,ZBLocalized(@"先生", nil)];
    }else{
        nameStr = [NSString stringWithFormat:@"%@  %@",Mod.userAddrsUname,ZBLocalized(@"女士", nil)];
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
