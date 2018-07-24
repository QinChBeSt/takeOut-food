//
//  CellForMyNearSpace.m
//  takeOut
//
//  Created by 钱程 on 2018/7/19.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "CellForMyNearSpace.h"

@implementation CellForMyNearSpace
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        __weak typeof(self) ws = self;
        self.titLab = [[UILabel alloc]init];
        self.titLab.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:self.titLab];
        [self.titLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.contentView);
            make.bottom.equalTo(ws.contentView.mas_centerY);
            make.left.equalTo(ws.contentView.mas_left).offset(kWidthScale(50));
        }];
       
        self.subLab = [[UILabel alloc]init];
        self.subLab.textColor = [UIColor colorWithHexString:BaseTextGrayColor];
        self.subLab.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:self.subLab];
        [self.subLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.contentView.mas_centerY);
            make.bottom.equalTo(ws.contentView); make.left.equalTo(ws.contentView.mas_left).offset(kWidthScale(50));
        }];
        
    }
    
    
    return self;
    
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    
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
