//
//  FoodListVC.m
//  takeOut
//
//  Created by mac on 2018/3/26.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "FoodListVC.h"
#import "ModelForFoodList.h"
#import "CellForShopFood.h"
@interface FoodListVC ()<UITableViewDelegate,UITableViewDataSource,btnClickedDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UITableView *leftTable;
@property (nonatomic,strong) UITableView *rightTable;
@property (nonatomic,assign) BOOL isSelected;

@property (nonatomic , strong)NSMutableArray *arrForType;
@property (nonatomic , strong)NSMutableArray *arrForDetal;

//选择大小份View
@property (nonatomic , strong)UIView *chooseSizeBackgroundView;
@property (nonatomic , strong)UIView *chooseSizeView;
@property (nonatomic , strong)UICollectionView *collectionView;
@property (nonatomic , strong)NSMutableArray *arrForChooseSize;
@end

@implementation FoodListVC
-(NSMutableArray *)arrForType{
    if (_arrForType == nil ) {
        _arrForType = [NSMutableArray array];
    }
    return _arrForType;
}
-(NSMutableArray *)arrForDetal{
    if (_arrForDetal == nil) {
        _arrForDetal = [NSMutableArray array];
    }
    return _arrForDetal;
}
-(NSMutableArray *)arrForChooseSize{
    if (_arrForChooseSize == nil) {
        _arrForChooseSize = [NSMutableArray array];
    }
    return _arrForChooseSize;
}
#pragma makr - NetWork
-(void)getNetWork{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,shopDatailUrl];
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    int strid =[_shopId intValue];
    NSNumber *numShopId =[NSNumber numberWithInt:strid];
    [par setValue:numShopId forKey:@"shopid"];
    [MHNetWorkTask getWithURL:url withParameter:par withHttpHeader:nil withResponseType:ResponseTypeJSON withSuccess:^(id result) {
        self.arrForType = result[@"value"];
        for (NSDictionary *dic in self.arrForType) {
            NSArray *arr = dic[@"goodsLists"];
            for (NSDictionary *dic1 in arr) {
                ModelForFoodList *mod = [[ModelForFoodList alloc]init];
                mod.id = [dic1[@"id"] intValue];
                mod.godsname = dic1[@"godsname"];
                mod.godslog = dic1[@"godslog"];
                mod.ys = dic1[@"ys"];
                mod.pic = [dic1[@"pic"] floatValue];
                mod.goodspic = dic1[@"goodspic"];
                [self.arrForDetal addObject:mod];
                
            }
        }
        [self.leftTable reloadData];
        [self.rightTable reloadData];
    } withFail:^(NSError *error) {
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTableView];
    [self addChooseView];
    [self getNetWork];
}

static NSString *const resueIdleft = @"leftCell";
static NSString *const resueIdright = @"rightCell";
- (void)initTableView {
    self.leftTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width / 4, self.view.frame.size.height - SafeAreaTopHeight - 100 -36 - SafeAreaTabbarHeight) style:UITableViewStylePlain];
    self.leftTable.delegate = self;
    self.leftTable.dataSource = self;
    [self.view addSubview:self.leftTable];
    [self.leftTable registerClass:[UITableViewCell class] forCellReuseIdentifier:resueIdleft];
    [self.leftTable selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    self.rightTable = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 4, 0, self.view.frame.size.width / 4 * 3, self.view.frame.size.height - SafeAreaTopHeight - 100 -36 - SafeAreaTabbarHeight) style:UITableViewStylePlain];
    self.rightTable.dataSource = self;
    self.rightTable.delegate = self;
    [self.view addSubview:self.rightTable];
    [self.rightTable registerClass:[CellForShopFood class] forCellReuseIdentifier:resueIdright];
}
-(void)addChooseView{
    self.chooseSizeBackgroundView = [[UIView alloc]initWithFrame:self.view.frame];
    self.chooseSizeBackgroundView.backgroundColor = [UIColor colorWithHexString:@"8E9294" alpha:0.4];
    UITapGestureRecognizer *tapChooseView=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removewChooseView)];
    [self.chooseSizeBackgroundView addGestureRecognizer:tapChooseView];
    [self.view addSubview:self.chooseSizeBackgroundView];
    __weak typeof(self) ws = self;
    self.chooseSizeView = [[UIView alloc]init];
    self.chooseSizeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.chooseSizeView];
    [self.chooseSizeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.view.mas_top).offset(30);
        make.left.equalTo(ws.view.mas_left).offset(30);
        make.centerX.equalTo(ws.view.mas_centerX);
        make.height.equalTo(@(150));
    }];
    [self.chooseSizeBackgroundView setHidden:YES];
    [self.chooseSizeView setHidden:YES];
    
    CGFloat itemWidth = (SCREEN_WIDTH - 80 )/ 3;
    CGFloat itemHeight = 30;
    UICollectionViewFlowLayout *shareflowLayout = [[UICollectionViewFlowLayout alloc] init];
    shareflowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    shareflowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    shareflowLayout.itemSize =CGSizeMake(itemWidth, itemHeight);
    // 1.设置列间距
    shareflowLayout.minimumInteritemSpacing = 5;
    // 2.设置行间距
    shareflowLayout.minimumLineSpacing = 5;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:shareflowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.chooseSizeView addSubview:self.collectionView];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.delaysContentTouches = NO;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    self.collectionView.dataSource = self;
    self.collectionView.scrollEnabled = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.chooseSizeView.mas_top).offset(30);
        make.width.equalTo(ws.chooseSizeView);
        make.centerX.equalTo(ws.chooseSizeView);
        make.bottom.equalTo(ws.chooseSizeView.mas_bottom).offset(-30);
    }];
}



