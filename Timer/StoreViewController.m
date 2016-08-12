//
//  StoreViewController.m
//  Timer
//
//  Created by LLQ on 16/5/13.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "StoreViewController.h"
#import "SegmentView.h"
#import "CinemaModel.h"
#import "CinemaCell.h"
#import "BottomView.h"


@interface StoreViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_dataList;
    
    UITableView *_cinemaTableView;
    BottomView *_bottonView;
    
}

@end

@implementation StoreViewController

//复写init，设置标签栏按钮
-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        self.title = @"影院";
//        self.tabBarItem.image = [UIImage imageNamed:@"store_on@2x"];
        self.tabBarItem.image = [UIImage imageNamed:@"store"];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"window"]];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载数据
    [self loadData];
    //加载上部按钮
    [self creatSegmentView];
    //加载表视图
    [self creatTableView];
    //加载下部筛选视图
    [self creatBottomView];
}

//设置上部按钮组
-(void)creatSegmentView{
    
    SegmentView *segmentView = [[SegmentView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    segmentView.titleArray = @[@"全部",@"附近",@"价格",@"筛选"];
    segmentView.selectImageName = @"icon_slider_min@2x";
    
    //给block赋值
    [segmentView setSegmentBlock:^(NSInteger index) {
       

        switch (index) {
            case 0:
                //按钮0 不排序
                [self loadData];
                
                //还原底部视图
                [self pushButtonView];
                
                break;
            case 1:
                //按钮1 按照位置排序
                [self loadDataWithAddress];
                
                //还原底部视图
                [self pushButtonView];
                
                break;
            case 2:
                //按钮2 按照价格排序
                [self loadDataWithPrice];
                
                //还原底部视图
                [self pushButtonView];
                
                break;
            case 3:
                //按钮3 弹出筛选条件
                [self popButtonView];
                
                break;
        }
        
    }];
    
    [self.view addSubview:segmentView];
    
}

//解析数据
-(void)loadData{
    _dataList = [[NSMutableArray alloc] init];
    
    NSArray *array = [CoreDataFromJson jsonObjectFromFileName:@"cinema"];
    for (NSDictionary *dic in array) {
        
        CinemaModel *model = [[CinemaModel alloc] initWithDic:dic];
        model.length = [self compers:model];
        [_dataList addObject:model];
        
    }
    
    //刷新表视图
    [_cinemaTableView reloadData];
    
    //滑动到指定位置
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [_cinemaTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}

//按照价格排序
-(void)loadDataWithPrice{
    
    for (int i = 0; i<_dataList.count-1; i++) {
        for (int j = 0; j<_dataList.count-i-1; j++) {
            CinemaModel *model1 = _dataList[j];
            CinemaModel *model2 = _dataList[j+1];
            
            if (model1.minPrice > model2.minPrice) {
                [_dataList exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
 
    //刷新表视图
    [_cinemaTableView reloadData];
    
    //滑动到指定位置
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [_cinemaTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

//按照位置排序
-(void)loadDataWithAddress{
    
    
    for (int i = 0; i<_dataList.count-1; i++) {
        int min = i;
        float f1;
        float f2;
        for (int j = i+1; j<_dataList.count; j++) {
            CinemaModel *model1 = _dataList[min];
            CinemaModel *model2 = _dataList[j];
            f1 = [self compers:model1];
            f2 = [self compers:model2];
            if (f1>f2) {
                min = j;
            }
        }
        [_dataList exchangeObjectAtIndex:min withObjectAtIndex:i];
    }
    
    //刷新表视图
    [_cinemaTableView reloadData];
    
    //滑动到指定位置
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [_cinemaTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

//比较与本地之间距离
-(float)compers:(CinemaModel *)model{
    
    float l = pow(100.0-[model.longitude floatValue],2)+pow(45.0-[model.latitude floatValue], 2);
    return sqrt(l);
}

//创建底部筛选视图
-(void)creatBottomView{
    
    _bottonView = [[BottomView alloc] initWithFrame:CGRectMake(0, kScreen_H + 150, kScreen_W, 400)];
    
    [self.view addSubview:_bottonView];
    
}

//弹出底部视图
-(void)popButtonView{
    
    //按钮3 弹出筛选条件
    [UIView animateWithDuration:0.3 animations:^{
        
        _bottonView.transform = CGAffineTransformMakeTranslation(0, -500-113);
        
    }];
    
}

//隐藏底部视图
-(void)pushButtonView{
    
    [UIView animateWithDuration:0.3 animations:^{
        _bottonView.transform = CGAffineTransformIdentity;
    }];
}

//创建表视图
-(void)creatTableView{
    
    _cinemaTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height-160) style:UITableViewStylePlain];
    _cinemaTableView.dataSource = self;
    _cinemaTableView.delegate = self;
    _cinemaTableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_cinemaTableView];
}

#pragma mark----------UITableViewDataSource

//返回每组单元格个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataList.count;
}

//返回单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CinemaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cinemaCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"CinemaCell" owner:nil options:nil] lastObject];
        
    }
    cell.model = _dataList[indexPath.row];
    
    return cell;
}

#pragma mark-----------UITableViewDelegeat
//返回单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 150;
}

//单元格结束显示时调用
-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //由于在单元格model中赋值时改变了单元格的布局，复用时就会出错
    
    //遍历所有子控件，找到所有图片视图，还原所有更改
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            view.transform = CGAffineTransformIdentity;
            view.hidden = NO;
        }
    }
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
