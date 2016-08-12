//
//  TrailerView.m
//  Timer
//
//  Created by LLQ on 16/5/21.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "TrailerView.h"
#import "TrailerModel.h"
#import "TrailerCell.h"
#import "TrailerViewController.h"


@implementation TrailerView
{
    UITableView *_trailerTableView;
    UIImageView *_headerView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self loadTableView];
    }
    return self;
}

//dataList赋值时刷新表视图
-(void)setDataList:(NSArray *)dataList{
    _dataList = dataList;
    
    [self loadHeaderView];
    [_trailerTableView reloadData];
}


//创建表视图
-(void)loadTableView{
    
    _trailerTableView = [[UITableView alloc] initWithFrame:self.bounds];
    _trailerTableView.delegate = self;
    _trailerTableView.dataSource = self;
    _trailerTableView.backgroundColor = [UIColor clearColor];
    
    
    [self addSubview:_trailerTableView];
    
}

//创建表头视图
-(void)loadHeaderView{
    
    TrailerModel *model = _dataList[0];
    
    //创建表头视图
    _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_W, 255)];
    [_headerView setImageWithURL:[NSURL URLWithString:model.coverImg]];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_W, 255)];
    
    [view addSubview:_headerView];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _headerView.bounds.size.height-50, kScreen_W, 50)];
    textLabel.text = model.movieName;
    textLabel.textColor = [UIColor whiteColor];
    textLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    textLabel.font = [UIFont systemFontOfSize:25];
    textLabel.textAlignment = NSTextAlignmentCenter;
    
    [_headerView addSubview:textLabel];
    
    _trailerTableView.tableHeaderView = view;
    
}



#pragma mark------------UITableViewDataSource

//返回单元格个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataList.count-1;
    
}

//返回单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //复用
    TrailerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TrailerCell" owner:nil options:nil] lastObject];
    }
    cell.model = _dataList[indexPath.row+1];
    
    return cell;
    
}


#pragma mark------------UITableViewDelegate

//返回单元格宽度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
    
}

//点击单元格时调用
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TrailerViewController *trailerVC = [[TrailerViewController alloc] init];
    
    //当push进来时，隐藏标签栏
    trailerVC.hidesBottomBarWhenPushed = YES;
    
    TrailerModel *model = _dataList[indexPath.row+1];
    trailerVC.model = model;
    
    //获取根视图控制器并push进一个视图控制器
    [self.viewController.navigationController pushViewController:trailerVC animated:YES];
    
}



#pragma mark------------UIScrollViewDelegate

//滑动过程中调用
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat fy = -scrollView.contentOffset.y;
    CGFloat hight = _trailerTableView.tableHeaderView.frame.size.height;

    //当向下滑动时 对头视图进行缩放
    if (scrollView.contentOffset.y<0) {
        
        _headerView.layer.anchorPoint = CGPointMake(0.5, 1);
        _headerView.layer.position = CGPointMake(_trailerTableView.tableHeaderView.center.x, 255);
        
        _headerView.transform = CGAffineTransformMakeScale((fy+hight)/hight, (fy+hight)/hight);
        
    }
    
}


@end
