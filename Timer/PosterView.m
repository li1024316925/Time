//
//  PosterView.m
//  Timer
//
//  Created by LLQ on 16/5/14.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "PosterView.h"
#import "PosterCollectionView.h"
#import "IndexCollectionView.h"
#import "HomeModel.h"

@implementation PosterView
{
    PosterCollectionView *_posterCollectionView;
    IndexCollectionView *_indexCollectionView;
    UIView *_mask;
    UIImageView *_headerView;
    UILabel *_titleLabel;
    
    
}

//初始化的时候加载子视图
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubviews];
    }
    return self;
}

//复写dataList的set方法，当赋值时，给子视图posterCollectionView与indexCollextionView赋值
-(void)setDataList:(NSArray *)dataList{
    
    _dataList = dataList;
    _posterCollectionView.dataList = _dataList;
    _indexCollectionView.dataList = _dataList;
    
    HomeModel *model = _dataList[0];
    _titleLabel.text = model.titleCn;
    
}

//加载视图方法
-(void)loadSubviews{
    
    //加载大海报视图
    [self createCollectionView];
    //添加标题视图
    [self createTitleLabel];
    //加载笼罩视图
    [self createMaskView];
    //加载上部抽屉视图
    [self createHeaderView];
    //添加灯光
    [self createLight];
    
    
    //添加观察者
    [self addObserver];
    
}

//创建大海报视图（一个集合视图）
-(void)createCollectionView{
    _posterCollectionView = [[PosterCollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreen_W, self.frame.size.height)];
    
    [self addSubview:_posterCollectionView];
    
}

//创建笼罩视图
-(void)createMaskView{
    
    _mask = [[UIView alloc] initWithFrame:self.bounds];
    _mask.backgroundColor = [UIColor blackColor];
    _mask.alpha = 0.5;
    //开始时为隐藏
    _mask.hidden = YES;
    
    [self addSubview:_mask];
    
}

//创建上部抽屉视图
-(void)createHeaderView{
    
    _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -135, kScreen_W, 165)];
    //添加图片并将图片拉伸（从高度为5的地方画线，拉伸像素）
    _headerView.image = [[UIImage imageNamed:@"indexBG_home"] stretchableImageWithLeftCapWidth:0 topCapHeight:5];
    //开启点击事件
    _headerView.userInteractionEnabled = YES;
    
    
    //创建按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(kScreen_W/2-100/2+3.5, 135, 100, 30);
    //添加点击事件
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    //添加按钮图片
    [btn setImage:[UIImage imageNamed:@"down_home"] forState:UIControlStateNormal];
    //设置初始点击状态为NO
    btn.selected = NO;
    
    [_headerView addSubview:btn];
    
    //创建一个小海报视图（集合视图）添加到上部抽屉视图上
    _indexCollectionView = [[IndexCollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreen_W, 135)];
    [_headerView addSubview:_indexCollectionView];
    
    [self addSubview:_headerView];
}


//下拉按钮点击事件
-(void)btnAction:(UIButton *)btn{
    
    if (btn.selected == NO) {
        //添加动画
        [UIView animateWithDuration:0.3 animations:^{
            //打开笼罩视图
            _mask.hidden = NO;
            //上部视图下拉
            _headerView.transform = CGAffineTransformTranslate(_headerView.transform, 0, 135);
            //按钮旋转
            btn.transform = CGAffineTransformMakeRotation(M_PI);
        }];
    }else{
        
        [UIView animateWithDuration:0.3 animations:^{
            //笼罩视图隐藏
            _mask.hidden = YES;
            //上部视图还原
            _headerView.transform = CGAffineTransformIdentity;
            //按钮还原
            btn.transform = CGAffineTransformIdentity;
        }];
        
    }
    
    //变换按钮点击状态
    btn.selected = !btn.selected;
}


//创建灯光视图
-(void)createLight{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 124, 240)];
    
    imageView.image = [UIImage imageNamed:@"light"];
    [self addSubview:imageView];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(kScreen_W-124, 10, 124, 240)];
    imageView2.image = [UIImage imageNamed:@"light"];
    [self addSubview:imageView2];
    
}

//创建片名视图
-(void)createTitleLabel{
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 575, kScreen_W, 45)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor grayColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont boldSystemFontOfSize:27];
    
    
    [self addSubview:_titleLabel];
    
}


//创建观察者
-(void)addObserver{
    
    //让self观察_indexCollextionView的currentIndex属性
    [_indexCollectionView addObserver:self forKeyPath:@"currentIndex" options:    NSKeyValueObservingOptionNew context:nil];
    
    //让self观察_posterCollectionView的currentIndex属性
    [_posterCollectionView addObserver:self forKeyPath:@"currentIndex" options:NSKeyValueObservingOptionNew context:nil];
    
}

//观察到属性变化后调用的方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    //变化后的值
    NSInteger index = [[change objectForKey:@"new"] integerValue];
    
    //创建一个NSIndexPath对象
    //第一个参数: 第几个单元格
    //第二个参数: 第几组
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    
    //判断是否为currentIndex属性
    if ([keyPath isEqualToString:@"currentIndex"]) {
        //如果当前属性变化的对象是大视图
        if ([object isKindOfClass:[PosterCollectionView class]]) {
            //就让小视图滑动
            //滑动到IndexPath为indexPath的单元格
            [_indexCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            
            //变换标题视图
            HomeModel *model = _dataList[indexPath.item];
            _titleLabel.text = model.titleCn;
            
        }else if ([object isKindOfClass:[IndexCollectionView class]]){
            //如果当前属性变化的对象是小视图，就滑动大视图
            [_posterCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
            
            //变换标题视图
            HomeModel *model = _dataList[indexPath.item];
            _titleLabel.text = model.titleCn;
            
        }
    }
    
}

@end
