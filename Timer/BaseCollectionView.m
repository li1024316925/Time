//
//  BaseCollectionView.m
//  Timer
//
//  Created by LLQ on 16/5/14.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "BaseCollectionView.h"

@implementation BaseCollectionView


-(instancetype)initWithFrame:(CGRect)frame{
    
    //初始化时定义滑动方向为水平
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        //设置代理
        self.delegate = self;
        self.dataSource = self;
    }
    
    return self;
    
}

#pragma mark----------UICollectionViewDataSource

//返回单元格个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataList.count;
}

//返回单元格
//在子类中复写返回单元格的方法
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return nil;
    
}



#pragma mark-----------UICollectionViewDeleagteFlowLayout

//单元格的宽和高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(self.itemWidth, 400);
}


//返回单元格与边缘距离
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, (kScreen_W - self.itemWidth)/2, 0, (kScreen_W - self.itemWidth)/2);
    
}


#pragma mark-----------UIScrollViewDelegate

//将要结束拖动
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//    scrollView.contentOffset
    //targetContentOffset:  滑动式图的偏移量
    
    //计算滑动视图的横向偏移量
    CGFloat xOffset = targetContentOffset->x;
//    NSLog(@"%f",xOffset);
//    CGFloat xOffset2 = scrollView.contentOffset.x;
//    NSLog(@"%f",xOffset2);
    
    //根据偏移量计算当前单元格的下标
    //偏移量-单元格之间的宽度 除以 每个单元格宽度
    NSInteger index = xOffset/self.itemWidth;
    
    //安全判断 如果当前单元格下标大于最后一个单元格下标
    if (index >= self.dataList.count-1) {
        
        index = self.dataList.count - 1;
        
    }
    
    //每次滑动让当前单元格显示在屏幕中央
    targetContentOffset->x = index*self.itemWidth + index*10;
//    scrollView.contentOffset.x = index * self.itemWidth + index *10;
//    targetContentOffset->x = 0;
    
    self.currentIndex = index;
    
}







@end
