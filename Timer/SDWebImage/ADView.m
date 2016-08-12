//
//  ADView.m
//  Timer
//
//  Created by LLQ on 16/5/25.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "ADView.h"

@implementation ADView
{
    UIButton *_closeButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createSelf];
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

//设置边框
-(void)createSelf{
    
    self.layer.cornerRadius = 10;
    self.layer.borderWidth = 3;
    self.clipsToBounds = YES;
    self.layer.borderColor = [UIColor grayColor].CGColor;
    
}

//显示方法
-(void)showViewAnimation{
    
    //添加到window上
    //获取本应用程序的window
    [[UIApplication sharedApplication].delegate.window addSubview:self];
    
    self.transform = CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:0.7 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    } completion:^(BOOL finished) {
        //还原
        self.transform = CGAffineTransformIdentity;
    }];
    
    //显示时将关闭按钮移到最上层
    [self bringSubviewToFront:_closeButton];
    
}


//复写图片数组的set方法，在赋值时创建滑动视图
-(void)setImageNameArray:(NSArray *)imageNameArray{
    
    _imageNameArray = imageNameArray;
    
    //创建集合视图
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    scrollView.contentSize = CGSizeMake(self.bounds.size.width*_imageNameArray.count, self.bounds.size.height);
    for (int i = 0; i < _imageNameArray.count; i ++) {
        
        NSString *image = _imageNameArray[i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width*i, 0, self.bounds.size.width, self.bounds.size.height)];
        imageView.image = [UIImage imageNamed:image];
    
        [scrollView addSubview:imageView];
        
    }
    scrollView.pagingEnabled = YES;
    
    [self addSubview:scrollView];
    
}

//复写按钮图片的set方法，在按钮图片赋值时创建按钮
-(void)setCloseImageStr:(NSString *)closeImageStr{
    
    _closeImageStr = closeImageStr;
    
    //添加按钮
    _closeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width-50, 0, 50, 50)];
    [_closeButton setImage:[UIImage imageNamed:_closeImageStr] forState:UIControlStateNormal];
    [_closeButton addTarget:self action:@selector(closeButtonAction:) forControlEvents: UIControlEventTouchUpInside];
    
    [self addSubview:_closeButton];
    
}


//按钮点击事件
-(void)closeButtonAction:(UIButton *)button{
    
    //让本视图消失，并从父视图上面移除
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformMakeScale(1.5, 1.5);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
    
}


@end
