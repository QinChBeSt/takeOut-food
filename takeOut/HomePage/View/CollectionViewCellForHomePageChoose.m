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

    [self.contentView addSubview:self.iconImg];
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.contentView.mas_top).offset(15);
        make.centerX.equalTo(ws.contentView);
        make.width.equalTo(@(ws.contentView.frame.size.width / 5 * 2.5));
        make.height.equalTo(@(ws.contentView.frame.size.width / 5 * 2.5));
    }];
    
    self.titleLable = [[UILabel alloc]init];
    self.titleLable.font = [UIFont systemFontOfSize:12];
    self.titleLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.titleLable];
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.iconImg);
        make.top.equalTo(ws.iconImg.mas_bottom).offset(5);
        make.right.equalTo(ws.contentView);
        make.left.equalTo(ws.contentView);
    }];
}
-(void)setMod:(ModelForHomeType *)mod{
    self.titleLable.text = mod.shopTypeName;
   // NSString *modId = [NSString stringWithFormat:@"%@",mod.id];
   
//    if ([modId isEqualToString:@"1"]) {
//        [self.iconImg setImage:[UIImage imageNamed:@"icon_shouyemeishi"]];
//    }
//    else if ([modId isEqualToString:@"2"]){
//        [self.iconImg setImage:[UIImage imageNamed:@"icon_shouyemifengkuaisong"]];
//    }
//    else if ([modId isEqualToString:@"3"]){
//        [self.iconImg setImage:[UIImage imageNamed:@"icon_shouyeshuiguo"]];
//    }
//    else if ([modId isEqualToString:@"4"]){
//        [self.iconImg setImage:[UIImage imageNamed:@"icon_zhanghao-1"]];
//    }
//    else if ([modId isEqualToString:@"5"]){
//        [self.iconImg setImage:[UIImage imageNamed:@"icon_shouyedehui"]];
//    }
//    else if ([modId isEqualToString:@"6"]){
//        [self.iconImg setImage:[UIImage imageNamed:@"icon_shouyejiachangcai"]];
//    }
//    else if ([modId isEqualToString:@"7"]){
//        [self.iconImg setImage:[UIImage imageNamed:@"icon_shouyehanbao"]];
//    }
//    else if ([modId isEqualToString:@"8"]){
//        [self.iconImg setImage:[UIImage imageNamed:@"icon_shouyejichi"]];
//    }else if ([modId isEqualToString:@"9"]){
//        [self.iconImg setImage:[UIImage imageNamed:@"icon_shouyetiandian"]];
//    }else if ([modId isEqualToString:@"10"]){
//        [self.iconImg setImage:[UIImage imageNamed:@"icon_shouyedesemianshi"]];
//    }

     NSString *imgUrl = [NSString stringWithFormat:@"http://beeorder.net:8080/spmvc/apidocs/img/ic%@.png",mod.id];
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
}
@end
