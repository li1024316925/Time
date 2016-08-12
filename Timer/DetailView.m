//
//  DetailView.m
//  Timer
//
//  Created by LLQ on 16/5/14.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "DetailView.h"

@implementation DetailView

//复写set方法，在给model赋值时给单元格的属性赋值
-(void)setModel:(HomeModel *)model{
    
    _model = model;
    
    //赋值
    [_movieImgae setImageWithURL:[NSURL URLWithString:_model.img]];
    _titleCN.text = [NSString stringWithFormat:@"片名:%@",model.titleCn];
    _titleEN.text = [NSString stringWithFormat:@"英文名:%@",model.titleEn];
    _year.text = [NSString stringWithFormat:@"上映时间:%@",model.rYear];
    
    NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.1f",[model.ratingFinal floatValue]]];
    [aStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange(2, 1)];
    
    //安全判断，防止评分为负
    if ([_model.ratingFinal floatValue]<=0) {
        
        _model.ratingFinal = @0;
        NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.1f",[model.ratingFinal floatValue]]];
        [aStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange(2, 1)];
        _ratingLable.attributedText = aStr;
        _ratingView.rating = [_model.ratingFinal floatValue];
        
    }else{
        
        _ratingLable.attributedText = aStr;
        _ratingView.rating = [_model.ratingFinal floatValue];
        
    }
    
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_top_movie_background_cover"]];
    
}


@end
