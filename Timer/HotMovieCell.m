//
//  HotMovieCell.m
//  Timer
//
//  Created by LLQ on 16/5/18.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "HotMovieCell.h"

@implementation HotMovieCell

-(void)setModel:(HotModel *)model{
    
    _model = model;
    
    //设置属性
    //图片
    [_movieImageView setImageWithURL:[NSURL URLWithString:_model.img]];
    //标题
    _title.text = _model.t;
    //评价
    if ([_model.commonSpecial isEqualToString:@""]) {
        //创建富文本字符串
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@人在期待上映",_model.wantedCount]];
        [str setAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} range:NSMakeRange(0, str.length-6)];
        [str setAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]} range:NSMakeRange(str.length-6, 6)];
        _comment.attributedText = str;
        
    }else{
        _comment.text = _model.commonSpecial;
    }
    //日期
    NSString *day = [_model.rd substringFromIndex:6];
    NSString *mon = [_model.rd substringWithRange:NSMakeRange(4, 2)];
    _time.text = [NSString stringWithFormat:@"%@月%@日",mon,day];
    //数量
    _count.text = [NSString stringWithFormat:@"今日%@家影院%@场",_model.NearestCinemaCount,_model.NearestShowtimeCount];
    //评分
    if ([_model.r floatValue]<=0) {
        _model.r = @0.0;
    }
    NSMutableAttributedString *rStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.1f",[_model.r floatValue]]];
    [rStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22]} range:NSMakeRange(0, 1)];
    _rating.attributedText = rStr;
    //屏幕
    if ([_model.isIMAX boolValue]) {
        _image1.image = [UIImage imageNamed:@"icon_hot_show_IMAX"];
    }
    if ([_model.isIMAX3D boolValue]) {
        _image1.image = [UIImage imageNamed:@"icon_hot_show_IMAX3D"];
    }
    if (_image1.image == nil) {
        if ([_model.isDMAX boolValue]) {
            _image1.image = [UIImage imageNamed:@"icon_hot_show_DMAX"];
        }
    }else if(_image1.image){
        if ([_model.isDMAX boolValue]) {
            _image2.image = [UIImage imageNamed:@"icon_hot_show_DMAX"];
        }
    }
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
