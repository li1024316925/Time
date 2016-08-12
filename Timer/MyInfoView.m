//
//  MyInfoView.m
//  Timer
//
//  Created by LLQ on 16/5/22.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "MyInfoView.h"
#import "MyInfoTableHeaderView.h"

@implementation MyInfoView
{
    NSArray *_dataList;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //加载数据
        [self loadData];
        //加载表视图
        [self loadMyInfoTableView];
    }
    return self;
}


//创建表视图
-(void)loadMyInfoTableView{
    
    UITableView *myInfoTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
    myInfoTableView.delegate = self;
    myInfoTableView.dataSource = self;
    myInfoTableView.sectionHeaderHeight = 30;
    
    //添加表头视图
    MyInfoTableHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"MyInfoTableHeaderView" owner:nil options:nil] lastObject];
    headerView.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"cinema_head_bg"]];
    myInfoTableView.tableHeaderView = headerView;
    
    [self addSubview:myInfoTableView];
    
}

//解析数据
-(void)loadData{
    
    _dataList = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MyInfoDataList" ofType:@"plist"]];
    
    
}

#pragma mark------------UITableViewDataSource

//返回组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataList.count;
}


//返回每组单元格个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *array = _dataList[section];
        
    return array.count;
}

//返回单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
    
    if (indexPath.section == 0) {
        
        NSArray *array1 = _dataList[indexPath.section];
        NSDictionary *dic = array1[indexPath.row];
        
        //根据组不同单元格数据不同
        if (cell1 == nil) {
            cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
            cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell1.textLabel.text = [dic objectForKey:@"title"];
        cell1.imageView.image = [UIImage imageNamed:[dic objectForKey:@"image"]];
        
        return cell1;
    }else{
        
        NSArray *array = _dataList[indexPath.section];
        if (cell2 == nil) {
            cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
            cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        cell2.textLabel.text = array[indexPath.row];
        
        return cell2;
    }
    
}

//返回组头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    view.backgroundColor = [UIColor grayColor];
    
    return view;
}

@end
