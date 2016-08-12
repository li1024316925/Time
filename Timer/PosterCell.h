//
//  PosterCell.h
//  Timer
//
//  Created by LLQ on 16/5/14.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@interface PosterCell : UICollectionViewCell

//数据模型
@property(nonatomic,strong)HomeModel *model;

-(void)flipViews;

-(void)bringImageView;


@end
