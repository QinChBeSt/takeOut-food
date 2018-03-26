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
@interface FoodListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *leftTable;
@property (nonatomic,strong) UITableView *rightTable;
@property (nonatomic,assign) BOOL isSelected;

@property (nonatomic , strong)NSMutableArray *arrForType;
@property (nonatomic , strong)NSMutableArray *arrForDetal;

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
