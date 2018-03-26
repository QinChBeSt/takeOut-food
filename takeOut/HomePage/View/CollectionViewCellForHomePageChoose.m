//
//  CollectionViewCellForHomePageChoose.m
//  takeOut
//
//  Created by mac on 2018/3/24.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "CollectionViewCellForHomePageChoose.h"

@implementation CollectionViewCellForHomePageChoose
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        
    }
    return self;
    
}
-(void)setupUI{
    __weak typeof(self) ws = self;
    self.iconImg = [[UIImageView alloc]init];
    self.iconImg.layer.cornerRadius=ws.contentView.frame.size.width / 5 ;
    self.iconImg.clipsToBounds = YES;
    self.iconImg.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:self.iconImg];
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.contentView.mas_top).offset(15);
        make.centerX.equalTo(ws.contentView);
        make.width.equalTo(@(ws.contentView.frame.size.width / 5 * 2));
        make.height.equalTo(@(ws.contentView.frame.size.width / 5 * 2));
    }];
    
    self.titleLable = [[UILabel alloc]init];
    self.titleLable.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.titleLable];
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.iconImg);
        make.top.equalTo(ws.iconImg.mas_bottom).offset(5);
    }];
}
-(void)setMod:(ModelForHomeType *)mod{
    self.titleLable.text = mod.shopTypeName;
}
@end
