//
//  TopListView.m
//  Timer
//
//  Created by LLQ on 16/5/21.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "TopListView.h"
#import "TopListModel.h"
#import "TopListHeaderView.h"

@implementation TopListView
{
    UITableView *_topListTableView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self loadTopListTableView];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

//dataList赋值时刷新表视图
-(void)setDataList:(NSArray *)dataList{
    
    _dataList = dataList;
    
    [_topListTableView reloadData];
    
}


//加载表视图
-(void)loadTopListTableView{
    
    
    _topListTableView = [[UITableView alloc] initWithFrame:self.bounds];
    _topListTableView.delegate = self;
    _topListTableView.dataSource = self;
    _topListTableView.backgroundColor = [UIColor clearColor];
    
    //设置表头视图
    TopListHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"TopListHeaderView" owner:nil options:nil] lastObject];
    _topListTableView.tableHeaderView = headerView;
    
    [self addSubview:_topListTableView];
    
}


#pragma mark-----------UITableViewDataSource

//返回每组单元格个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return _dataList.count;
}

//返回单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    TopListModel *model = _dataList[indexPath.row];
    
    cell.textLabel.text = model.topListNameCn;
    
    return cell;
    
}

@end
