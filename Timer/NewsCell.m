//
//  NewsCell.m
//  Timer
//
//  Created by LLQ on 16/5/21.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell

- (void)awakeFromNib {
    // Initialization code
}

//复写set方法，给model赋值时，给属性赋值
-(void)setModel:(NewsModel *)model{
    
    _model = model;
    
    if ([_model.type integerValue] == 1) {
        
        _titleCell2.text = _model.title;
        
        //图片赋值
        for (int i=0; i<_model.images.count; i++) {
            NSDictionary *dic = _model.images[i];
            switch (i) {
                case 0:
                    [_imageCell2_1 setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"url1"]]];
                    break;
                    
                case 1:
                    [_imageCell2_2 setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"url1"]]];
                    break;
                case 2:
                    [_imageCell2_3 setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"url1"]]];
                    break;
            }
        }
        //时间
        _timeCell2.text = @"4小时前评论";
        //评论
        _commentCell2.text = [NSString stringWithFormat:@"%@条评论",_model.commentCount];
    
    } else {
        
        _timeCell1.text = @"4小时前评论";
        _titleCell1.text = _model.title;
        _titleCell1_2.text = _model.title2;
        [_imageCell1 setImageWithURL:[NSURL URLWithString:_model.image]];
        _commentCell1.text = [NSString stringWithFormat:@"%@条评论",_model.commentCount];
        
    }
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
