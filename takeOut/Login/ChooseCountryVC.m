//
//  ChooseCountryVC.m
//  takeOut
//
//  Created by mac on 2018/7/10.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "ChooseCountryVC.h"

@interface ChooseCountryVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UIView *niveView;
@property (nonatomic , strong)UITableView *tableView;
@end

@implementation ChooseCountryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNaviView];
    [self createTableView];
    
}
#pragma mark - ui
-(void)createNaviView{
    self.view.backgroundColor = [UIColor colorWithHexString:BaseBackgroundGray];
    self.niveView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SafeAreaTopHeight )];
    self.niveView.backgroundColor = [UIColor colorWithHexString:BaseYellow];
    [self.view addSubview:self.niveView];
    
    __weak typeof(self) ws = self;
    UIImageView *backImg = [[UIImageView alloc]init];
    [backImg setImage:[UIImage imageNamed:@"back_black"]];
    [self.niveView addSubview:backImg];
    [backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.niveView.mas_top).offset(SafeAreaStatsBarHeight + 5);
        make.left.equalTo(ws.niveView.mas_left).offset(15);
        make.width.equalTo(@(30));
        make.height.equalTo(@(30));
    }];
    
    UIButton *backBTN = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBTN addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.niveView addSubview:backBTN];
    [backBTN mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.niveView.mas_top).offset(SafeAreaStatsBarHeight);
        make.left.equalTo(ws.niveView.mas_left).offset(10);
        make.width.equalTo(@(40));
        make.height.equalTo(@(SafeAreaTopHeight - SafeAreaStatsBarHeight));
    }];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = [NSString stringWithFormat:@"%@",ZBLocalized(@"选择手机号归属地", nil)];
    titleLabel.textColor = [UIColor colorWithHexString:BaseTextBlackColor];
    titleLabel.numberOfLines = 2;
    titleLabel.font = [UIFont systemFontOfSize:16];
    [self.niveView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backBTN.mas_right).offset(kWidthScale(30));
        make.centerY.equalTo(backImg);
        make.right.equalTo(ws.view.mas_right).offset(-kWidthScale(30));
    }];
 
}
-(void)createTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight + kWidthScale(30), SCREEN_WIDTH, kWidthScale(200)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self.view addSubview:self.tableView];
}
#pragma mark- UITabelViewDataSource/delegat
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kWidthScale(100);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    UILabel *countryNo = [[UILabel alloc]init];
    countryNo.font = [UIFont systemFontOfSize:16];
    [cell.contentView addSubview:countryNo];
    [countryNo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(cell.contentView);
        make.right.equalTo(cell.contentView).offset(-kWidthScale(40));
    }];
    
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    if (indexPath.row == 0) {
        cell.textLabel.text = ZBLocalized(@"中国", nil);
        countryNo.text = @"+86";
    }
    else if (indexPath.row == 1){
        cell.textLabel.text = ZBLocalized(@"泰国", nil);
        countryNo.text = @"+66";
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        if (self.blockChooseShow) {
            self.blockChooseShow(@"0");
             [self back];
        }
       
    }else if (indexPath.row == 1){
        if (self.blockChooseShow) {
            self.blockChooseShow(@"1");
            [self back];
        }
    }
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
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
