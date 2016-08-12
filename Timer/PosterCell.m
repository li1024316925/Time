//
//  PosterCell.m
//  Timer
//
//  Created by LLQ on 16/5/14.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "PosterCell.h"
#import "DetailView.h"

@implementation PosterCell
{
    UIImageView *_imageView;
    DetailView *_detailView;
    BOOL _isLeft;
    
}

//复写model属性的set方法，在给model属性赋值时给_imageView赋值
-(void)setModel:(HomeModel *)model{
    
    _model = model;    
    [_imageView setImageWithURL:[NSURL URLWithString:model.img]];
    _detailView.model = _model;
    
}



//从自动复用池中复用，调用的是initWithFrame:方法
-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        //创建单元格的第一个视图（大图片）
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];

        //通过nib文件加载视图（详情）
        _detailView = [[[NSBundle mainBundle] loadNibNamed:@"DetailView" owner:nil options:nil] lastObject];
        _detailView.frame = self.bounds;
        _detailView.hidden = YES;
        
        //添加子视图
        [self addSubview:_detailView];
        [self addSubview:_imageView];
        
    }
    
    return self;
}

//翻转单元格并调换两个视图位置
-(void)flipViews{
    
    //判断向左还是向右翻转
    UIViewAnimationOptions option = _isLeft ? UIViewAnimationOptionTransitionFlipFromLeft : UIViewAnimationOptionTransitionFlipFromRight;
    
#pragma mark------------优化
    //获取所有cell上的子视图
//    NSArray *subViews = self.subviews;
    //获取子视图的下标
//    NSInteger index1 = [subViews indexOfObject:_imageView];
//    NSInteger index2 = [subViews indexOfObject:_detailView];
    
    //添加动画
    [UIView transitionWithView:self duration:0.3 options:option animations:^{
        //通过下标交换两个视图的位置
//        [self exchangeSubviewAtIndex:index1 withSubviewAtIndex:index2];
        if (_isLeft) {
            
            _imageView.hidden = NO;
            _detailView.hidden = YES;
            
        }else{
            
            _imageView.hidden = YES;
            _detailView.hidden = NO;
            
        }
        
    } completion:^(BOOL finished) {
       
        //变换翻转方向
        _isLeft = !_isLeft;
    }];
    
}

//把ImageView拿到最上层的方法（用来还原一个单元格，防止复用时出错）
-(void)bringImageView{
    
//    [self bringSubviewToFront:_imageView];
    _imageView.hidden = NO;
    _detailView.hidden = YES;
    
    _isLeft = NO;
}


@end
