//
//  PosterCollectionView.m
//  Timer
//
//  Created by LLQ on 16/5/14.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "PosterCollectionView.h"
#import "HomeModel.h"
#import "PosterCell.h"

@implementation PosterCollectionView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        //注册单元格
        [self registerClass:[PosterCell class] forCellWithReuseIdentifier:@"cell"];
        
        self.itemWidth = kScreen_W - 150;
    }
    
    return self;
}

//复写返回单元格方法
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //从自动复用池中复用
    PosterCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.model = self.dataList[indexPath.row];
    
    return cell;
}

//单元格点击的时候调用
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //判断当前点击的单元格是否为屏幕中间的单元格
    if (indexPath.item == self.currentIndex) {
        
        //通过下标获取单元格
        PosterCell *cell = (PosterCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [cell flipViews];
        
    }else{
        //如果不是则视图滑动
        [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        
        //更新记录当前在屏幕中央的单元格的下标
        self.currentIndex = indexPath.item;
        
    }
    
    
}

//单元格已经结束显示时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //取到当前cell
    PosterCell *posterCell = (PosterCell *)cell;
    //把imageView拿到最上层，还原单元格，以方便复用
    [posterCell bringImageView];
    
}


@end
