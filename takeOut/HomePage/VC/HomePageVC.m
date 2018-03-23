//
//  HomePageVC.m
//  takeOut
//
//  Created by mac on 2018/3/23.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "HomePageVC.h"

@interface HomePageVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *tableView;
@end

@implementation HomePageVC
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    // Do any additional setup after loading the view.
}
-(void)createTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}

//显示有几个Cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

//数据交互
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    
    return cell;
}
//因为横向tableView代替scroll故，高度为屏幕宽度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 20;
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
