//
//  EvaluationVC.m
//  takeOut
//
//  Created by mac on 2018/3/26.
//  Copyright © 2018年 QinChBeSt. All rights reserved.
//

#import "EvaluationVC.h"
#import "CellForShopEva.h"
@interface EvaluationVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , strong)UITableView *tableView;
@property (nonatomic , strong)UIButton *AllEva;
@property (nonatomic , strong)UIButton *badEva;
@property (nonatomic , strong)UILabel *csiLabel;
@property (nonatomic , strong)NSMutableArray *eavArr;
@property (nonatomic , strong)UIImageView *kongbaiView;
@end

@implementation EvaluationVC
-(NSMutableArray *)eavArr{
    if (_eavArr == nil) {
        _eavArr = [NSMutableArray array];
    }
    return _eavArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    [self getNetWork:@"0"];
    // Do any additional setup after loading the view.
}
-(void)getNetWork:(NSString *)type{
    //0 全部   2差评
    [self.eavArr removeAllObjects];
    NSString *url = [NSString stringWithFormat:@"%@%@",BASEURL,getShopEvaURL];
    NSMutableDictionary *par = [[NSMutableDictionary alloc]init];
    [par setValue:self.shopId forKey:@"shopid"];
    [par setValue:type forKey:@"flg"];
    [par setValue:@"0" forKey:@"page"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [manager GET:url parameters:par progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *code = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([code isEqualToString:@"1"]) {
            NSMutableDictionary *resDic = responseObject[@"value"];
            self.csiLabel.text = resDic[@"csi"];
            NSMutableArray *arr = resDic[@"dat2"];
            for (NSMutableDictionary *dic in arr) {
                [self.eavArr addObject:dic];
            }
            if (self.eavArr.count == 0) {
                self.kongbaiView.hidden = NO;
            }else{
                self.kongbaiView.hidden = YES;
            }
            [self.tableView reloadData];
            if (self.eavArr.count != 0) {
                NSIndexPath* indexPat = [NSIndexPath indexPathForRow:0 inSection:0];
                [self.tableView scrollToRowAtIndexPath:indexPat atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            }
            
        }else{
            [MBManager showBriefAlert:ZBLocalized(@"没有数据", nil)];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
   
}

#pragma mark - 创建tableView
-(void)createTableView{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 74)];
    
    [self.view addSubview:headView];
    
    self.AllEva = [UIButton buttonWithType:UIButtonTypeCustom];
    [headView addSubview:self.AllEva];
    self.AllEva.frame=CGRectMake(20, 16, SCREEN_WIDTH * 0.30, 40);
     self.AllEva.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.AllEva setTitle:ZBLocalized(@"全部", nil) forState:UIControlStateNormal];
    [self.AllEva setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.AllEva setBackgroundColor:[UIColor colorWithHexString:BaseYellow]];
    UIBezierPath *maskPath=[UIBezierPath bezierPathWithRoundedRect:self.AllEva.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer=[[CAShapeLayer alloc]init];
    maskLayer.frame=self.AllEva.bounds;
    maskLayer.path=maskPath.CGPath;
    self.AllEva.layer.mask=maskLayer;
    self.AllEva.clipsToBounds = YES;
    self.AllEva.enabled = NO;
    [self.AllEva addTarget:self action:@selector(allEvaAction) forControlEvents:UIControlEventTouchUpInside];
    [self.AllEva mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headView);
        make.height.equalTo(@(40));
        make.width.equalTo(@(SCREEN_WIDTH * 0.30));
        make.left.equalTo(headView.mas_left).offset(20);
    }];
    
    self.badEva = [UIButton buttonWithType:UIButtonTypeCustom];
    [headView addSubview:self.badEva];
    self.badEva.frame=CGRectMake(20 + SCREEN_WIDTH * 0.30, 16, SCREEN_WIDTH * 0.30, 40);
    self.badEva.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.badEva setTitle:ZBLocalized(@"差评", nil) forState:UIControlStateNormal];
    [self.badEva setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.badEva setBackgroundColor:[UIColor lightGrayColor]];
    UIBezierPath *maskPath2=[UIBezierPath bezierPathWithRoundedRect:self.badEva.bounds byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer2=[[CAShapeLayer alloc]init];
    maskLayer2.frame=self.badEva.bounds;
    maskLayer2.path=maskPath2.CGPath;
    self.badEva.layer.mask=maskLayer2;
    self.badEva.clipsToBounds = YES;
      [self.badEva addTarget:self action:@selector(badEvaAction) forControlEvents:UIControlEventTouchUpInside];
    [self.badEva mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headView);
        make.height.equalTo(@(40));
        make.width.equalTo(@(SCREEN_WIDTH * 0.30));
        make.left.equalTo(self.AllEva.mas_right).offset(0);
    }];
    __weak typeof(self) ws = self;
    self.csiLabel = [[UILabel alloc]init];
   self.csiLabel.textAlignment = NSTextAlignmentCenter;
    self.csiLabel.font = [UIFont systemFontOfSize:24];
     self.csiLabel.text = @"0.0%";
    self.csiLabel.adjustsFontSizeToFitWidth = YES;
    self.csiLabel.textColor = [UIColor colorWithHexString:BaseYellow];
    [headView addSubview:self.csiLabel];
    [_csiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.badEva.mas_top).offset(0);
        make.left.equalTo(ws.badEva.mas_right).offset(10);
        make.right.equalTo(ws.view.mas_right).offset(-10);
    }];
    
    UILabel *csiTitle = [[UILabel alloc]init];
    csiTitle.text = ZBLocalized(@"商家评分", nil);
    csiTitle.textAlignment = NSTextAlignmentCenter;
    csiTitle.textColor = [UIColor lightGrayColor];
    csiTitle.adjustsFontSizeToFitWidth = YES;
    [headView addSubview:csiTitle];
    [csiTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws.badEva.mas_bottom).offset(0);
        make.left.equalTo(ws.badEva.mas_right).offset(10);
        make.right.equalTo(ws.view.mas_right).offset(-10);
    }];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    /** 注册cell. */
    [self.tableView registerClass:[CellForShopEva class] forCellReuseIdentifier:@"pool1"];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.top.equalTo(headView.mas_bottom);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    self.kongbaiView = [[UIImageView alloc]init];
    self.kongbaiView.image = [UIImage imageNamed:ZBLocalized(@"bg_zanwupinglun", nil)];
    [self.view addSubview:self.kongbaiView];
    [self.kongbaiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws.view);
        make.width.equalTo(ws.view);
        make.top.equalTo(headView.mas_bottom);
        make.bottom.equalTo(ws.view.mas_bottom);
    }];
}

#pragma mark - tableView DataSouce
/**** 行数 ****/
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.eavArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    CellForShopEva *cell = [tableView dequeueReusableCellWithIdentifier:@"pool1"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSMutableDictionary *dic = [self.eavArr objectAtIndex:indexPath.row];
    cell.dic = dic;
    return cell;
    
  
}
/* 行高 **/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
    
    
}
-(void)badEvaAction{
    [self.AllEva setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.AllEva setBackgroundColor:[UIColor lightGrayColor]];
    [self.badEva setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.badEva setBackgroundColor:[UIColor colorWithHexString:BaseYellow]];
    self.AllEva.enabled = YES;
    self.badEva.enabled = NO;
    [self getNetWork:@"2"];
    
}
-(void)allEvaAction{
    [self.badEva setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.badEva setBackgroundColor:[UIColor lightGrayColor]];
    [self.AllEva setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.AllEva setBackgroundColor:[UIColor colorWithHexString:BaseYellow]];
     self.badEva.enabled = YES;
     self.AllEva.enabled = NO;
    [self getNetWork:@"0"];
    
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
