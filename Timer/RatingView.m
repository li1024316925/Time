//
//  RatingView.m
//  Timer
//
//  Created by LLQ on 16/5/13.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "RatingView.h"

@implementation RatingView
{
    UIView *_yellowView;
    
    
}

-(void)awakeFromNib{
    
    [self loadSubles];
}


-(void)loadSubles{
    
    //获取图片
    UIImage *gray = [UIImage imageNamed:@"gray"];
    UIImage *yellow = [UIImage imageNamed:@"yellow"];
    
    //获取图片大小
    CGFloat imgHeight = gray.size.height;
    CGFloat imgWidth = gray.size.width*5;
    
    //创建视图
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, imgWidth, imgHeight)];
    _yellowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, imgWidth, imgHeight)];
    
    //用平铺的方式设置背景图片
    grayView.backgroundColor = [UIColor colorWithPatternImage:gray];
    _yellowView.backgroundColor = [UIColor colorWithPatternImage:yellow];
    
    [self addSubview:grayView];
    [self addSubview:_yellowView];
    
    //计算放大倍数
    CGFloat scaleX = self.bounds.size.width/imgWidth;
    CGFloat scaleY = self.bounds.size.height/imgHeight;
    
    //放大
    grayView.transform = CGAffineTransformMakeScale(scaleX, scaleY);
    _yellowView.transform = CGAffineTransformMakeScale(scaleX, scaleY);
    
    //重置视图位置
    grayView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _yellowView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    
}

//重写rating属性的set方法，缩小黄色视图的宽度
-(void)setRating:(CGFloat)rating{
    
    _rating = rating;
    
    _yellowView.frame = CGRectMake(0, 0, self.frame.size.width*_rating/10, self.frame.size.height);
    
}




@end
