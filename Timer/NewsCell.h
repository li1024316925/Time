//
//  NewsCell.h
//  Timer
//
//  Created by LLQ on 16/5/21.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@interface NewsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeCell1;
@property (weak, nonatomic) IBOutlet UILabel *titleCell1_2;
@property (weak, nonatomic) IBOutlet UILabel *titleCell1;
@property (weak, nonatomic) IBOutlet UILabel *commentCell1;
@property (weak, nonatomic) IBOutlet UIImageView *imageCell1;

@property (weak, nonatomic) IBOutlet UIImageView *imageCell2_1;
@property (weak, nonatomic) IBOutlet UIImageView *imageCell2_2;
@property (weak, nonatomic) IBOutlet UIImageView *imageCell2_3;
@property (weak, nonatomic) IBOutlet UILabel *commentCell2;
@property (weak, nonatomic) IBOutlet UILabel *titleCell2;
@property (weak, nonatomic) IBOutlet UILabel *timeCell2;

@property(nonatomic,strong)NewsModel *model;

@end
