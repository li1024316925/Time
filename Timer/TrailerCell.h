//
//  TrailerCell.h
//  Timer
//
//  Created by LLQ on 16/5/21.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrailerModel.h"

@interface TrailerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *title2;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIButton *button;

@property(nonatomic,strong)TrailerModel *model;

@end