#pragma mark - 滚动刷新
#pragma mark ~~~~~~~~~~ TableViewDataSource ~~~~~~~~~~
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.rightTable) {
        return 100;
    }
    return 50;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.rightTable) {
        return self.arrForType.count;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTable) {
        return self.arrForType.count;
    }
    return self.arrForDetal.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (tableView == self.leftTable) {
        cell = [tableView dequeueReusableCellWithIdentifier:resueIdleft];
       NSDictionary *dic = [self.arrForType objectAtIndex:indexPath.row];
       cell.textLabel.text = dic[@"goodsTypeEntity"][@"goodsTypeName"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        return cell;
    } else {
        CellForShopFood *cell1;
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        cell1 = [tableView dequeueReusableCellWithIdentifier:resueIdright];
       //CellForShopFood *cell1 = [[CellForShopFood alloc]initWithIntNum:indexPath.section row:indexPath.row];
         cell1.btnDelegate =self;
        ModelForFoodList *mod = [self.arrForDetal objectAtIndex:indexPath.row];
        cell1.mod = mod;
        return cell1;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == self.rightTable) {
       NSDictionary * dic = [self.arrForType objectAtIndex:section];
        NSString *tit = dic[@"goodsTypeEntity"][@"goodsTypeName"];
        
        return tit;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTable) {
        [self.rightTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        self.isSelected = YES;
    }
}

// 头部视图将要显示时调用
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (tableView == self.rightTable) {
        // 判断，如果是左边点击触发的滚动，这不执行下面代码
        if (self.isSelected) {
            return;
        }
        // 获取可见视图的第一个row
        NSInteger currentSection = [[[self.rightTable indexPathsForVisibleRows] firstObject] section];
        NSIndexPath *index = [NSIndexPath indexPathForRow:currentSection inSection:0];
        // 点击左边对应区块
        [self.leftTable selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
}

// 开始拖动赋值没有点击
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    // 当右边视图将要开始拖动时，则认为没有被点击了。
    self.isSelected = NO;
}

#pragma mark - cellBtnDelegate
-(void)cellBtnClicked:(int)section row:(int)row{
    [self.arrForChooseSize removeAllObjects];
   NSDictionary *dic = [self.arrForType objectAtIndex:section];
    NSArray *arr = dic[@"goodsLists"];
    NSDictionary *dic1 = arr[row];
    self.arrForChooseSize = dic1[@"goodspic"];
    self.chooseSizeBackgroundView.hidden = NO;
    self.chooseSizeView.hidden = NO;

    [self.collectionView reloadData];
    
    
}
#pragma mark collectionView代理方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.arrForChooseSize.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //设置数据
   // cell.mod = [self.arrForHomePageTypeName objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",indexPath);
    
}

#pragma mark - 点击事件
-(void)removewChooseView{
    [self.chooseSizeBackgroundView setHidden:YES];
    [self.chooseSizeView setHidden:YES];
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
