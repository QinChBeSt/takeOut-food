//
//  CellForOrderList.m
//  takeOut
//
//  Created by 钱程 on 2018/4/6.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "CellForOrderList.h"

@implementation CellForOrderList

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setUpUI];
    }
    
    
    return self;
    
    
}
-(void)setUpUI{
    __weak typeof(self) ws = self;
    self.shopIcon = [[UIImageView alloc]init];
    [self.shopIcon setImage:[UIImage imageNamed:@"店铺"]];
    [self.contentView addSubview:self.shopIcon];
    self.shopIcon.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .topSpaceToView(self.contentView, 10)
    .widthIs(30)
    .heightIs(30);
    
    self.shopNameLabel = [[UILabel alloc]init];
    self.shopNameLabel.textColor = [UIColor colorWithHexString:BaseTextGrayColor];
    [self.contentView addSubview:self.shopNameLabel];
    [self.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.shopIcon);
        make.left.equalTo(self.shopIcon.mas_right).offset(5);
    }];
    [self.shopNameLabel setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                      forAxis:UILayoutConstraintAxisHorizontal];
    
    UIImageView *rightIcon = [[UIImageView alloc]init];
    [rightIcon setImage:[UIImage imageNamed:@"右箭头黑"]];
    [self.contentView addSubview:rightIcon];
    [rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.shopNameLabel);
        make.left.equalTo(ws.shopNameLabel.mas_right).offset(3);
        make.width.and.height.equalTo(@(15));
    }];
    
    self.haveEvaluateLabel = [[UILabel alloc]init];
    self.haveEvaluateLabel.textColor = [UIColor colorWithHexString:BaseTextGrayColor];
    self.haveEvaluateLabel.numberOfLines = 2;
    self.haveEvaluateLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.haveEvaluateLabel];
    [self.haveEvaluateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.centerY.equalTo(self.shopIcon);
        make.left.equalTo(rightIcon.mas_right).offset(5);
    }];
    
    
    self.topLine = [[UIView alloc]init];
    self.topLine.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.topLine];
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shopIcon.mas_bottom).offset(10);
        make.centerX.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.height.equalTo(@(0.5));
    }];
    
    
    
    
    self.foodsMuch = [[UILabel alloc]init];
    self.foodsMuch.textColor = [UIColor redColor];
    [self.contentView addSubview:self.foodsMuch];
    
    self.foodsTolitLabel = [[UILabel alloc]init];
    self.foodsTolitLabel.textColor = [UIColor colorWithHexString:BaseTextGrayColor];
    [self.contentView addSubview:self.foodsTolitLabel];
   
    self.orderTimeLabel = [[UILabel alloc]init];
    self.orderTimeLabel.textColor = [UIColor colorWithHexString:BaseTextGrayColor];
    [self.contentView addSubview:self.orderTimeLabel];
    
    self.foodsView.foodsName.font = [UIFont systemFontOfSize:15];
    self.foodsView2.foodsName.font = [UIFont systemFontOfSize:15];
    self.foodsView3.foodsName.font = [UIFont systemFontOfSize:15];
    self.foodsMuch.font = [UIFont systemFontOfSize:20];
    self.foodsTolitLabel.font = [UIFont systemFontOfSize:15];
    self.orderTimeLabel.font = [UIFont systemFontOfSize:15];
    
    self.bottomLine = [[UIView alloc]init];
    self.bottomLine.backgroundColor = [UIColor colorWithHexString:BaseBackgroundGray];
    [self.contentView addSubview:self.bottomLine];
    
    self.toPJbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:_toPJbtn];
    [self.toPJbtn setTitle:ZBLocalized(@"评价", nil) forState:UIControlStateNormal];
    [self.toPJbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.toPJbtn setBackgroundColor:[UIColor colorWithHexString:BaseYellow]];
    self.toPJbtn.layer.cornerRadius=5;
    self.toPJbtn.clipsToBounds = YES;
    [self.toPJbtn addTarget:self action:@selector(buttonOnCellAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //[self setupAutoHeightWithBottomView:self.bottomLine bottomMargin:10];
}

-(void)setMod:(ModelForOrderList *)mod{
    self.shopNameLabel.text = mod.shopname;
    NSString *shopStrat = mod.shopstart;
    if ([shopStrat isEqualToString:@"2"]) {
        self.haveEvaluateLabel.text = ZBLocalized(@"商家未接单", nil);
    }
    else if ([shopStrat isEqualToString:@"3"]){
        self.haveEvaluateLabel.text = ZBLocalized(@"商家未接单", nil);
    }
    else if ([shopStrat isEqualToString:@"4"]){
        self.haveEvaluateLabel.text = ZBLocalized(@"商家已接单", nil);
    }
    else if ([shopStrat isEqualToString:@"5"]){
        self.haveEvaluateLabel.text = ZBLocalized(@"骑手未接单", nil);
    }
    else if ([shopStrat isEqualToString:@"6"]){
        self.haveEvaluateLabel.text =ZBLocalized(@"骑手已接单", nil);
    }
    else if ([shopStrat isEqualToString:@"7"]){
        self.haveEvaluateLabel.text = ZBLocalized(@"骑手到店", nil);
    }
    else if ([shopStrat isEqualToString:@"8"]){
        self.haveEvaluateLabel.text = ZBLocalized(@"骑手拿到东西", nil);
    }
    else if ([shopStrat isEqualToString:@"9"]){
        self.haveEvaluateLabel.text = ZBLocalized(@"订单完成", nil);
    }
    else if ([shopStrat isEqualToString:@"10"]){
        self.haveEvaluateLabel.text = ZBLocalized(@"未评价", nil);
    }
    else if ([shopStrat isEqualToString:@"11"]){
        self.haveEvaluateLabel.text = ZBLocalized(@"已评价", nil);
    }
    else if ([shopStrat isEqualToString:@"12"]){
        self.haveEvaluateLabel.text = ZBLocalized(@"商家已取消", nil);
    }

    
    self.foodsMuch.text = [NSString stringWithFormat:@"%@%@",ZBLocalized(@"￥", nil),mod.totalpic];
    NSString *foodsnum = [NSString stringWithFormat:@"%@",mod.goodsnum];
    self.foodsTolitLabel.text =[NSString stringWithFormat:@"%@%@%@",ZBLocalized(@"共计", nil),foodsnum,ZBLocalized(@"件商品,实付", nil)];
    self.orderTimeLabel.text = [NSString stringWithFormat:@"%@  %@",ZBLocalized(@"订单时间", nil),mod.cdata];
    NSArray *foodsArr = mod.godslist;
    
    for (int i = 0; i < mod.godslist.count; i++) {
        self.foodsView = [[ViewForOrderListFoodsName alloc]init];
        self.foodsView.foodsName.text = foodsArr[i][@"ordersGoodsName"];
        NSString *listFoodcount = foodsArr[i][@"ordersGoodsNum"];
        self.foodsView.foodsCount.text = [NSString stringWithFormat:@"x %@",listFoodcount];
        [self.contentView addSubview:self.foodsView];
        __weak typeof(self) ws = self;
        [self.foodsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(ws.contentView);
            make.width.equalTo(ws.contentView);
            make.height.equalTo(@(35));
            make.top.equalTo(ws.shopIcon.mas_bottom).offset(10 + 35 * i);
        }];
        
    }
    
    [self.foodsMuch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.top.equalTo(self.foodsView.mas_bottom).offset(15);
    }];
    [self.foodsTolitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.foodsMuch.mas_left).offset(0);
        make.centerY.equalTo(self.foodsMuch);
    }];
    
    [self.orderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.top.equalTo(self.foodsMuch.mas_bottom).offset(10);
    }];
    //9
    if ([shopStrat isEqualToString:@"9"]) {
        self.bottomLine.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView,0)
        .heightIs(50)
        .topSpaceToView(self.orderTimeLabel, 10);
        
        [self.toPJbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.bottomLine).offset(-20) ;
            make.centerY.equalTo(self.bottomLine);
            make.height.equalTo(@(40));
            make.width.equalTo(@(100));
        }];
       
        [self setupAutoHeightWithBottomView:self.bottomLine bottomMargin:15];
    }else{
        
        self.bottomLine.sd_layout
        .leftSpaceToView(self.contentView, 0)
        .rightSpaceToView(self.contentView,0)
        .heightIs(10)
        .topSpaceToView(self.orderTimeLabel, 10);
        [self setupAutoHeightWithBottomView:self.bottomLine bottomMargin:10];
    }

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)buttonOnCellAction:(UIButton *)sender {
    
    if(self.button) {
        self.button(@"1");
    }
}
//block的实现部分
- (void)handlerButtonAction:(BlockButton)block
{
    self.button= block;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
