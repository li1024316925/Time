//
//  AttentionCollectionView.h
//  Timer
//
//  Created by LLQ on 16/5/19.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AttentionCollectionView : UICollectionView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)NSArray *dataList;

@end
