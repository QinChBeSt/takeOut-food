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
    self.layer.cornerRadius=5;
    self.clipsToBounds = YES;
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.contentView);
        make.centerY.equalTo(ws.contentView);
        make.left.equalTo(ws.contentView.mas_left).offset(10);
        make.top.equalTo(ws.contentView).offset(5);
    }];
}
- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    self.backgroundColor = [UIColor grayColor];
    if (selected) {
        self.backgroundColor = [UIColor colorWithHexString:BaseYellow];
    }else{
        self.backgroundColor = [UIColor colorWithHexString:@"e7e7e7"];
    }
    
    // Configure the view for the selected state
}
@end
