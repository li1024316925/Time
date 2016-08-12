//
//  BaseCollectionView.h
//  Timer
//
//  Created by LLQ on 16/5/14.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseCollectionView : UICollectionView <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
//单元格宽度
@property(nonatomic,assign)float itemWidth;

//数据源
@property(nonatomic,strong)NSArray *dataList;

//记录在屏幕中间的单元格的下标
@property(nonatomic,assign)NSInteger currentIndex;

@end
