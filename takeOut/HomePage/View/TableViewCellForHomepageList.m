//
//  TableViewCellForHomepageList.m
//  takeOut
//
//  Created by mac on 2018/3/24.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "TableViewCellForHomepageList.h"
#import "JKSmallLabels.h"
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
        make.left.equalTo(@(kWidthScale(18)));
        make.top.equalTo(@(kWidthScale(15)));
        make.width.equalTo(@(kWidthScale(147)));
        make.height.equalTo(@(kWidthScale(110)));
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
    self.shopName.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:self.shopName];
    [self.shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.bigImage.mas_top).offset(-2) ;
        make.left.equalTo(ws.bigImage.mas_right).offset(kWidthScale(15));
        //make.height.equalTo(@(kWidthScale(45)));
    }];

    self.shopDistance = [[UILabel alloc]init];
    self.shopDistance.font = [UIFont systemFontOfSize:12];
    self.shopDistance.textColor = [UIColor lightGrayColor];
    self.shopDistance.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.shopDistance];
    [self.shopDistance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView.mas_right).offset(-10);
        make.top.equalTo(ws.bigImage.mas_top).offset(kWidthScale(45));
        make.height.equalTo(@(kWidthScale(40)));
    }];
    [self.shopDistance setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                      forAxis:UILayoutConstraintAxisHorizontal];
    
    UIImageView *muzhi = [[UIImageView alloc]init];
    [self.contentView addSubview:muzhi];
    [muzhi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.bigImage.mas_right).offset(kWidthScale(15));
        make.top.equalTo(ws.bigImage.mas_top).offset(kWidthScale(50));
        make.width.equalTo(@(kWidthScale(0)));
        make.height.equalTo(@(kWidthScale(30)));
    }];
    self.shopLikeLab = [[UILabel alloc]init];
    self.shopLikeLab.numberOfLines = 1;
    self.shopLikeLab.textColor = [UIColor lightGrayColor];
    self.shopLikeLab.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.shopLikeLab];
    [self.shopLikeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(muzhi.mas_right).offset(kWidthScale(0));
        make.top.equalTo(ws.bigImage.mas_top).offset(kWidthScale(45));
        //make.right.equalTo(ws.shopDistance.mas_left).offset(-20);
        make.height.equalTo(@(kWidthScale(40)));
    }];
    UIImageView *like = [[UIImageView alloc]init];
    like.image =[UIImage imageNamed:ZBLocalized(@"icon_zan", nil)];
    [self.contentView addSubview:like];
    [like mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.shopLikeLab.mas_right).offset(kWidthScale(4));
        make.centerY.equalTo(ws.shopLikeLab);
        make.width.equalTo(@(kWidthScale(47)));
        make.height.equalTo(@(kWidthScale(24)));
    }];
    
    
    UIImageView *Bps = [[UIImageView alloc]init];
    Bps.image = [UIImage imageNamed:@"icon_beeorderzhuansong"];
    [self.contentView addSubview:Bps];
    [Bps mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(kWidthScale(32)));
        make.width.equalTo(@(kWidthScale(80)));
        make.top.equalTo(ws.shopLikeLab.mas_bottom).offset(kWidthScale(4));
        make.right.equalTo(ws.contentView.mas_right).offset(-kWidthScale(18));
    }];
    
    self.shopMassage = [[UILabel alloc]init];
    self.shopMassage.numberOfLines = 1;
    self.shopMassage.textColor = [UIColor lightGrayColor];
    self.shopMassage.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.shopMassage];
    [self.shopMassage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.bigImage.mas_right).offset(kWidthScale(15));
        make.top.equalTo(ws.shopLikeLab.mas_bottom).offset(0);
        make.right.equalTo(Bps.mas_right).offset(-kWidthScale(18));
        make.height.equalTo(@(kWidthScale(40)));
    }];
    self.showMoreImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"showMore"]];
    [self.contentView addSubview:self.showMoreImg];
    [self.showMoreImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).offset(-kWidthScale(30));
        make.top.equalTo(ws.shopMassage.mas_bottom).offset(kWidthScale(20));
        make.height.equalTo(@(kWidthScale(70) * 0.66));
        make.width.equalTo(@(kWidthScale(70)));
        
    }];
    self.showMoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];

    [self.showMoreBtn addTarget:self action:@selector(toShowMoreAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.showMoreBtn];
    [self.showMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).offset(-15);
        make.top.equalTo(ws.shopMassage.mas_bottom).offset(10);
        make.height.equalTo(@(30));
        make.width.equalTo(@(40));
        
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
    if ([IsStringNull isBlankString:openTime]) {
        return @"1";
    }
    
    
    
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
-(NSString *)isBuss:(NSMutableArray *)arr{
    NSCalendar*calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents*comps = [[NSDateComponents alloc]init];
    
    NSInteger unitFlags =NSCalendarUnitWeekday;
    
    /*-----这里因为我只判断是周几,所以只添加了NSCalendarUnitWeekday,如果需要判断年月日的话,就需要添加NSCalendarUnitYear等,具体格式是
     
     NSInteger unitFlags =NSCalendarUnitWeekday|NSCalendarUnitYear ;
     
     -------*/
    
    
    
    NSDate*now =[NSDate date];
    
    comps = [calendar components:unitFlags fromDate:now];
    NSLog(@"-----------weekday is %ld",(long)[comps weekday]);//周
    
    NSString *openType;
    
    
    NSString *weekStr = [NSString stringWithFormat:@"%ld",(long)[comps weekday]];
    NSInteger weekInt = [weekStr integerValue];
    if (weekInt == 1) {
        weekInt = 6;
    }else{
        weekInt = weekInt - 2;
    }
    
    openType =[NSString stringWithFormat:@"%@",arr[weekInt]];
    return openType;
}
-(void)setMod:(ModelForShopList *)mod{
   
  
    self.shopName.text = mod.store_name;
    NSString *acType = mod.acTypeStr;
    NSString *buss = mod.bussiness;
    NSString *url = [NSString stringWithFormat:@"%@",mod.store_img];
    [self.bigImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"logo"]];
    //1. actype如果为2则营业,其他打烊
    if ([acType isEqualToString:@"2"]) {
        
       
        
        //3. 如果营业时间不符合，则为打烊，其他为营业（此处2位打烊，）
        if ([buss isEqualToString:@"2"]) {
     
            self.dyLabel.hidden = NO;
            
        }else
        {
            self.dyLabel.hidden = YES;
        }
             //4. 如果营业时间也符合 则判断周几是否营业，
       
    }else{

        self.dyLabel.hidden = NO;
    }
   
    
   
    
    
   
    
    NSString *time =mod.send_time;
    NSArray *array = [time componentsSeparatedByString:@"m"];
    CGFloat timeInt = [array[0] floatValue];
    
    float disFloat = [mod.send_dis floatValue];
    
    NSString *dis;
//    if (disint >= 1000) {
//        disFloat = (float)disint / (float)1000;
//        dis = [NSString stringWithFormat:@"%.fmin | %.2fKm",timeInt,disFloat];
//    }else{
        //disFloat = disint;
        dis = [NSString stringWithFormat:@"%@%.f%@ | %.2f%@",ZBLocalized(@"分钟前缀", nil),timeInt,ZBLocalized(@"分钟后缀", nil),disFloat,ZBLocalized(@"Km", nil)];
   // }
   
    self.shopDistance.text = dis;
    NSString *yueShou = [NSString stringWithFormat:@"👍%@",mod.per_mean];
    self.shopLikeLab.text = [NSString stringWithFormat:@"%@",yueShou];
    
    NSString *msg = [NSString stringWithFormat:@"%@%@ | %@%@",ZBLocalized(@"起送：฿", nil),mod.up_pic,ZBLocalized(@"配送：฿", nil),mod.send_pic];
    self.shopMassage.text = msg;
    __weak typeof(self) ws = self;
    
        self.showMoreBtn.hidden = YES;
        self.showMoreImg.hidden = YES;
    
    
    if (mod.act_list.count != 0) {
        NSMutableArray *expert_tagArray = [[NSMutableArray alloc]init];
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
            [expert_tagArray addObject:SHOWSaveStr1];
        }
        JKSmallLabels *jKSmallLabels = [[JKSmallLabels new]createEveryLabel:expert_tagArray withlabelFont:12 withlabelTextColor:[UIColor whiteColor] withlabelBackgroundColor:[UIColor whiteColor] withlabelHeight:22 withMaxWidth:SCREEN_WIDTH - kWidthScale(179) withlabelX:kWidthScale(170) withlabelY:kWidthScale(145)];
        jKSmallLabels.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:jKSmallLabels];

        [self setupAutoHeightWithBottomView:jKSmallLabels bottomMargin:10];
    }else{
        [self setupAutoHeightWithBottomView:self.bigImage bottomMargin:10];
    }
