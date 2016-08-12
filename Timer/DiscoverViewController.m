//
//  DiscoverViewController.m
//  Timer
//
//  Created by LLQ on 16/5/13.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "DiscoverViewController.h"
#import "SegmentView.h"
#import "HotModel.h"
#import "HotMovieCell.h"
#import "WillModel.h"
#import "AttentionCollectionView.h"
#import "MoviecomingsCell.h"

@interface PayTicketViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView1;
    UITableView *_tableView2;
    
    
    NSMutableArray *_dataList1;
    NSMutableArray *_attentionDataList;
    NSMutableArray *_moviecomingsDataList;
    
    NSMutableDictionary *_moviecomingsDic;
    NSArray *_moviecomingsDicsKeyArray;
    
}

@end

@implementation PayTicketViewController

//复写init，设置标签栏按钮
-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        self.title = @"购票";
//        self.tabBarItem.image = [UIImage imageNamed:@"payticket_on@2x"];
        self.tabBarItem.image = [UIImage imageNamed:@"payticket"];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_top_movie_background_cover"]];
    
    
    //加载数据
    [self loadData];
    //加载表视图
    [self createTableView];
    //加载按钮组
    [self createSegmentView];
    
    
}

//解析数据
-(void)loadData{
    
    _dataList1 = [[NSMutableArray alloc] init];
    _attentionDataList = [[NSMutableArray alloc] init];
    _moviecomingsDataList = [[NSMutableArray alloc] init];
    
    //表视图一数据
    NSDictionary *dataDic1 = [CoreDataFromJson jsonObjectFromFileName:@"buy_now"];
    NSArray *array1 = [dataDic1 objectForKey:@"ms"];
    
    for (NSDictionary *dic in array1) {
        HotModel *model = [[HotModel alloc] initWithDic:dic];
        
        [_dataList1 addObject:model];
    }
    
    //表视图二数据
    NSDictionary *dataDic2 = [CoreDataFromJson jsonObjectFromFileName:@"buy_new"];
    
    //表视图二头视图数据
    NSArray *array2 = [dataDic2 objectForKey:@"attention"];
    for (NSDictionary *dic in array2) {
        WillModel *attentionModel = [[WillModel alloc] initWithDic:dic];
        [_attentionDataList addObject:attentionModel];
    }
    
    //表视图二表数据
    NSArray *array3 = [dataDic2 objectForKey:@"moviecomings"];
    _moviecomingsDic = [[NSMutableDictionary alloc] init];
    
    for (NSDictionary *dic in array3) {
        WillModel *moviecomingsModel = [[WillModel alloc] initWithDic:dic];
        //给数据模型按照月份分类
        NSString *key = [NSString stringWithFormat:@"%@",moviecomingsModel.rMonth];
        
        NSMutableArray *array = [_moviecomingsDic objectForKey:key];
        
        if (array == nil) {
            NSMutableArray *newArray = [[NSMutableArray alloc] init];
            [newArray addObject:moviecomingsModel];
            [_moviecomingsDic setObject:newArray forKey:key];
            
        }else{
            [array addObject:moviecomingsModel];
            [_moviecomingsDic setObject:array forKey:key];
        }
        
        [_moviecomingsDataList addObject:moviecomingsModel];
    }
    
    _moviecomingsDicsKeyArray = [_moviecomingsDic allKeys];
    //排序数组
    _moviecomingsDicsKeyArray = [_moviecomingsDicsKeyArray sortedArrayUsingSelector:@selector(compare:)];
}

