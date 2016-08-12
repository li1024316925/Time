//
//  MoviecomingsCell.m
//  Timer
//
//  Created by LLQ on 16/5/19.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "MoviecomingsCell.h"

@implementation MoviecomingsCell

- (void)awakeFromNib {
    // Initialization code
}

//复写set方法，给属性赋值
-(void)setModel:(WillModel *)model{
    
    _model = model;
    _time.text = [NSString stringWithFormat:@"%@日",_model.rDay];
    [_image setImageWithURL:[NSURL URLWithString:_model.image]];
    _title.text = _model.title;
    _type.text = _model.type;
    _director.text = _model.director;
    NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@人在期待上映",_model.wantedCount]];
    [aStr setAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} range:NSMakeRange(0, aStr.length-6)];
    [aStr setAttributes:@{NSForegroundColorAttributeName:[UIColor blueColor]} range:NSMakeRange(aStr.length-6, 6)];
    _count.attributedText = aStr;
    
    _button2.layer.cornerRadius = 10;
    _button2.layer.borderWidth = 2;
    _button2.layer.borderColor = [UIColor grayColor].CGColor;
    _button2.clipsToBounds = YES;
    
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
