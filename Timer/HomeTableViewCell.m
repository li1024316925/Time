//
//  HomeTableViewCell.m
//  Timer
//
//  Created by LLQ on 16/5/13.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

//复写homeModel的set方法，在homeModel赋值时给其他属性赋值
-(void)setHomeModel:(HomeModel *)homeModel{
    
    _homeModel = homeModel;
    
    self.titleLabel.text = _homeModel.titleCn;
    
    NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.1f",[_homeModel.ratingFinal floatValue]]];
    [aStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange(2, 1)];
    //进行安全判断，防止评分小于0
    if ([_homeModel.ratingFinal floatValue]<=0) {
        _homeModel.ratingFinal = @0;
        
        NSMutableAttributedString *aStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.1f",[_homeModel.ratingFinal floatValue]]];
        [aStr setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} range:NSMakeRange(2, 1)];
        self.ratingLabel.attributedText = aStr;
        self.ratingView.rating = 0;
        
    }else{
        
        self.ratingLabel.attributedText = aStr;

        self.ratingView.rating = [_homeModel.ratingFinal floatValue];
    }
    
    //使用网址导入图片
    [self.imgView setImageWithURL:[NSURL URLWithString:_homeModel.img]];
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
