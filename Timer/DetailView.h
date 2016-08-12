//
//  DetailView.h
//  Timer
//
//  Created by LLQ on 16/5/14.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingView.h"
#import "HomeModel.h"

@interface DetailView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *movieImgae;
@property (weak, nonatomic) IBOutlet UILabel *titleCN;
@property (weak, nonatomic) IBOutlet UILabel *titleEN;
@property (weak, nonatomic) IBOutlet UILabel *year;
@property (weak, nonatomic) IBOutlet UILabel *ratingLable;
@property (weak, nonatomic) IBOutlet RatingView *ratingView;

@property(nonatomic,strong)HomeModel *model;

@end