//    if (self.isShowLong == [NSNumber numberWithBool:YES]) {
//        [self.longSaveView removeFromSuperview];
//        [self.shortSaceView removeFromSuperview];
//
//        self.longSaveView = [[UIView alloc]init];
//        [self.contentView addSubview:self.longSaveView];
//        [self.longSaveView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(ws.bigImage.mas_right).offset(15);
//            make.top.equalTo(ws.shopMassage.mas_bottom).offset(10 );
//            make.width.equalTo(@(100));
//            make.height.equalTo(@(10 + mod.act_list.count* 25));
//        }];
//        if (mod.act_list.count != 0) {
//            for (int i = 0 ; i < mod.act_list.count; i++) {
//                NSString *savr1Str =mod.act_list[i][@"content"];
//                NSArray *arraySave1 = [savr1Str componentsSeparatedByString:@","];
//                NSString *CHSave1Str;
//                NSString *THSave1Str;
//                NSString *ENSave1Str;
//                NSString *SHOWSaveStr1;
//                if (arraySave1.count == 1) {
//                    CHSave1Str =savr1Str;
//                    THSave1Str = savr1Str;
//                    ENSave1Str = savr1Str;
//                }else if(arraySave1.count == 2){
//                    CHSave1Str =arraySave1[0];
//                    THSave1Str = arraySave1[1];
//                    ENSave1Str = arraySave1[1];
//                }else{
//                    CHSave1Str =arraySave1[0];
//                    THSave1Str = arraySave1[1];
//                    ENSave1Str = arraySave1[2];
//                }
//
//                NSString *language=[[ZBLocalized sharedInstance]currentLanguage];
//                if ([language isEqualToString:@"th"]) {
//                    SHOWSaveStr1 =THSave1Str;
//                }
//                else if ([language isEqualToString:@"zh-Hans"]) {
//                    SHOWSaveStr1 = CHSave1Str;
//                }
//                else if ([language isEqualToString:@"en"]) {
//                    SHOWSaveStr1 = ENSave1Str;
//                }
//               // NSString *imgUrl =[NSString stringWithFormat:@"%@/%@",BASEURL,mod.act_list[i][@"img"]] ;
//
//
////                self.shopPreferentImg1 = [[UIImageView alloc]init];
////                [self.longSaveView addSubview:self.shopPreferentImg1];
////                [self.shopPreferentImg1 mas_makeConstraints:^(MASConstraintMaker *make) {
////                    make.left.equalTo(ws.bigImage.mas_right).offset(15);
////                    make.top.equalTo(ws.shopMassage.mas_bottom).offset(10 + i* 25);
////                    make.width.equalTo(@(15));
////                    make.height.equalTo(@(15));
////                }];
//
//                self.shopPreferential1 = [[UILabel alloc]init];
//                self.shopPreferential1.text = @"满10-5";
//                self.shopPreferential1.font = [UIFont systemFontOfSize:10];
//                self.shopPreferential1.clipsToBounds = YES;
//                self.shopPreferential1.layer.borderWidth = 1;
//                self.shopPreferential1.textColor = [UIColor colorWithHexString:@"dd4545"];
//                self.shopPreferential1.layer.borderColor = [UIColor colorWithHexString:@"dd4545" alpha:0.5].CGColor;
//                [self.longSaveView addSubview:self.shopPreferential1];
//                if (i < 3) {
//                    [self.shopPreferential1 mas_makeConstraints:^(MASConstraintMaker *make) {
//                        make.left.equalTo(ws.bigImage.mas_right).offset(kWidthScale(15) + i * (SCREEN_WIDTH - kWidthScale(160))/3);
//                        make.top.equalTo(ws.shopMassage.mas_bottom).offset(10 );
//                        make.height.equalTo(@(15));
//                    }];
//                }else if (i >= 3 && i < 6){
//                    int y = i - 3;
//                    [self.shopPreferential1 mas_makeConstraints:^(MASConstraintMaker *make) {
//                        make.left.equalTo(ws.bigImage.mas_right).offset(kWidthScale(15) + y * (SCREEN_WIDTH - kWidthScale(160))/3);
//                        make.top.equalTo(ws.shopMassage.mas_bottom).offset(10 + 20 );
//                        make.height.equalTo(@(15));
//                    }];
//                }else if (i >= 6 &&i < 9){
//                    int y = i - 3;
//                    [self.shopPreferential1 mas_makeConstraints:^(MASConstraintMaker *make) {
//                        make.left.equalTo(ws.bigImage.mas_right).offset(kWidthScale(15) + y * (SCREEN_WIDTH - kWidthScale(160))/3);
//                        make.top.equalTo(ws.shopMassage.mas_bottom).offset(10 + 40 );
//                        make.height.equalTo(@(15));
//                    }];
//                }
//
//
//                //[self.shopPreferentImg1 sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
//                self.shopPreferential1.text =[NSString stringWithFormat:@" %@ ",SHOWSaveStr1] ;
//            }
//        }
//
//
//    }else{
//        [self.longSaveView removeFromSuperview];
//        [self.shortSaceView removeFromSuperview];
//        self.shortSaceView = [[UIView alloc]init];
//        [self.contentView addSubview:self.shortSaceView];
//        [self.shortSaceView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(ws.bigImage.mas_right).offset(15);
//            make.top.equalTo(ws.shopMassage.mas_bottom).offset(10 );
//            make.width.equalTo(@(100));
//            make.height.equalTo(@(50));
//        }];
//        if (mod.act_list.count >= 6) {
//            for (int i = 0 ; i < 6; i++) {
//                NSString *savr1Str =mod.act_list[i][@"content"];
//                NSArray *arraySave1 = [savr1Str componentsSeparatedByString:@","];
//                NSString *CHSave1Str;
//                NSString *THSave1Str;
//                NSString *ENSave1Str;
//                NSString *SHOWSaveStr1;
//                if (arraySave1.count == 1) {
//                    CHSave1Str =savr1Str;
//                    THSave1Str = savr1Str;
//                    ENSave1Str = savr1Str;
//                }else if(arraySave1.count == 2){
//                    CHSave1Str =arraySave1[0];
//                    THSave1Str = arraySave1[1];
//                    ENSave1Str = arraySave1[1];
//                }else{
//                    CHSave1Str =arraySave1[0];
//                    THSave1Str = arraySave1[1];
//                    ENSave1Str = arraySave1[2];
//                }
//
//                NSString *language=[[ZBLocalized sharedInstance]currentLanguage];
//                if ([language isEqualToString:@"th"]) {
//                    SHOWSaveStr1 =THSave1Str;
//                }
//                else if ([language isEqualToString:@"zh-Hans"]) {
//                    SHOWSaveStr1 = CHSave1Str;
//                }
//                else if ([language isEqualToString:@"en"]) {
//                    SHOWSaveStr1 = ENSave1Str;
//                }
//               // NSString *imgUrl =[NSString stringWithFormat:@"%@/%@",BASEURL,mod.act_list[i][@"img"]] ;
//
//                __weak typeof(self) ws = self;
////                UIImageView *shopPreferentImg1 = [[UIImageView alloc]init];
////                [self.shortSaceView addSubview:shopPreferentImg1];
////                [shopPreferentImg1 mas_makeConstraints:^(MASConstraintMaker *make) {
////                    make.left.equalTo(ws.bigImage.mas_right).offset(15);
////                    make.top.equalTo(ws.shopMassage.mas_bottom).offset(10 + i* 25);
////                    make.width.equalTo(@(15));
////                    make.height.equalTo(@(15));
////                }];
//
//                UILabel *shopPreferential1 = [[UILabel alloc]init];
//                shopPreferential1.text = @"满10-5";
//                shopPreferential1.font = [UIFont systemFontOfSize:10];
//                shopPreferential1.textColor = [UIColor colorWithHexString:@"dd4545"];
//                shopPreferential1.clipsToBounds = YES;
//                shopPreferential1.layer.borderWidth = 1;
//                shopPreferential1.layer.borderColor = [UIColor colorWithHexString:@"dd4545" alpha:0.5].CGColor;
//                [self.shortSaceView addSubview:shopPreferential1];
//
//                if (i < 3) {
//                    [shopPreferential1 mas_makeConstraints:^(MASConstraintMaker *make) {
//                        make.left.equalTo(ws.bigImage.mas_right).offset(kWidthScale(15) + i * (SCREEN_WIDTH - kWidthScale(160))/3);
//                        make.top.equalTo(ws.shopMassage.mas_bottom).offset(5 );
//                        make.height.equalTo(@(15));
//                    }];
//                }else if (i < 6){
//                    int y = 6 - i;
//                    [shopPreferential1 mas_makeConstraints:^(MASConstraintMaker *make) {
//                        make.left.equalTo(ws.bigImage.mas_right).offset(kWidthScale(15) + y * (SCREEN_WIDTH - kWidthScale(160))/3);
//                        make.top.equalTo(ws.shopMassage.mas_bottom).offset(5 +  20);
//                        make.height.equalTo(@(15));
//                    }];
//                }
//
////                [shopPreferentImg1 sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
//                shopPreferential1.text =[NSString stringWithFormat:@" %@ ",SHOWSaveStr1] ;
//            }
//        }else{
//            if (mod.act_list.count != 0) {
//                for (int i = 0 ; i < mod.act_list.count; i++) {
//                    NSString *savr1Str =mod.act_list[i][@"content"];
//                    NSArray *arraySave1 = [savr1Str componentsSeparatedByString:@","];
//                    NSString *CHSave1Str;
//                    NSString *THSave1Str;
//                    NSString *ENSave1Str;
//                    NSString *SHOWSaveStr1;
//                    if (arraySave1.count == 1) {
//                        CHSave1Str =savr1Str;
//                        THSave1Str = savr1Str;
//                        ENSave1Str = savr1Str;
//                    }else if(arraySave1.count == 2){
//                        CHSave1Str =arraySave1[0];
//                        THSave1Str = arraySave1[1];
//                        ENSave1Str = arraySave1[1];
//                    }else{
//                        CHSave1Str =arraySave1[0];
//                        THSave1Str = arraySave1[1];
//                        ENSave1Str = arraySave1[2];
//                    }
//
//                    NSString *language=[[ZBLocalized sharedInstance]currentLanguage];
//                    if ([language isEqualToString:@"th"]) {
//                        SHOWSaveStr1 =THSave1Str;
//                    }
//                    else if ([language isEqualToString:@"zh-Hans"]) {
//                        SHOWSaveStr1 = CHSave1Str;
//                    }
//                    else if ([language isEqualToString:@"en"]) {
//                        SHOWSaveStr1 = ENSave1Str;
//                    }
//                   // NSString *imgUrl =[NSString stringWithFormat:@"%@/%@",BASEURL,mod.act_list[i][@"img"]] ;
//
//                    __weak typeof(self) ws = self;
////                    UIImageView *shopPreferentImg1 = [[UIImageView alloc]init];
////                    [self.shortSaceView addSubview:shopPreferentImg1];
////                    [shopPreferentImg1 mas_makeConstraints:^(MASConstraintMaker *make) {
////                        make.left.equalTo(ws.bigImage.mas_right).offset(15);
////                        make.top.equalTo(ws.shopMassage.mas_bottom).offset(10 + i* 25);
////                        make.width.equalTo(@(15));
////                        make.height.equalTo(@(15));
////                    }];
//
//                    UILabel *shopPreferential1 = [[UILabel alloc]init];
//                    shopPreferential1.text = @"满10-5";
//                    shopPreferential1.font = [UIFont systemFontOfSize:10];
//                    shopPreferential1.textColor = [UIColor colorWithHexString:@"dd4545"];
//                    shopPreferential1.clipsToBounds = YES;
//                    shopPreferential1.layer.borderWidth = 1;
//                    shopPreferential1.layer.borderColor = [UIColor colorWithHexString:@"dd4545" alpha:0.5].CGColor;
//                    [self.shortSaceView addSubview:shopPreferential1];
//                    if (i < 3) {
//                        [shopPreferential1 mas_makeConstraints:^(MASConstraintMaker *make) {
//                            make.left.equalTo(ws.bigImage.mas_right).offset(kWidthScale(15) + i * (SCREEN_WIDTH - kWidthScale(160))/3);
//                            make.top.equalTo(ws.shopMassage.mas_bottom).offset(5 );
//                            make.height.equalTo(@(15));
//                        }];
//                    }else if (i < 6){
//                        int y =  i - 3;
//                        [shopPreferential1 mas_makeConstraints:^(MASConstraintMaker *make) {
//                            make.left.equalTo(ws.bigImage.mas_right).offset(kWidthScale(15) + y * (SCREEN_WIDTH - kWidthScale(160))/3);
//                            make.top.equalTo(ws.shopMassage.mas_bottom).offset(5 +  20);
//                            make.height.equalTo(@(15));
//                        }];
//                    }
//                    else if (i < 9){
//                        int y = i - 6;
//                        [shopPreferential1 mas_makeConstraints:^(MASConstraintMaker *make) {
//                            make.left.equalTo(ws.bigImage.mas_right).offset(kWidthScale(15) + y * (SCREEN_WIDTH - kWidthScale(160))/3);
//                            make.top.equalTo(ws.shopMassage.mas_bottom).offset(5 +  40);
//                            make.height.equalTo(@(15));
//                        }];
//                    }
//
//                    //                [shopPreferentImg1 sd_setImageWithURL:[NSURL URLWithString:imgUrl]];
//                    shopPreferential1.text =[NSString stringWithFormat:@" %@ ",SHOWSaveStr1] ;
//                }
//            }
//        }
//
    
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
