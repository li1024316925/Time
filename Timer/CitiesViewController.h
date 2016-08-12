//
//  CitiesViewController.h
//  Timer
//
//  Created by LLQ on 16/5/16.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import <UIKit/UIKit.h>

//声明一个block变量
typedef void(^CitiesBlock)(NSString *name);
@interface CitiesViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *citiesCollectionView;

@property(nonatomic,strong)NSArray *dataList;
@property(nonatomic,copy)CitiesBlock citiesBlock;




//重新声明block的set方法
-(void)setCitiesBlock:(CitiesBlock)citiesBlock;

@end
