//
//  AttentionCollectionView.m
//  Timer
//
//  Created by LLQ on 16/5/19.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "AttentionCollectionView.h"
#import "AttentionCell.h"

@implementation AttentionCollectionView


//复写init方法
-(instancetype)initWithFrame:(CGRect)frame{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = self.frame.size;
    //滑动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //单元格间的最小间距
    //水平
    layout.minimumInteritemSpacing = 0;
    //垂直
    layout.minimumLineSpacing = 0;
    
    layout.itemSize = CGSizeMake(kScreen_W, 180);
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        
        //开启分页
        self.pagingEnabled = YES;
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = [UIColor clearColor];
        
        //注册单元格
        [self registerNib:[UINib nibWithNibName:@"AttentionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"attentionCell"];
        //注册头视图
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"heade"];
    }
    
    return self;
}



#pragma mark-----UICollectionViewDataSource

//返回每组单元格个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataList.count;
    
}

//返回单元格
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AttentionCell *aCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"attentionCell" forIndexPath:indexPath];
    aCell.model = _dataList[indexPath.item];
    
    return aCell;
}



#pragma mark-------UICollectionViewDelegateFlowLayout

//返回单元格与边缘距离
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}


@end
