//
//  NewsTableViewController.h
//  Timer
//
//  Created by LLQ on 16/5/24.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsDatailsModel.h"

@interface NewsTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollection;
@property (weak, nonatomic) IBOutlet UILabel *actor;
@property (weak, nonatomic) IBOutlet UILabel *drama;
@property (weak, nonatomic) IBOutlet UILabel *actor2;

@property(nonatomic,strong)NewsDatailsModel *model;




@end
