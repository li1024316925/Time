//
//  CriticismView.m
//  Timer
//
//  Created by LLQ on 16/5/21.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "CriticismView.h"
#import "CriticismCell.h"
#import "CriticismModel.h"

@implementation CriticismView
{
    UITableView *_criticismTableView;
    
    //创建一个可变字典，用来记录单元格的收展状态
    NSMutableDictionary *_stateDic;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self loadCriticismTableView];
        self.backgroundColor = [UIColor clearColor];
        //初始化字典
        _stateDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

//复写set方法，赋值后刷新表视图
-(void)setDataList:(NSArray *)dataList{
    
    _dataList = dataList;
    
    [_criticismTableView reloadData];
}


//创建表视图
-(void)loadCriticismTableView{
    
    _criticismTableView = [[UITableView alloc] initWithFrame:self.bounds];
    _criticismTableView.delegate = self;
    _criticismTableView.dataSource = self;
    _criticismTableView.backgroundColor = [UIColor clearColor];
    
    
    [self addSubview:_criticismTableView];
}


#pragma mark-----------UITableViewDataSource

//返回每组单元格个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return _dataList.count;
}

//返回单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CriticismCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CriticismCell" owner:nil options:nil] lastObject];
    }
    cell.model = _dataList[indexPath.row];
    
    
    return cell;
}

#pragma mark-----------UITableViewDelegate

//点击单元格时调用
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *indexStr = [NSString stringWithFormat:@"%ld",indexPath.row];
    //如果通过下标取到的值为空，说明该下标的单元格为收缩状态
    if ([_stateDic objectForKey:indexStr] == nil) {
        //往字典中存一个值，用来标记为单元格的舒展状态
        [_stateDic setObject:@1 forKey:indexStr];
    }else{
        //如果取到不为空，则说明当前的单元格在舒展状态，则删除这个数据来标记为单元格为收缩状态
        [_stateDic removeObjectForKey:indexStr];
    }
    
    //刷新当前点击的单元格
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

//返回单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *indexStr = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    //如果从状态字典中取到的值不为空，说明单元格应当处于展开状态
    if ([_stateDic objectForKey:indexStr]) {
        
        //高度自适应于评论字符串
        CriticismModel *model = _dataList[indexPath.row];
        NSString *rating = model.summary;
        CGRect rect = [rating boundingRectWithSize:CGSizeMake(414, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil];
        
        return rect.size.height+170;
        
    }else{
        
        return 170;
    }
    
    
}



@end
