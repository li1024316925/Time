//
//  NewsTableViewController.m
//  Timer
//
//  Created by LLQ on 16/5/24.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "NewsTableViewController.h"
#import "NewsDetailsTableHeadeView.h"
#import "ImageController.h"

@interface NewsTableViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning>

@end

@implementation NewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航栏的半透明效果
    self.navigationController.navigationBar.translucent = YES;
    
    self.tableView.sectionHeaderHeight = 20;
    
    //简介
    self.drama.text = _model.content;
    //演员
    self.actor.text = [NSString stringWithFormat:@"导演:%@",_model.author];
    self.actor2.text = [NSString stringWithFormat:@"演员:%@",_model.editor];
    
    //注册单元格
    [self.imageCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"image_cell"];
    
    //加载表头视图
    [self loadTableHeadeView];
    
}

//视图即将消失
-(void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBar.translucent = NO;
    
}

//添加表头视图
-(void)loadTableHeadeView{
    
    NewsDetailsTableHeadeView *newsDetHeadeView = [[[NSBundle mainBundle] loadNibNamed:@"NewDetailsTableHeadeView" owner:nil options:nil] lastObject];
//    newsDetHeadeView.bounds = CGRectMake(0, 0, self.view.bounds.size.width, 380);
    newsDetHeadeView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_mtime_star.jpg"]];
    
    
    //设置按钮图片
    UIImage *image1 = [[UIImage imageNamed:@"img_btn_green_half_press.9"] stretchableImageWithLeftCapWidth:5 topCapHeight:0];
    [newsDetHeadeView.button_1 setBackgroundImage:image1 forState:UIControlStateNormal];
    UIImage *image2 = [[UIImage imageNamed:@"img_btn_orange_half_press.9"] stretchableImageWithLeftCapWidth:5 topCapHeight:0];
    [newsDetHeadeView.button_2 setBackgroundImage:image2 forState:UIControlStateNormal];
    
    
    //设置图片
    NSDictionary *dic = _model.relations[0];
    [newsDetHeadeView.imageView setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"image"]]];
    //设置评分
    if ([[dic objectForKey:@"rating"] floatValue]<0) {
        newsDetHeadeView.rating.text = @"评分:0";
    }else{
        newsDetHeadeView.rating.text = [NSString stringWithFormat:@"评分:%@",[dic objectForKey:@"rating"]];
    }
    //设置时间
    newsDetHeadeView.time.text = [dic objectForKey:@"releaseDate"];
    
    self.tableView.tableHeaderView = newsDetHeadeView;
    
    
}

#pragma mark----------------UICollectionViewDataSource

//返回每组单元格数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSArray *array = _model.images;
    
    return array.count;
}

//返回单元格
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *array = _model.images;
    NSDictionary *dic = array[indexPath.row];
    //单元格复用
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"image_cell" forIndexPath:indexPath];
    //移除单元格的所有imageView，防止单元格复用时重复添加
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    //在单元格上面添加一个imageView
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
    [imageView setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"url1"]]];
    [cell.contentView addSubview:imageView];
    
    return cell;
}

#pragma mark-------------UICollectionViewDelegate

//单元格点击时调用
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ImageController *imageVC = [[ImageController alloc] init];
    
    //设置动画方式为当前上下文
    imageVC.modalPresentationStyle = UIModalPresentationCurrentContext;
    imageVC.indexPath = indexPath;
    imageVC.dataList = _model.images;
//    imageVC.view.hidden = YES;
    //设置过渡代理
    imageVC.transitioningDelegate = self;
    
    //模态弹出
    [self presentViewController:imageVC animated:YES completion:^{
        
    }];
    
}


#pragma mark-------------UIViewControllerTransitioningDelegate

//返回一个实现UIViewControllerAnimatedTransitioning代理的对象（转场上下文）
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    return self;
}



#pragma mark-------------UIViewControllerAnimatedTransitioning

//返回弹出时的动画时间
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    return 1;
}

//设置动画
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    //通过转场上下文取到目标view
    UICollectionView *destinationView = [transitionContext viewForKey:UITransitionContextToViewKey];
    //通过转场上下文取到容器view
    UIView *containerView = [transitionContext containerView];
    //将目标View添加到容器中
    [containerView addSubview:destinationView];
    
    //目标控制器
    ImageController *destinationController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    

    //选中单元格的下标
    NSIndexPath *index = destinationController.indexPath;
    
    //跳转前的控制器（取到的是导航控制器）
    UINavigationController *naviVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //由于我们跳转前的控制器添加了导航控制器，所以我们通过导航控制器取到跳转前的控制器
    NewsTableViewController *newsTableViewController = (NewsTableViewController *)naviVC.topViewController;
    //跳转前控制器的collectionView
    UICollectionView *currentCollection = newsTableViewController.imageCollection;
    //通过取到的indexPath取到当前选中的cell
    UICollectionViewCell *selectedCell = [currentCollection cellForItemAtIndexPath:index];
    
    //新建一个imageView
    UIImageView *animateView = [[UIImageView alloc] init];
    UIImageView *cellImageView = [[UIImageView alloc] init];
    for (UIView *view in selectedCell.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            cellImageView = (UIImageView *)view;
        }
    }

    animateView.image = cellImageView.image;
    animateView.contentMode = UIViewContentModeScaleAspectFill;
    animateView.clipsToBounds = YES;
    
    //将选中单元格的frame转化到应用程序的主窗口上
    CGRect originFrame = [currentCollection convertRect:selectedCell.frame toView:[UIApplication sharedApplication].keyWindow];
    
    //将animateView添加到容器中
    animateView.frame = originFrame;
//    animateView.transform = CGAffineTransformMakeScale(0, 0);
    [containerView addSubview:animateView];
    CGRect endFrame = destinationController.imageCollectionView.bounds;
    destinationView.alpha = 0;
    
    //添加动画
    [UIView animateWithDuration:1 animations:^{
        
        animateView.frame = endFrame;
//        animateView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        [UIView animateWithDuration:1 animations:^{
            destinationView.alpha = 1;
        } completion:^(BOOL finished) {
            [animateView removeFromSuperview];
        }];
    }];
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
