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

    [self.contentView addSubview:self.bigImage];
    [self.bigImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(10));
        make.top.equalTo(@(10));
        make.width.equalTo(@(SCREEN_WIDTH / 4.5));
        make.height.equalTo(@(SCREEN_WIDTH / 4.5));
    }];
    _dyLabel = [[UIImageView alloc]init];
    _dyLabel.image = [UIImage imageNamed:ZBLocalized(@"icon_yidayang", nil)];

    [self.bigImage addSubview:_dyLabel];
    [_dyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bigImage);
        make.centerY.equalTo(self.bigImage);
        make.width.equalTo(self.bigImage);
        make.height.equalTo(self.bigImage);
    }];
    
    self.shopName = [[UILabel alloc]init];
    self.shopName.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.shopName];
    [self.shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.contentView.mas_top).offset(10);
        make.left.equalTo(ws.bigImage.mas_right).offset(15);
    }];

    self.shopDistance = [[UILabel alloc]init];
    self.shopDistance.font = [UIFont systemFontOfSize:10];
    self.shopDistance.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.shopDistance];
    [self.shopDistance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView.mas_right).offset(-10);
        make.top.equalTo(ws.shopName.mas_bottom).offset(10);
    }];
    [self.shopDistance setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                      forAxis:UILayoutConstraintAxisHorizontal];
    self.shopMassage = [[UILabel alloc]init];
    self.shopMassage.numberOfLines = 2;
    self.shopMassage.textColor = [UIColor lightGrayColor];
    self.shopMassage.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:self.shopMassage];
    [self.shopMassage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.bigImage.mas_right).offset(15);
        make.top.equalTo(ws.shopName.mas_bottom).offset(10);
        make.right.equalTo(ws.shopDistance.mas_left).offset(-20);
    }];
    
    self.showMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.showMoreBtn setImage:[UIImage imageNamed:@"showMore"] forState:UIControlStateNormal];
    [self.showMoreBtn addTarget:self action:@selector(toShowMoreAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.showMoreBtn];
    [self.showMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).offset(-15);
        make.top.equalTo(ws.shopMassage.mas_bottom).offset(10);
        make.height.equalTo(@(15));
        make.width.equalTo(@(30));
        
    }];
    
    
//    
//    self.shopPreferentImg1 = [[UIImageView alloc]init];
//    self.shopPreferentImg1.hidden = YES;
//    [self.contentView addSubview:self.shopPreferentImg1];
//    [self.shopPreferentImg1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(ws.bigImage.mas_right).offset(15);
//        make.top.equalTo(ws.shopMassage.mas_bottom).offset(10);
//        make.width.equalTo(@(15));
//        make.height.equalTo(@(15));
//    }];
//    
//    self.shopPreferential1 = [[UILabel alloc]init];
//    self.shopPreferential1.hidden = YES;
//    self.shopPreferential1.text = @"满10-5";
//    self.shopPreferential1.font = [UIFont systemFontOfSize:12];
//    [self.contentView addSubview:self.shopPreferential1];
//    [self.shopPreferential1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.shopPreferentImg1.mas_right).offset(10);
//        make.centerY.equalTo(ws.shopPreferentImg1);
//    }];
//    
//    self.shopPreferentImg2 = [[UIImageView alloc]init];
//    self.shopPreferentImg1.hidden = YES;
//    [self.contentView addSubview:self.shopPreferentImg2];
//    [self.shopPreferentImg2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(ws.bigImage.mas_right).offset(15);
//        make.top.equalTo(ws.shopPreferentImg1.mas_bottom).offset(10);
//        make.width.equalTo(@(15));
//        make.height.equalTo(@(15));
//    }];
//    
//    self.shopPreferential2 = [[UILabel alloc]init];
//    self.shopPreferential2.hidden = YES;
//    self.shopPreferential2.text = @"满10-5";
//    self.shopPreferential2.font = [UIFont systemFontOfSize:12];
//    [self.contentView addSubview:self.shopPreferential2];
//    [self.shopPreferential2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.shopPreferentImg2.mas_right).offset(10);
//        make.centerY.equalTo(ws.shopPreferentImg2);
//    }];
}
-(NSString *)isACType:(NSString *)optime{
    NSArray *arrayTime = [optime componentsSeparatedByString:@"-"];
    NSString *openTime = arrayTime[0];
    NSArray *openTimeArr = [openTime componentsSeparatedByString:@":"];
    NSInteger openTimeHour = [openTimeArr[0] integerValue];
    NSInteger openTimeMin =[openTimeArr[1] integerValue];
    
    NSString *closeTime = arrayTime[1];
    NSArray *closeTimeArr = [closeTime componentsSeparatedByString:@":"];
    NSInteger closeTimeHour = [closeTimeArr[0] integerValue];;
    NSInteger closeTimeMin =[closeTimeArr[1] integerValue];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSDate *data =[NSDate date];
    NSString *nowDate = [dateFormatter stringFromDate:data];
    NSArray *nowTimeArr = [nowDate componentsSeparatedByString:@":"];
    NSInteger nowTimeHour = [nowTimeArr[0] integerValue];;
    NSInteger nowTimeMin =[nowTimeArr[1] integerValue];
    
    if (nowTimeHour < openTimeHour) {
        return @"2";
        
    }
    if (nowTimeHour > closeTimeHour) {
        return @"2";
    }
    
    //开门小时一样 分钟符合
    else if (nowTimeHour == openTimeHour && nowTimeMin <openTimeMin){
        return @"2";
    }
    else if (nowTimeHour == closeTimeHour && nowTimeHour >closeTimeHour){
        return @"2";
    }



    return @"1";
}
-(void)toShowMoreAction{
    if (self.blockChooseShow) {
        self.blockChooseShow(@"1");
    }
}

