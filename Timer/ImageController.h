//
//  ImageController.h
//  Timer
//
//  Created by LLQ on 16/5/24.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageController : UIViewController

@property(nonatomic,strong)NSArray *dataList;

@property(nonatomic,strong)NSIndexPath *indexPath;

@property(nonatomic,strong)UICollectionView *imageCollectionView;

@end
