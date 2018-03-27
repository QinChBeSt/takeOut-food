//
//  CellForChooseSize.m
//  takeOut
//
//  Created by mac on 2018/3/27.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "CellForChooseSize.h"

@implementation CellForChooseSize
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        
    }
    return self;
    
}
-(void)setupUI{
    __weak typeof(self) ws = self;
    self.nameLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.contentView);
        make.centerY.equalTo(ws.contentView);
    }];
}
- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected) {
        self.backgroundColor = [UIColor yellowColor];
    }else{
        self.backgroundColor = [UIColor grayColor];
    }
    
    // Configure the view for the selected state
}
@end
