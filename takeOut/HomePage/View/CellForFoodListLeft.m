//
//  CellForFoodListLeft.m
//  takeOut
//
//  Created by mac on 2018/4/12.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "CellForFoodListLeft.h"

@implementation CellForFoodListLeft

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
    self.typeName = [[UILabel alloc]init];
     self.typeName.font = [UIFont systemFontOfSize:14];
    
    [self.contentView addSubview:self.typeName];
    [self.typeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView.mas_left).offset(12);
        make.centerY.equalTo(ws.contentView);
    }];
    
    self.redIcon = [[UILabel alloc]init];
    self.redIcon.hidden = YES;
    self.redIcon.layer.cornerRadius = 8;
    self.redIcon.clipsToBounds = YES;
    self.redIcon.font = [UIFont systemFontOfSize:12];
    self.redIcon.textAlignment = NSTextAlignmentCenter;
    self.redIcon.textColor = [UIColor whiteColor];
    self.redIcon.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.redIcon];
    [self.redIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView.mas_right).offset(-20);
        make.top.equalTo(ws.contentView.mas_top).offset(15);
        make.width.equalTo(@(16));
        make.height.equalTo(@(16));
    }];
    
    
    

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected == YES) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.typeName.textColor = [UIColor blackColor];
    }
    else{
        self.typeName.textColor = [UIColor colorWithHexString:BaseTextGrayColor];
        self.contentView.backgroundColor = [UIColor colorWithHexString:BaseBackgroundGray];
    }
    // Configure the view for the selected state
}

@end
