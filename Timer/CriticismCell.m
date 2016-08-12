//
//  CriticismCell.m
//  Timer
//
//  Created by LLQ on 16/5/22.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "CriticismCell.h"

@implementation CriticismCell

- (void)awakeFromNib {
    // Initialization code
}


//复写model的set方法，在赋值时给属性赋值
-(void)setModel:(CriticismModel *)model{
    
    _model = model;
    
    //电影图片
    NSString *movieImageUrl = [_model.relatedObj objectForKey:@"image"];
    [_movieImage setImageWithURL:[NSURL URLWithString:movieImageUrl]];
    //影评
    _comment.text = _model.summary;
    //标题
    _title.text = _model.title;
    //用户图片
    [_userImage setImageWithURL:[NSURL URLWithString:_model.userImage]];
    //用户名
    _userName.text = [NSString stringWithFormat:@"%@-评",_model.nickname];
    //电影名
    _movieName.text = [_model.relatedObj objectForKey:@"title"];
    //评分
    NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithString:_model.rating];
    [aStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange(2, 1)];
    _rating.attributedText = aStr;
    
    
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
