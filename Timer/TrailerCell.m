//
//  TrailerCell.m
//  Timer
//
//  Created by LLQ on 16/5/21.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "TrailerCell.h"

@implementation TrailerCell

- (void)awakeFromNib {
    // Initialization code
}

//复写set方法，model赋值时给属性赋值
-(void)setModel:(TrailerModel *)model{
    
    _model = model;
    
    _title.text = _model.movieName;
    _title2.text = _model.summary;
    [_image setImageWithURL:[NSURL URLWithString:_model.coverImg]];
    
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
