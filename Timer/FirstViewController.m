//
//  FirstViewController.m
//  Timer
//
//  Created by LLQ on 16/5/25.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "FirstViewController.h"
#import "MainViewController.h"


@interface FirstViewController ()<UIScrollViewDelegate>

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //将button隐藏
    _closeButton.hidden = YES;
    
    //设置滑动视图
    [self loadScrollView];
    
//    [self.view bringSubviewToFront:_closeButton];
}

//按钮点击方法
- (IBAction)closeButtonAction:(UIButton *)sender {
    
    //显示main
    [MainViewController createMainViewController];
    
}


//设置滑动视图
-(void)loadScrollView{
    
    _imageScrollView.delegate = self;
    //开启分页
    _imageScrollView.pagingEnabled = YES;
    //开启滚动
    _imageScrollView.scrollEnabled = YES;
    //设置滑动视图的大小
    _imageScrollView.contentSize = CGSizeMake(kScreen_W*3, kScreen_H);
    
    //为滑动视图添加子视图
    for (int i = 0; i < 3; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*kScreen_W, 0, kScreen_W, kScreen_H)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"wizard%d_920.jpg",i+1]];
        [_imageScrollView addSubview:imageView];
        
    }
    
}


#pragma mark-------------UIScrollViewDelegeat

//已经结束减速时调用
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //获取偏移量，判断当前是第几个图片视图
    int i = scrollView.contentOffset.x/kScreen_W;
    //如果是第三张图片，就把button显示，否则隐藏
    if (i == 2) {
        
        _closeButton.hidden = NO;
    }else{
        _closeButton.hidden = YES;
    }
    
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
