//
//  NewsView.m
//  Timer
//
//  Created by LLQ on 16/5/21.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "NewsView.h"
#import "NewsModel.h"
#import "NewsCell.h"
#import "NewsDatailsModel.h"
#import "NewsTableViewController.h"

@implementation NewsView
{
    UITableView *_newsTableView;
    
    NSMutableArray *_newsDatailsDataList;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //加载数据
        [self loadData];
        //加载表视图
        [self loadTableView];
        
        
    }
    return self;
}

//复写数据数组的set方法在赋值时刷新表视图
-(void)setDataList:(NSArray *)dataList{
    
    _dataList = dataList;
    
    [_newsTableView reloadData];
}

//加载表视图
-(void)loadTableView{
    
    _newsTableView = [[UITableView alloc] initWithFrame:self.bounds];
    _newsTableView.delegate = self;
    _newsTableView.dataSource = self;
    _newsTableView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:_newsTableView];
    
}

//解析数据
-(void)loadData{
    
    //初始化数组
    _newsDatailsDataList = [[NSMutableArray alloc] init];
    
    //解析新闻详情页面数据
    NSDictionary *dic = [CoreDataFromJson jsonObjectFromFileName:@"image_news"];
    NewsDatailsModel *newsDatailsModel = [[NewsDatailsModel alloc] initWithDic:dic];
    [_newsDatailsDataList addObject:newsDatailsModel];
    
}


#pragma mark-----------UITableViewDataSource

//返回每组单元格个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataList.count;
}


//返回单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsModel *model = _dataList[indexPath.row];
    NewsCell *cell_1 = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    NewsCell *cell_2 = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
    
    //如果model的type等于1，就返回第一种单元格
    if ([model.type integerValue] == 1) {
        
        if (cell_2 == nil) {
            cell_2 = [[[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:nil options:nil] lastObject];
        }
        
        cell_2.model = model;
        return cell_2;
        
        
    }else{ //不等于1，返回第二种单元格
        
        if (cell_1 == nil) {
            cell_1 = [[[NSBundle mainBundle] loadNibNamed:@"NewsCell" owner:nil options:nil] firstObject];
        }
        
        cell_1.model = model;
        return cell_1;
        
    }
    
    
    return nil;
}

#pragma mark----------UITableViewDelegate

//返回指定行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsModel *model = _dataList[indexPath.row];
    
    if ([model.type integerValue] == 1) {
        return 150;
    }else{
        
        return 160;
    }
    
}

//点击单元格时调用
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsModel *model = _dataList[indexPath.row];
    
    NewsDatailsModel *newDatailsModel = _newsDatailsDataList[0];
    
    if ([model.type integerValue] == 1) {
        
        //加载storyborad
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"NewsDatailsStoryboard" bundle:nil];
        //加载箭头指向的控制器
        NewsTableViewController *newsVC = [story instantiateInitialViewController];
        newsVC.model = newDatailsModel;
        //当push进来时，隐藏标签栏
        newsVC.navigationItem.title = newDatailsModel.title2;
//        [newsVC loadTableHeadeView];
        
        newsVC.hidesBottomBarWhenPushed = YES;
        
        //获取本视图的根视图控制器
        [self.viewController.navigationController pushViewController:newsVC animated:YES];
        
    }else{
        
        NSLog(@"新闻已加载");
    }
    
}

@end
