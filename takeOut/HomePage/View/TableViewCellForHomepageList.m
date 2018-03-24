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
        make.width.equalTo(@(50));
        make.height.equalTo(@(50));
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
