//
//  AttentionCell.m
//  Timer
//
//  Created by LLQ on 16/5/19.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "AttentionCell.h"

@implementation AttentionCell

- (void)awakeFromNib {
    
    _button2.layer.borderWidth = 2;
    _button2.layer.borderColor = [UIColor grayColor].CGColor;
    _button2.layer.cornerRadius = 15;
    _button2.clipsToBounds = YES;
    
}

-(void)setModel:(WillModel *)model{
    
    _model = model;

    _time.text = [NSString stringWithFormat:@"%@月%@日上映",_model.rMonth,_model.rDay];
    
    _title.text = _model.title;
    
    [_image setImageWithURL:[NSURL URLWithString:_model.image]];
    
    NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@人正在期待上映",_model.wantedCount]];
    [aStr setAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} range:NSMakeRange(0, aStr.length-7)];
    _count.attributedText = aStr;
    
    _director.text = [NSString stringWithFormat:@"导演:%@",_model.director];
    
    _actor.text = [NSString stringWithFormat:@"主演:%@ %@",_model.actor1,_model.actor2];
    
    _type.text = _model.type;
    
    
}


@end
