//
//  HomePageVC.m
//  takeOut
//
//  Created by mac on 2018/3/23.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "HomePageVC.h"
//VIEW
#import "SortButton.h"
#import "CollectionViewCellForHomePageChoose.h"
#import "TableViewCellForHomepageList.h"

//model
#import "ModelForHomeType.h"

#define kHeadAdderssViewHeight 40
#define kHeadSelectViewHeight 150
#define kHeadImageViewHeight 100
#define kHeadCollectionViewHeight SCREEN_WIDTH / 4 * 2

@interface HomePageVC ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
{
    UIView *headviewAddressView;
    UILabel *headviewAddressLabel;
    UIImageView *headviewImageView;
    UIView *headviewSelectView;
    UIImageView *headviewSelectLeftView;
    UIImageView *headviewSelectRightView;
    UIView *sortingView;
    SortButton *clickButton;
}
@property (nonatomic , strong)UIView *headView;
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)UICollectionView *collectionView;
@property (nonatomic , strong)UIButton *replaceButton;

@property (nonatomic , strong)NSMutableArray *arrForHomePageTypeName;
@end

@implementation HomePageVC

-(NSMutableArray*)arrForHomePageTypeName{
       if (_arrForHomePageTypeName == nil) {
               _arrForHomePageTypeName = [NSMutableArray array];
            }
        return _arrForHomePageTypeName;
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
#pragma mark - 网络请求
-(void)getNetWork{
    [self getNetWorkForBanner];
    [self getNetworkForType];
    headviewAddressLabel.text = @"陕西省西安市未央区";
    [self.tableView reloadData];
}
//banner
-(void)getNetWorkForBanner{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,LUNBOURL];
    //@"http://118.24.100.177:8080/spmvc/xmfapi/getCarousel";
    [MHNetWorkTask getWithURL:url withParameter:nil withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
        
        NSArray *dic = result[@"value"];
        NSString *bannerImg = dic[0][@"img"];
        
        [headviewImageView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1522041362507&di=a89e4dd6395100b8e799271448685c35&imgtype=0&src=http%3A%2F%2Fpic36.nipic.com%2F20131203%2F3822951_101052690000_2.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
    } withFail:^(NSError *error) {
        NSLog(@"轮播图请求错误：%@,",error);
    }];
    
}
//选择分类
-(void)getNetworkForType{
    NSString *URL = [NSString stringWithFormat:@"%@%@",BASEURL,homeTypeURL];
    [self.arrForHomePageTypeName removeAllObjects];
    [MHNetWorkTask getWithURL:URL withParameter:nil withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
        NSLog(@"%@",result);
        NSArray *arr = result[@"value"];
        for (NSDictionary *dic in arr) {
            ModelForHomeType *mod = [[ModelForHomeType alloc]init];
            mod.id = dic[@"id"];
            mod.shopTypeName = dic[@"shopTypeName"];
            [self.arrForHomePageTypeName addObject:mod];
        }
        [self.collectionView reloadData];
    } withFail:^(NSError *error) {
        
    }];
}

#pragma mark - 创建透视图
-(void)createHeadView{
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeadAdderssViewHeight + kHeadImageViewHeight + kHeadCollectionViewHeight + kHeadSelectViewHeight + 65)];
    self.headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headView];
    [self createHeadViewAddressView];
    [self createHeadviewImageView];
    [self createCollectionView];
    [self createHeadviewSelectView];
    [self createSortingView];
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
    headviewImageView.backgroundColor = [UIColor orangeColor];
    [self.headView addSubview:headviewImageView];
    [headviewImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headviewAddressView.mas_bottom);
        make.width.equalTo(headviewAddressView);
        make.centerX.equalTo(headviewAddressView);
        make.height.equalTo(@(kHeadImageViewHeight));
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
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = [UIColor grayColor];
    [self.headView addSubview:line];
    
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
  
    sortingView = [[UIView alloc]init];
    [sortingView setBackgroundColor:[UIColor whiteColor]];
    [_headView addSubview:sortingView];
    [sortingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headviewSelectView.mas_bottom);
        make.width.equalTo(headviewImageView);
        make.centerX.equalTo(headviewImageView);
        make.height.equalTo(@(65));
    }];
    
     UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    line.backgroundColor = [UIColor lightGrayColor];
    [sortingView addSubview:line];
    
    UIImageView *selectImage = [[UIImageView alloc]init];
    selectImage.backgroundColor = [UIColor orangeColor];
    [sortingView addSubview:selectImage];
    [selectImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line.mas_bottom).offset(5);
        make.left.equalTo(sortingView.mas_left).offset(20);
        make.height.equalTo(@(20));
        make.width.equalTo(@(100));
    }];

    NSArray *arrButtonTitle = @[@"综合排序",@"销量最高",@"距离最近"];
    CGFloat buttonW = SCREEN_WIDTH / arrButtonTitle.count; //按钮的宽度和高度
    CGFloat buttonH = 30;
    for (int i=0; i<arrButtonTitle.count; i++) {  // 循环创建3个按钮
        clickButton=[[SortButton alloc]initWithFrame:CGRectMake(buttonW*i, 15 + 20, buttonW, buttonH)];
        if(i==0){
            clickButton.selected=YES;  // 设置第一个为默认值
            self.replaceButton=clickButton;
        }
        
        clickButton.tag=i;
        clickButton.titleLabel.font=[UIFont systemFontOfSize:14.0];
        [clickButton setTitleColor:[UIColor grayColor]forState:UIControlStateNormal];
        [clickButton setTitleColor:[UIColor blackColor]forState:UIControlStateSelected];
        [clickButton setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        [clickButton setImage:[UIImage imageNamed:@"up"] forState:UIControlStateSelected];
        [clickButton setTitle:arrButtonTitle[i] forState:UIControlStateNormal];
        [clickButton addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [sortingView addSubview:clickButton];
        
        
    }
}

#pragma mark - 创建collecttionView
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
    [self.collectionView registerClass:[CollectionViewCellForHomePageChoose class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.delaysContentTouches = NO;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
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

#pragma mark - 创建tableView
-(void)createTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SafeAreaStatsBarHeight, self.view.frame.size.width, self.view.frame.size.height - SafeAreaStatsBarHeight) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self createHeadView];
    self.tableView.tableHeaderView = self.headView;
    
    /** 注册cell. */
    [self.tableView registerClass:[TableViewCellForHomepageList class] forCellReuseIdentifier:@"pool1"];
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
  
        TableViewCellForHomepageList *cell = [tableView dequeueReusableCellWithIdentifier:@"pool1"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone; 
        return cell;
        
   
}
/* 行高 **/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   
       return 110;
    
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
    
    return self.arrForHomePageTypeName.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCellForHomePageChoose *cell = (CollectionViewCellForHomePageChoose *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //设置数据
    cell.mod = [self.arrForHomePageTypeName objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor lightGrayColor];
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
//点击了对应的筛选条件按钮操作
-(void)clickAction:(UIButton *)sender{
    
    self.replaceButton.selected=NO;  // 改变箭头的方向
    sender.selected=YES;
    self.replaceButton=sender;
    
    [self loadData:sender.tag]; // 重新加载数据,刷新表
    
}
//加载模型数据数组
-(void)loadData:(NSInteger)tagNum{
    
}
@end
