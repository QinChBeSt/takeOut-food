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
    self.shopIcon = [[UIImageView alloc]init];
    self.shopIcon.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:self.shopIcon];
    self.shopIcon.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .topSpaceToView(self.contentView, 10)
    .widthIs(30)
    .heightIs(30);
    
    self.shopNameLabel = [[UILabel alloc]init];
    self.shopNameLabel.text = @"商家11";
    [self.contentView addSubview:self.shopNameLabel];
    [self.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.shopIcon);
        make.left.equalTo(self.shopIcon.mas_right).offset(5);
    }];
    
    self.haveEvaluateLabel = [[UILabel alloc]init];
    self.haveEvaluateLabel.textColor = [UIColor lightGrayColor];
    self.haveEvaluateLabel.text = @"已评价";
    [self.contentView addSubview:self.haveEvaluateLabel];
    [self.haveEvaluateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.centerY.equalTo(self.shopIcon);
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
    
    self.foodsViewBackGround = [[UIView alloc]init];
    [self.contentView addSubview:self.foodsViewBackGround];
    [self.foodsViewBackGround mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.contentView);
        make.top.equalTo(_topLine.mas_bottom).offset(5);
        make.centerX.equalTo(self.contentView);
        make.height.equalTo(@(60));
    }];
    
    self.foodsView = [[ViewForOrderListFoodsName alloc]init];
    [self.foodsViewBackGround addSubview:self.foodsView];
  
    [self.foodsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(self.topLine.mas_bottom).offset(10);
        make.height.equalTo(@(20));
        make.centerX.equalTo(self.contentView);
    }];
    self.foodsView2 = [[ViewForOrderListFoodsName alloc]init];
    [self.foodsViewBackGround addSubview:self.foodsView2];
    
    [self.foodsView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(self.foodsView.mas_bottom).offset(0);
        make.height.equalTo(@(20));
        make.centerX.equalTo(self.contentView);
    }];
    self.foodsView3 = [[ViewForOrderListFoodsName alloc]init];
    [self.foodsViewBackGround addSubview:self.foodsView3];
    
    [self.foodsView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(self.foodsView2.mas_bottom).offset(0);
        make.height.equalTo(@(20));
        make.centerX.equalTo(self.contentView);
    }];
    
    self.foodsMuch = [[UILabel alloc]init];
    self.foodsMuch.text = @"10元";
    [self.contentView addSubview:self.foodsMuch];
    [self.foodsMuch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.top.equalTo(self.foodsView3.mas_bottom).offset(15);
    }];
    self.foodsTolitLabel = [[UILabel alloc]init];
    self.foodsTolitLabel.text = @"共1件商品：";
    [self.contentView addSubview:self.foodsTolitLabel];
    [self.foodsTolitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.foodsMuch.mas_left).offset(0);
        make.centerY.equalTo(self.foodsMuch);
    }];
    
    UIView *bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:bottomLine];
    bottomLine.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView,10)
    .heightIs(0.5)
    .topSpaceToView(self.shopIcon, 130);

    [self setupAutoHeightWithBottomView:bottomLine bottomMargin:10];
}
-(void)setFoodTypeCount:(int)foodTypeCount{
    if (foodTypeCount <= 1) {
        self.foodsView.foodsName.text = @"实物名称";
        self.foodsView.foodsCount.text = @"x 1";
    }else if (foodTypeCount == 2){
        self.foodsView.foodsName.text = @"实物名称";
        self.foodsView.foodsCount.text = @"x 1";
        self.foodsView2.foodsName.text = @"实物名称";
        self.foodsView2.foodsCount.text = @"x 1";
    }else if (foodTypeCount == 3){
        self.foodsView.foodsName.text = @"实物名称";
        self.foodsView.foodsCount.text = @"x 1";
        self.foodsView2.foodsName.text = @"实物名称";
        self.foodsView2.foodsCount.text = @"x 1";
        self.foodsView3.foodsName.text = @"实物名称";
        self.foodsView3.foodsCount.text = @"x 1";
    }
}
//-(void)layoutSubviews{
//    [super layoutSubviews];
//}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