-(void)setMod:(ModelForShopList *)mod{
    self.shopName.text = mod.store_name;
    NSString *cyType = [self isACType:mod.opentime];
    if ([cyType isEqualToString:@"2"]) {
        NSString *url = [NSString stringWithFormat:@"%@",mod.store_img];
        
        [self.bigImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"logo"]];
        self.dyLabel.hidden = NO;
        
        //[self.bigImage sd_setImageWithURL:photourl];
    }else{
        
        self.dyLabel.hidden = YES;
        NSString *url = [NSString stringWithFormat:@"%@",mod.store_img];
        
        [self.bigImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"logo"]];
    }
   
    
    
   
    
    NSString *time =mod.send_time;
    NSArray *array = [time componentsSeparatedByString:@"m"];
    CGFloat timeInt = [array[0] floatValue];
    
    int disint = [mod.send_dis intValue];
    float disFloat;
    NSString *dis;
//    if (disint >= 1000) {
//        disFloat = (float)disint / (float)1000;
//        dis = [NSString stringWithFormat:@"%.fmin | %.2fKm",timeInt,disFloat];
//    }else{
        disFloat = disint;
        dis = [NSString stringWithFormat:@"%.fmin | %.fKm",timeInt,disFloat];
   // }
   
    self.shopDistance.text = dis;
    NSString *yueShou = [NSString stringWithFormat:@"👍%@",mod.per_mean];
    NSString *msg = [NSString stringWithFormat:@"%@%@ | %@%@ | %@%@",ZBLocalized(@"配送：฿", nil),mod.send_pic,ZBLocalized(@"起送：฿", nil),mod.up_pic,yueShou,ZBLocalized(@"份", nil)];
    self.shopMassage.text = msg;
    __weak typeof(self) ws = self;
    
    if (mod.act_list.count <= 2) {
        self.showMoreBtn.hidden = YES;
    }
    
    if (self.isShowLong == [NSNumber numberWithBool:YES]) {
        [self.longSaveView removeFromSuperview];
        [self.shortSaceView removeFromSuperview];
        
        self.longSaveView = [[UIView alloc]init];
        [self.contentView addSubview:self.longSaveView];
        [self.longSaveView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.bigImage.mas_right).offset(15);
            make.top.equalTo(ws.shopMassage.mas_bottom).offset(10 );
            make.width.equalTo(@(100));
            make.height.equalTo(@(10 + mod.act_list.count* 25));
        }];
        for (int i = 0 ; i < mod.act_list.count; i++) {
            NSString *savr1Str =mod.act_list[i][@"content"];
            NSArray *arraySave1 = [savr1Str componentsSeparatedByString:@","];
            NSString *CHSave1Str;
            NSString *THSave1Str;
            NSString *ENSave1Str;
            NSString *SHOWSaveStr1;
            if (arraySave1.count == 1) {
                CHSave1Str =savr1Str;
                THSave1Str = savr1Str;
                ENSave1Str = savr1Str;
            }else if(arraySave1.count == 2){
                CHSave1Str =arraySave1[0];
                THSave1Str = arraySave1[1];
                ENSave1Str = arraySave1[1];
            }else{
                CHSave1Str =arraySave1[0];
                THSave1Str = arraySave1[1];
                ENSave1Str = arraySave1[2];
            }
            
            NSString *language=[[ZBLocalized sharedInstance]currentLanguage];
            if ([language isEqualToString:@"th"]) {
                SHOWSaveStr1 =THSave1Str;
            }
            else if ([language isEqualToString:@"zh-Hans"]) {
                SHOWSaveStr1 = CHSave1Str;
            }
            else if ([language isEqualToString:@"en"]) {
                SHOWSaveStr1 = ENSave1Str;
            }
            NSString *imgUrl =[NSString stringWithFormat:@"%@/%@",BASEURL,mod.act_list[i][@"img"]] ;
            
            
           self.shopPreferentImg1 = [[UIImageView alloc]init];
            [self.longSaveView addSubview:self.shopPreferentImg1];
            [self.shopPreferentImg1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(ws.bigImage.mas_right).offset(15);
                make.top.equalTo(ws.shopMassage.mas_bottom).offset(10 + i* 25);
                make.width.equalTo(@(15));
                make.height.equalTo(@(15));
            }];
            
            self.shopPreferential1 = [[UILabel alloc]init];
            self.shopPreferential1.text = @"满10-5";
            self.shopPreferential1.font = [UIFont systemFontOfSize:12];
            [self.longSaveView addSubview:self.shopPreferential1];
            [self.shopPreferential1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.shopPreferentImg1.mas_right).offset(10);
                make.centerY.equalTo(self.shopPreferentImg1);
            }];
            
            [self.shopPreferentImg1 sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
            self.shopPreferential1.text = SHOWSaveStr1;
        }
        
        
    }else{
        [self.longSaveView removeFromSuperview];
        [self.shortSaceView removeFromSuperview];
        self.shortSaceView = [[UIView alloc]init];
        [self.contentView addSubview:self.shortSaceView];
        [self.shortSaceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ws.bigImage.mas_right).offset(15);
            make.top.equalTo(ws.shopMassage.mas_bottom).offset(10 );
            make.width.equalTo(@(100));
            make.height.equalTo(@(60));
        }];
        if (mod.act_list.count >= 2) {
            for (int i = 0 ; i < 2; i++) {
                NSString *savr1Str =mod.act_list[i][@"content"];
                NSArray *arraySave1 = [savr1Str componentsSeparatedByString:@","];
                NSString *CHSave1Str;
                NSString *THSave1Str;
                NSString *ENSave1Str;
                NSString *SHOWSaveStr1;
                if (arraySave1.count == 1) {
                    CHSave1Str =savr1Str;
                    THSave1Str = savr1Str;
                    ENSave1Str = savr1Str;
                }else if(arraySave1.count == 2){
                    CHSave1Str =arraySave1[0];
                    THSave1Str = arraySave1[1];
                    ENSave1Str = arraySave1[1];
                }else{
                    CHSave1Str =arraySave1[0];
                    THSave1Str = arraySave1[1];
                    ENSave1Str = arraySave1[2];
                }
                
                NSString *language=[[ZBLocalized sharedInstance]currentLanguage];
                if ([language isEqualToString:@"th"]) {
                    SHOWSaveStr1 =THSave1Str;
                }
                else if ([language isEqualToString:@"zh-Hans"]) {
                    SHOWSaveStr1 = CHSave1Str;
                }
                else if ([language isEqualToString:@"en"]) {
                    SHOWSaveStr1 = ENSave1Str;
                }
                NSString *imgUrl =[NSString stringWithFormat:@"%@/%@",BASEURL,mod.act_list[i][@"img"]] ;
                
                __weak typeof(self) ws = self;
                UIImageView *shopPreferentImg1 = [[UIImageView alloc]init];
                [self.shortSaceView addSubview:shopPreferentImg1];
                [shopPreferentImg1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(ws.bigImage.mas_right).offset(15);
                    make.top.equalTo(ws.shopMassage.mas_bottom).offset(10 + i* 25);
                    make.width.equalTo(@(15));
                    make.height.equalTo(@(15));
                }];
                
                UILabel *shopPreferential1 = [[UILabel alloc]init];
                shopPreferential1.text = @"满10-5";
                shopPreferential1.font = [UIFont systemFontOfSize:12];
                [self.shortSaceView addSubview:shopPreferential1];
                [shopPreferential1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(shopPreferentImg1.mas_right).offset(10);
                    make.centerY.equalTo(shopPreferentImg1);
                }];
                
                [shopPreferentImg1 sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
                shopPreferential1.text = SHOWSaveStr1;
            }
        }else{
            for (int i = 0 ; i < 1; i++) {
                NSString *savr1Str =mod.act_list[i][@"content"];
                NSArray *arraySave1 = [savr1Str componentsSeparatedByString:@","];
                NSString *CHSave1Str;
                NSString *THSave1Str;
                NSString *ENSave1Str;
                NSString *SHOWSaveStr1;
                if (arraySave1.count == 1) {
                    CHSave1Str =savr1Str;
                    THSave1Str = savr1Str;
                    ENSave1Str = savr1Str;
                }else if(arraySave1.count == 2){
                    CHSave1Str =arraySave1[0];
                    THSave1Str = arraySave1[1];
                    ENSave1Str = arraySave1[1];
                }else{
                    CHSave1Str =arraySave1[0];
                    THSave1Str = arraySave1[1];
                    ENSave1Str = arraySave1[2];
                }
                
                NSString *language=[[ZBLocalized sharedInstance]currentLanguage];
                if ([language isEqualToString:@"th"]) {
                    SHOWSaveStr1 =THSave1Str;
                }
                else if ([language isEqualToString:@"zh-Hans"]) {
                    SHOWSaveStr1 = CHSave1Str;
                }
                else if ([language isEqualToString:@"en"]) {
                    SHOWSaveStr1 = ENSave1Str;
                }
                NSString *imgUrl =[NSString stringWithFormat:@"%@/%@",BASEURL,mod.act_list[i][@"img"]] ;
                
                __weak typeof(self) ws = self;
                UIImageView *shopPreferentImg1 = [[UIImageView alloc]init];
                [self.shortSaceView addSubview:shopPreferentImg1];
                [shopPreferentImg1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(ws.bigImage.mas_right).offset(15);
                    make.top.equalTo(ws.shopMassage.mas_bottom).offset(10 + i* 25);
                    make.width.equalTo(@(15));
                    make.height.equalTo(@(15));
                }];
                
                UILabel *shopPreferential1 = [[UILabel alloc]init];
                shopPreferential1.text = @"满10-5";
                shopPreferential1.font = [UIFont systemFontOfSize:12];
                [self.shortSaceView addSubview:shopPreferential1];
                [shopPreferential1 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(shopPreferentImg1.mas_right).offset(10);
                    make.centerY.equalTo(shopPreferentImg1);
                }];
                
                [shopPreferentImg1 sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
                shopPreferential1.text = SHOWSaveStr1;
            }
        }
        
        
    }
    
  
    if (mod.act_list.count == 1) {
        NSString *savr1Str =mod.act_list[0][@"content"];
        NSArray *arraySave1 = [savr1Str componentsSeparatedByString:@","];
        NSString *CHSave1Str;
        NSString *THSave1Str;
        NSString *ENSave1Str;
        NSString *SHOWSaveStr1;
        if (arraySave1.count == 1) {
            CHSave1Str =savr1Str;
            THSave1Str = savr1Str;
            ENSave1Str = savr1Str;
        }else if(arraySave1.count == 2){
            CHSave1Str =arraySave1[0];
            THSave1Str = arraySave1[1];
            ENSave1Str = arraySave1[1];
        }else{
            CHSave1Str =arraySave1[0];
            THSave1Str = arraySave1[1];
            ENSave1Str = arraySave1[2];
        }
        
        NSString *language=[[ZBLocalized sharedInstance]currentLanguage];
        if ([language isEqualToString:@"th"]) {
            SHOWSaveStr1 =THSave1Str;
        }
        else if ([language isEqualToString:@"zh-Hans"]) {
            SHOWSaveStr1 = CHSave1Str;
        }
        else if ([language isEqualToString:@"en"]) {
            SHOWSaveStr1 = ENSave1Str;
        }
        [self.shopPreferentImg1 setHidden:NO];
        [self.shopPreferential1 setHidden:NO];
        [self.shopPreferential2 setHidden:YES];
        [self.shopPreferentImg2 setHidden:YES];
        NSString *imgUrl =[NSString stringWithFormat:@"%@/%@",BASEURL,mod.act_list[0][@"img"]] ;
        [self.shopPreferentImg1 sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
        
        self.shopPreferential1.text = SHOWSaveStr1;
    }else if (mod.act_list.count > 1){
        
        NSString *savr1Str =mod.act_list[0][@"content"];
        NSArray *arraySave1 = [savr1Str componentsSeparatedByString:@","];
        NSString *CHSave1Str;
        NSString *THSave1Str;
        NSString *ENSave1Str;
        NSString *SHOWSaveStr1;
        if (arraySave1.count == 1) {
            CHSave1Str =savr1Str;
            THSave1Str = savr1Str;
            ENSave1Str = savr1Str;
        }else if(arraySave1.count == 2){
            CHSave1Str =arraySave1[0];
            THSave1Str = arraySave1[1];
            ENSave1Str = arraySave1[1];
        }else{
            CHSave1Str =arraySave1[0];
            THSave1Str = arraySave1[1];
            ENSave1Str = arraySave1[2];
        }
        
        NSString *language=[[ZBLocalized sharedInstance]currentLanguage];
        if ([language isEqualToString:@"th"]) {
            SHOWSaveStr1 =THSave1Str;
        }
        else if ([language isEqualToString:@"zh-Hans"]) {
            SHOWSaveStr1 = CHSave1Str;
        }
        else if ([language isEqualToString:@"en"]) {
            SHOWSaveStr1 = ENSave1Str;
        }
        
        
        NSString *savr2Str =mod.act_list[1][@"content"];
        NSArray *arraySave2 = [savr1Str componentsSeparatedByString:@","];
        NSString *CHSave2Str;
        NSString *THSave2Str;
        NSString *ENSave2Str;
        NSString *SHOWSaveStr2;
        if (arraySave2.count == 1) {
            CHSave2Str =savr2Str;
            THSave2Str = savr2Str;
            ENSave2Str = savr2Str;
        }else if(arraySave2.count == 2){
            CHSave2Str =arraySave2[0];
            THSave2Str = arraySave2[1];
            ENSave2Str = arraySave2[1];
        }else{
            CHSave2Str =arraySave2[0];
            THSave2Str = arraySave2[1];
            ENSave2Str = arraySave1[2];
        }
        
        if ([language isEqualToString:@"th"]) {
            SHOWSaveStr2 =THSave2Str;
        }
        else if ([language isEqualToString:@"zh-Hans"]) {
            SHOWSaveStr2 = CHSave2Str;
        }
        else if ([language isEqualToString:@"en"]) {
            SHOWSaveStr2 = ENSave2Str;
        }
        
        [self.shopPreferentImg1 setHidden:NO];
        [self.shopPreferential1 setHidden:NO];
        [self.shopPreferential2 setHidden:NO];
        [self.shopPreferentImg2 setHidden:NO];
        
        NSString *imgUrl =[NSString stringWithFormat:@"%@/%@",BASEURL,mod.act_list[0][@"img"]] ;
        [self.shopPreferentImg1 sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
       
        self.shopPreferential1.text = SHOWSaveStr1;
        
        NSString *imgUrl1 =[NSString stringWithFormat:@"%@/%@",BASEURL,mod.act_list[1][@"img"]] ;
        [self.shopPreferentImg2 sd_setImageWithURL:[NSURL URLWithString:imgUrl1]];
        self.shopPreferential2.text = SHOWSaveStr2;
    }
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
