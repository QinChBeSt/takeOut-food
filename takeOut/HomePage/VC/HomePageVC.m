//
//  HomePageVC.m
//  takeOut
//
//  Created by mac on 2018/3/23.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "HomePageVC.h"
#define kHeadAdderssViewHeight 40
#define kHeadSelectViewHeight 150
#define kHeadImageViewHeight 100
#define kHeadCollectionViewHeight SCREEN_WIDTH / 4 * 2
@interface HomePageVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic , strong)UIView *headView;
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)UICollectionView *collectionView;
@end

@implementation HomePageVC{
    UIView *headviewAddressView;
    UILabel *headviewAddressLabel;
    UIImageView *headviewImageView;
    UIView *headviewSelectView;
    UIImageView *headviewSelectLeftView;
    UIImageView *headviewSelectRightView;
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];
    // Do any additional setup after loading the view.
    [self getNetWork];
}
-(void)getNetWork{
    headviewAddressLabel.text = @"陕西省西安市未央区";
    [self.tableView reloadData];
}
#pragma mark - 创建透视图
-(void)createHeadView{
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeadAdderssViewHeight + kHeadImageViewHeight + kHeadCollectionViewHeight + kHeadSelectViewHeight + 50)];
    self.headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headView];
    [self createHeadViewAddressView];
    [self createHeadviewImageView];
    [self createCollectionView];
    [self createHeadviewSelectView];
}
//地址栏
-(void)createHeadViewAddressView{
    headviewAddressView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeadAdderssViewHeight)];
    headviewAddressView.backgroundColor = [UIColor yellowColor];
    [self.headView addSubview:headviewAddressView];
    
    //icon
    UIImageView *locationIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
    locationIcon.backgroundColor = [UIColor orangeColor];
    [headviewAddressView addSubview:locationIcon];
    
    //地址
    headviewAddressLabel = [[UILabel alloc]init];
    headviewAddressLabel.text = @"";
    [headviewAddressView addSubview:headviewAddressLabel];
    [headviewAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(locationIcon.mas_right).offset(15);
        make.centerY.equalTo(locationIcon);
    }];
 
}
//头视图
-(void)createHeadviewImageView{
    headviewImageView = [[UIImageView alloc]init];
    headviewImageView.backgroundColor = [UIColor redColor];
    [self.headView addSubview:headviewImageView];
    [headviewImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headviewAddressView.mas_bottom);
        make.width.equalTo(headviewAddressView);
        make.centerX.equalTo(headviewAddressView);
        make.height.equalTo(@(kHeadImageViewHeight));
    }];
    
   
}
//选块
-(void)createCollectionView{
    CGFloat itemWidth = (SCREEN_WIDTH - 5 )/ 4;
    CGFloat itemHeight = (SCREEN_WIDTH - 5 ) / 4;
    UICollectionViewFlowLayout *shareflowLayout = [[UICollectionViewFlowLayout alloc] init];
    shareflowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    shareflowLayout.sectionInset = UIEdgeInsetsMake(1, 1, 1,1);
    shareflowLayout.itemSize =CGSizeMake(itemWidth, itemHeight);
    // 1.设置列间距
    shareflowLayout.minimumInteritemSpacing = 0;
    // 2.设置行间距
    shareflowLayout.minimumLineSpacing = 0;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:shareflowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.headView addSubview:self.collectionView];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.delaysContentTouches = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headviewImageView.mas_bottom);
        make.width.equalTo(headviewImageView);
        make.centerX.equalTo(headviewImageView);
        make.height.equalTo(@(kHeadCollectionViewHeight));
    }];
}
//选择
-(void)createHeadviewSelectView{
    headviewSelectView = [[UIView alloc]init];
    headviewSelectView.backgroundColor = [UIColor whiteColor];
    [self.headView addSubview:headviewSelectView];
    [headviewSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView.mas_bottom);
        make.width.equalTo(headviewImageView);
        make.centerX.equalTo(headviewImageView);
        make.height.equalTo(@(kHeadSelectViewHeight));
    }];
    
    UIImageView *selectImage = [[UIImageView alloc]init];
    selectImage.backgroundColor = [UIColor orangeColor];
    [headviewSelectView addSubview:selectImage];
    [selectImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headviewSelectView.mas_top).offset(10);
        make.left.equalTo(headviewSelectView.mas_left).offset(20);
        make.height.equalTo(@(20));
        make.width.equalTo(@(100));
    }];
    
    headviewSelectLeftView = [[UIImageView alloc]init];
    headviewSelectLeftView.backgroundColor = [UIColor orangeColor];
    [headviewSelectView addSubview:headviewSelectLeftView];
    //添加手势
    UITapGestureRecognizer * tapGestureLeft = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelectLeft)];
    [headviewSelectLeftView addGestureRecognizer:tapGestureLeft];
    [headviewSelectLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headviewSelectView.mas_left).offset(15);
        make.top.equalTo(selectImage.mas_bottom).offset(5);
        make.bottom.equalTo(headviewSelectView.mas_bottom).offset(-5);
        make.right.equalTo(headviewSelectView.mas_centerX).offset(-5);
    }];
    
    headviewSelectRightView = [[UIImageView alloc]init];
    headviewSelectRightView.backgroundColor = [UIColor orangeColor];
    [headviewSelectView addSubview:headviewSelectRightView];
    //添加手势
    UITapGestureRecognizer * tapGestureRight = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelectRight)];
    [headviewSelectLeftView addGestureRecognizer:tapGestureRight];
    [headviewSelectRightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(headviewSelectView.mas_right).offset(-15);
        make.top.equalTo(selectImage.mas_bottom).offset(5);
        make.bottom.equalTo(headviewSelectView.mas_bottom).offset(-5);
        make.left.equalTo(headviewSelectView.mas_centerX).offset(5);
    }];
 
}
//筛选排序
-(void)createSortingView{
    
}
#pragma mark - 创建tableView
-(void)createTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaStatsBarHeight, self.view.frame.size.width, self.view.frame.size.height - SafeAreaStatsBarHeight) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self createHeadView];
    self.tableView.tableHeaderView = self.headView;
    
    /** 注册cell. */
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"pool"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"pool1"];
    
    [self.view addSubview:self.tableView];
    
    
}

#pragma mark - tableView DataSouce
/**** 行数 ****/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pool"];
        cell.selectionStyle = UIAccessibilityTraitNone;
        cell.backgroundColor = [UIColor grayColor];
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pool1"];
       
        return cell;
        
    }
   return nil;
}
/* 行高 **/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return SafeAreaStatsBarHeight + 30;
    }else{
       return 100;
    }
    return 0 ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

#pragma mark collectionView代理方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return 8;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //设置数据
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",indexPath);
    
}

#pragma mark - 点击事件
-(void)tapSelectLeft{
    
}
-(void)tapSelectRight{
    
}
@end
