//
//  PayTicketViewController.m
//  Timer
//
//  Created by LLQ on 16/5/13.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "PayTicketViewController.h"
#import "SegmentView.h"

#import "NewsModel.h"
#import "TrailerModel.h"
#import "TopListModel.h"
#import "CriticismModel.h"
#import "NewsDatailsModel.h"

#import "NewsView.h"
#import "TrailerView.h"
#import "TopListView.h"
#import "CriticismView.h"


@interface DiscoverViewController ()
{
    NewsView *_newView;
    TrailerView *_trailerView;
    TopListView *_topListView;
    CriticismView *_criticismView;
    
    
    
    NSMutableArray *_newsDataList;
    NSMutableArray *_trailerDataList;
    NSMutableArray *_topListDataList;
    NSMutableArray *_criticismDataList;
    
}

@end

@implementation DiscoverViewController

//复写init，设置标签栏按钮
-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        self.title = @"精选";
//        self.tabBarItem.image = [UIImage imageNamed:@"discover_on@2x"];
        self.tabBarItem.image = [UIImage imageNamed:@"discover"];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"actor_detail_top_background.jpg"]];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载上部按钮组
    [self loadSegmentView];
    //加载数据
    [self loadData];
    //加载新闻视图
    [self createNewsView];
    //加载预告视图
    [self createTrailerView];
    //加载排行榜视图
    [self createTopListView];
    //加载影评视图
    [self createCriticismView];
    
}

//解析数据
-(void)loadData{
    
    //初始化数据数组
    _newsDataList = [[NSMutableArray alloc] init];
    _trailerDataList = [[NSMutableArray alloc] init];
    _topListDataList = [[NSMutableArray alloc] init];
    _criticismDataList = [[NSMutableArray alloc] init];
    
    
    //解析新闻页面的数据
     NSArray *array = [[CoreDataFromJson jsonObjectFromFileName:@"find_news"] objectForKey:@"newsList"];
    for (NSDictionary *dic in array) {
        NewsModel *newsModel = [[NewsModel alloc] initWithDic:dic];
        [_newsDataList addObject:newsModel];
    }
    
    //解析预告页面数据
    NSArray *array2 = [[CoreDataFromJson jsonObjectFromFileName:@"预告"] objectForKey:@"trailers"];
    for (NSDictionary *dic in array2) {
        TrailerModel *trailerModel = [[TrailerModel alloc] initWithDic:dic];
        [_trailerDataList addObject:trailerModel];
    }
    
    //解析排行榜页面数据
    NSArray *array3 = [[CoreDataFromJson jsonObjectFromFileName:@"rank2"] objectForKey:@"topLists"];
    for (NSDictionary *dic in array3) {
        TopListModel *topListModel = [[TopListModel alloc] initWithDic:dic];
        [_topListDataList addObject:topListModel];
    }
    
    //解析影评页面数据
    NSArray *array4 = [CoreDataFromJson jsonObjectFromFileName:@"criticism"];
    for (NSDictionary *dic in array4) {
        CriticismModel *criticismModel = [[CriticismModel alloc] initWithDic:dic];
        [_criticismDataList addObject:criticismModel];
    }
    

    
}

//创建上部按钮组
-(void)loadSegmentView{
    
    SegmentView *segmentView = [[SegmentView alloc] initWithFrame:CGRectMake(0, 0, kScreen_W, 50)];
    segmentView.titleArray = @[@"新闻",@"预告片",@"排行榜",@"影评"];
    //添加block
    [segmentView setSegmentBlock:^(NSInteger index) {
       
        //切换视图
        [self viewMoveAction:index];
        
    }];
    
    //添加到导航栏
    self.navigationItem.titleView = segmentView;
    
}

//创建新闻页面
-(void)createNewsView{
    
    _newView = [[NewsView alloc] initWithFrame:CGRectMake(0, 0, kScreen_W, kScreen_H-50-10-50)];
    _newView.dataList = _newsDataList;
    
    [self.view addSubview:_newView];
    
}

//创建预告片页面
-(void)createTrailerView{
    _trailerView = [[TrailerView alloc] initWithFrame:CGRectMake(kScreen_W, 0, kScreen_W, kScreen_H-60-50)];
    _trailerView.dataList = _trailerDataList;
    
    [self.view addSubview:_trailerView];
    
}

//创建排行榜页面
-(void)createTopListView{
    
    _topListView = [[TopListView alloc] initWithFrame:CGRectMake(2*kScreen_W, 0, kScreen_W, kScreen_H-60-50)];
    _topListView.dataList = _topListDataList;
    
    [self.view addSubview:_topListView];
    
}

//创建影评页面
-(void)createCriticismView{
    
    _criticismView = [[CriticismView alloc] initWithFrame:CGRectMake(3*kScreen_W, 0, kScreen_W, kScreen_H-60-50)];
    _criticismView.dataList = _criticismDataList;
    
    [self.view addSubview:_criticismView];
    
}

//切换视图方法
-(void)viewMoveAction:(NSInteger)index{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        _newView.transform = CGAffineTransformMakeTranslation(-kScreen_W*index, 0);
        _trailerView.transform = CGAffineTransformMakeTranslation(-kScreen_W*index, 0);
        _topListView.transform = CGAffineTransformMakeTranslation(-kScreen_W*index, 0);
        _criticismView.transform = CGAffineTransformMakeTranslation(-kScreen_W*index, 0);
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
