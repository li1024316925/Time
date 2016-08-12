//
//  IndexCell.m
//  Timer
//
//  Created by LLQ on 16/5/16.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "IndexCell.h"

@implementation IndexCell
{
    UIImageView *_imageView;
}

//复写model的set方法，在赋值时给imageView赋值
-(void)setModel:(HomeModel *)model{
    
    _model = model;
    
    [_imageView setImageWithURL:[NSURL URLWithString:_model.img]];
    
}



//复用时会调用initWithFrame:方法，所以复写这个方法
-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        //调整图片显示方式
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:_imageView];
        
    }
    
    return self;
}


@end
