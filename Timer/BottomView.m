//
//  BottomView.m
//  Timer
//
//  Created by LLQ on 16/5/20.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "BottomView.h"
#import "SegmentView.h"

@implementation BottomView
{
    UICollectionView *_coView;
    UIImageView *_busImageView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        //加载分页视图
        [self loadSegmentView];
        [self loadCollectionView];
        [self loadImageView];
        
        _dataList = @[@"全部",@"IMAX厅",@"中国巨幕",@"4K放映厅",@"3D厅",@"杜比全景声",@"情侣座",@"停车场",@"WI-FI"];
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_top_movie_background_cover"]];
    }
    
    return self;
}

//创建分页视图
-(void)loadSegmentView{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_W, 50)];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tab_bg_all@2x"]];
    //按钮组
    SegmentView *segView = [[SegmentView alloc] initWithFrame:CGRectMake(50, 0, kScreen_W-100, 50)];
    segView.titleArray = @[@"特色",@"商圈",@"地区",@"地铁"];
    segView.selectImageName = @"icon_slider_min@2x";
    
    [segView setSegmentBlock:^(NSInteger index) {
       
        switch (index) {
            case 0:
                _dataList = @[@"全部",@"IMAX厅",@"中国巨幕",@"4K放映厅",@"3D厅",@"杜比全景声",@"情侣座",@"停车场",@"WI-FI"];
                _coView.hidden = NO;
                
                _busImageView.hidden = YES;
                [_coView reloadData];
                break;
            case 1:
                _dataList = @[@"全部",@"美食广场",@"恒隆广场"];
                _coView.hidden = NO;
                
                _busImageView.hidden = YES;
                [_coView reloadData];
                break;
            case 2:
                _dataList = @[@"全部",@"历下区",@"市中区",@"槐荫区",@"天桥区",@"商河区",@"历城区",@"长清区"];
                _coView.hidden = NO;
                
                _busImageView.hidden = YES;
                [_coView reloadData];
                break;
            case 3:
                [_coView reloadData];
                _coView.hidden = YES;
                
                _busImageView.hidden = NO;
                break;
        }
        
    }];
    [view addSubview:segView];
    //关闭按钮
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreen_W-50, 0, 50, 50)];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"pic_ico_wrong"] forState:UIControlStateNormal];
    //添加按钮点击事件
    [closeButton addTarget:self action:@selector(closeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:closeButton];
    
    
    [self addSubview:view];
}

//关闭按钮点击事件
-(void)closeButtonAction:(UIButton *)btn{
    
    [UIView animateWithDuration:0.3 animations:^{
       
        //恢复所有形变
        self.transform = CGAffineTransformIdentity;
    }];
    
}

//创建集合视图
-(void)loadCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(100, 50);
    layout.minimumInteritemSpacing = 10;
    
    _coView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, self.bounds.size.width, self.bounds.size.height-50) collectionViewLayout:layout];
    _coView.backgroundColor = [UIColor clearColor];
    
    _coView.delegate = self;
    _coView.dataSource = self;
    
    //注册单元格
    [_coView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    
    [self addSubview:_coView];
    
}

//创建图片视图
-(void)loadImageView{
    
    _busImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, self.bounds.size.width, self.bounds.size.height-50)];
    _busImageView.image = [UIImage imageNamed:@"bus"];
    
    _busImageView.hidden = YES;
    [self addSubview:_busImageView];
}


#pragma mark--------UICollectionViewDataSource

//每组单元格个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataList.count;
    
}

//返回单元格
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    //移除控件防止单元格复用时重复添加
    for (UIView *view in cell.subviews) {
        if ([view isKindOfClass:[UILabel class]]) {
            [view removeFromSuperview];
        }
    }
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:cell.bounds];
    label.text = _dataList[indexPath.item];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:20];
    [cell addSubview:label];
    
    
    return cell;
}

#pragma mark-----------UICollectionViewDelegateFlowLayout

//返回单元格与控件边缘距离
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    
    return UIEdgeInsetsMake(50, 25, 0, 25);
}

@end