//创建上部按钮组
-(void)createSegmentView{
    
    SegmentView *segView = [[SegmentView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    segView.titleArray = @[@"正在热映",@"即将上映"];
    segView.selectImageName = @"color_line";
    
    //block赋值
    [segView setSegmentBlock:^(NSInteger index) {
        [self tableViewMoveAction:index];
    }];
    
    
    [self.view addSubview:segView];
    
}

//表视图切换方法
-(void)tableViewMoveAction:(NSInteger)index{
    //添加动画
    [UIView animateWithDuration:0.3 animations:^{
       
        _tableView1.frame = CGRectMake(-kScreen_W*index, _tableView1.frame.origin.y, _tableView1.frame.size.width, _tableView1.frame.size.height);
        _tableView2.frame = CGRectMake(-kScreen_W*index+kScreen_W, _tableView2.frame.origin.y, _tableView2.frame.size.width, _tableView2.frame.size.height);
        
    }];
}

//创建表视图
-(void)createTableView{
    
    //表视图一
    _tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, kScreen_W, kScreen_H-50-64-50) style:UITableViewStylePlain];
    _tableView1.backgroundColor = [UIColor clearColor];
    _tableView1.delegate = self;
    _tableView1.dataSource = self;
    _tableView1.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView1];
    
    //表视图二
    _tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(kScreen_W, 50, kScreen_W, kScreen_H-50-64-50) style:UITableViewStylePlain];
    _tableView2.backgroundColor = [UIColor clearColor];
    _tableView2.delegate = self;
    _tableView2.dataSource = self;
    _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView2];
    
    //表视图二的表头视图
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 230)];
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreen_W, 50)];
    lable.text = @"最受关注";
    lable.textColor = [UIColor whiteColor];
    lable.font = [UIFont systemFontOfSize:20];
    lable.backgroundColor = [UIColor clearColor];
    
    AttentionCollectionView *aHeader = [[AttentionCollectionView alloc] initWithFrame:CGRectMake(0, 50, kScreen_W, 180)];
    aHeader.dataList = _attentionDataList;
    
    [headerView addSubview:lable];
    [headerView addSubview:aHeader];
    _tableView2.tableHeaderView = headerView;
    
    
}

#pragma mark-----UITableViewDataSource

//返回组个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == _tableView2) {
        
        return _moviecomingsDicsKeyArray.count;
    }
    
    return 1;
}

//返回每组单元格个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == _tableView1) {
        return _dataList1.count;
    }else if(tableView == _tableView2){
        
        NSArray *array = [_moviecomingsDic objectForKey:_moviecomingsDicsKeyArray[section]];
        return array.count;
    }
    return 0;
}

//返回单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _tableView1) {
        HotMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        if (cell==nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HotMovieCell" owner:nil options:nil] lastObject];
        }
        cell.image1.image = nil;
        cell.image2.image = nil;
        cell.model = _dataList1[indexPath.row];
        
        return cell;
    }if (tableView == _tableView2) {
        MoviecomingsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (cell==nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"MoviecomingsCell" owner:nil options:nil] lastObject];
        }
        NSArray *arr = [_moviecomingsDic objectForKey:_moviecomingsDicsKeyArray[indexPath.section]];
        cell.model = arr[indexPath.row];
        
        return cell;
    }
    
    return nil;
}

#pragma mark-----UITableViewDelegate

//返回单元格宽度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _tableView1) {
        return 120;
    }else if (tableView == _tableView2){
        
        return 150;
    }
    
    return 0;
}

//返回指定组的头视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (tableView == _tableView2) {
        if (section == 0) {
            return 50;
        }else{
            return 25;
        }
    }
    
    return 0;
}

//设置组头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == _tableView2) {
        if (section == 0) {
            UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_W, 50)];
            headerView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tab_bg_all@2x"]];
            headerView.layer.cornerRadius = 10;
            UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreen_W, 25)];
            lable1.text = [NSString stringWithFormat:@"  即将上映(%ld部)",_moviecomingsDataList.count];
            lable1.textColor = [UIColor whiteColor];
            UILabel *lable2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, kScreen_W, 25)];
            lable2.text = [NSString stringWithFormat:@"  0%@月",_moviecomingsDicsKeyArray[section]];
            lable2.textColor = [UIColor whiteColor];
            [headerView addSubview:lable1];
            [headerView addSubview:lable2];
            
            return headerView;
        }else{
            UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreen_W, 25)];
            lable.text = [NSString stringWithFormat:@"  0%@月",_moviecomingsDicsKeyArray[section]];
            lable.textColor = [UIColor whiteColor];
            lable.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tab_bg_all@2x"]];
            lable.layer.cornerRadius = 7;
            lable.clipsToBounds = YES;
            
            return lable;
        }
    }
    
    return nil;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
