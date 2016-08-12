//
//  IndexCollectionView.m
//  Timer
//
//  Created by LLQ on 16/5/16.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "IndexCollectionView.h"
#import "IndexCell.h"

@implementation IndexCollectionView

-(instancetype)initWithFrame:(CGRect)frame{
    
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.itemSize = CGSizeMake(100, 120);
//    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    self = [super initWithFrame:frame];
    
    if (self) {
        //注册单元格
        [self registerClass:[IndexCell class] forCellWithReuseIdentifier:@"indexCell"];
        
        
        //单元格宽
        self.itemWidth = 100;
    }
    
    return self;
    
}


//复写父类返回单元格方法
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //单元格重用
    IndexCell *indexCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"indexCell" forIndexPath:indexPath];
    //添加数据
    indexCell.model = self.dataList[indexPath.row];
    
    return indexCell;
    
    
    
}


@end
