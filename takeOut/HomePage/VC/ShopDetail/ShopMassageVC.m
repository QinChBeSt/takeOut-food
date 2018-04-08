//
//  ShopMassageVC.m
//  takeOut
//
//  Created by mac on 2018/3/26.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "ShopMassageVC.h"

@interface ShopMassageVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)NSString *openTime;
@end

@implementation ShopMassageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    [self getNet];
    // Do any additional setup after loading the view.
}
-(void)getNet{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,getShopShopDeatailURL];
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    [par setValue:self.shopId forKey:@"shopid"];
    [MHNetWorkTask getWithURL:url withParameter:par withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
        NSMutableDictionary *resDic = result[@"value"];
        self.openTime = [NSString stringWithFormat:@"%@:%@",NSLocalizedString(@"营业时间", nil),resDic[@"opentime"]];
       
        [self.tableView reloadData];
    } withFail:^(NSError *error) {
        
    }];
}
#pragma mark - 创建tableView
-(void)createTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    /** 注册cell. */
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"pool1"];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.top.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}
#pragma mark - tableView DataSouce
/**** 行数 ****/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pool1"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIImageView *icon = [[UIImageView alloc]init];
    icon.backgroundColor = [UIColor orangeColor];
    [cell addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.mas_left).offset(10);
        make.centerY.equalTo(cell);
        make.width.and.height.equalTo(@(20));
    }];
    
    UILabel *text = [[UILabel alloc]init];
    [cell addSubview:text];
    text.font = [UIFont systemFontOfSize:14];
    [text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).offset(20);
        make.centerY.equalTo(cell);
    }];
    if (indexPath.row == 0) {
        
        text.text = @"查看食品安全档案";
    }else if (indexPath.row == 1){
       
        text.text = self.openTime;
    }
    
    return cell;
    
    
}
/* 行高 **/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
