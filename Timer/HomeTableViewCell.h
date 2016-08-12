//
//  HomeTableViewCell.h
//  Timer
//
//  Created by LLQ on 16/5/13.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
#import "RatingView.h"

@interface HomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet RatingView *ratingView;

@property(nonatomic,strong)HomeModel *homeModel;

@end
