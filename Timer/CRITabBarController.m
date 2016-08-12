//
//  CRITabBarController.m
//  03自定义标签控制器
//
//  Created by CORYIL on 16/4/28.
//  Copyright © 2016年 徐锐. All rights reserved.
//

#import "CRITabBarController.h"

#define kTabBarWidth self.tabBar.frame.size.width
#define kTabBarHeight self.tabBar.frame.size.height
#define kButtonWidth kTabBarWidth/self.viewControllers.count


@interface CRITabBarController ()
{
    UIImageView *_selectImgV;
}

@property (nonatomic,strong) NSMutableArray *tabBarButtons;

@end

@implementation CRITabBarController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _tabBarButtons = [NSMutableArray array];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    /**
     * 8.当控制器的tabbar执行 setSelectionIndicatorImage:方法的时候 我们才有的选中图片
        
        但是我们无法进入self.tabbar的文件内部去复写这个方法
     
        所以在控制器完全加载完成 即将显示的时候创建,因为这时候,控制器个数+按钮宽度+选中的控制器 
        都确定了

     */
    
    //检查是否有选中图片
    UIImage *selectionIndicatorImage = self.tabBar.selectionIndicatorImage;
        //如果没有 return 什么都不做
    if (selectionIndicatorImage == nil)return;
    
        //如果有图片:创建选中图片-> 图片+frame
    _selectImgV = [[UIImageView alloc]initWithImage:selectionIndicatorImage];
    _selectImgV.frame = CGRectMake(self.selectedIndex * kButtonWidth, 0, kButtonWidth, kTabBarHeight);
    [self.tabBar insertSubview:_selectImgV atIndex:0];
    
    //将选中的button高亮
    UIButton *selectButton = self.tabBarButtons[self.selectedIndex];
    selectButton.selected = YES;
    
    
}

/**
 *  外部给本标签控制器 子控制器数组赋值的方法
 */
- (void)setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers{
    
    [super setViewControllers:viewControllers];
    
    /*————————————————————————————————————————————————————————————————————————*/
    //1.标签控制器已经有了N个子视图控制器
    
    for (UIView *subView in self.tabBar.subviews) {
        //2.标签栏上创建的是 UITabBarButton ,这个类是内部类,我们无法使用,所以移除原有按钮
        [subView removeFromSuperview];
    }
    
    //3.添加自定义按钮
    for (int i = 0; i<viewControllers.count; i++) {
        
        VerticalButton *button = [[VerticalButton alloc]initWithFrame:CGRectMake(i * kButtonWidth, 0, kButtonWidth, kTabBarHeight)];
            //获取i对应的子控制器
        UIViewController *subVC = self.viewControllers[i];
            //获取控制器->标签项->图片+标题 ->用于button的图片+标题
        UIImage *image = subVC.tabBarItem.image;
        UIImage *selectImage = subVC.tabBarItem.selectedImage;
        NSString *title = subVC.tabBarItem.title;
        
        //4.普通button的图片和标题是水平排布的,不符合我们的要求,--->自定义垂直排布的button
        [button setImage:image forState:UIControlStateNormal];
        [button setImage:selectImage forState:UIControlStateSelected];
        [button setTitle:title forState:UIControlStateNormal];
        
        [self.tabBar addSubview:button];
        [self.tabBarButtons addObject:button];//✅将按钮交给数组管理

        
        //7.添加事件,将按钮添加 切换视图控制器的功能
        [button addTarget:self action:@selector(selectedVC:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100+i;
        
        
    }

}


/**
 *  点击按钮调用的方法
 */
- (void)selectedVC:(UIButton *)button{
    
    //7.1 修改标签控制器的本身具有的 selectedIndex 完成切换功能
    self.selectedIndex = button.tag -100;
    
    
        //10.将除了选中的button之外的按钮选中状态改为no
    for (UIButton *btn in self.tabBarButtons) {
        btn.selected = NO;
    }
    button.selected = YES;
    
    
    //9.切换控制器的 选中图片动画
    [UIView animateWithDuration:0.3 animations:^{
       
        _selectImgV.frame = CGRectMake(self.selectedIndex * kButtonWidth, _selectImgV.frame.origin.y, _selectImgV.frame.size.width, _selectImgV.frame.size.height);
        
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];

}

@end

#pragma mark -- 垂直布局的Button

@interface VerticalButton ()
{
    UILabel *_subLabel;//按钮的标题
    
    UIImageView *_subImageView;//按钮的图片视图
    
    UIImage *_normalImg;//保存默认图片
    
    UIImage *_selectImg;//保存选中图片
}

@end

@implementation VerticalButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //5. 创建子视图 Label 上 + ImageView 下
        
        _subLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height * 0.3)];
        
        _subLabel.textAlignment = NSTextAlignmentCenter;
        
        _subLabel.textColor = [UIColor whiteColor];
        
        _subLabel.font = [UIFont systemFontOfSize:12];
        
        [self addSubview:_subLabel];
        
        _subImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, _subLabel.frame.size.height, frame.size.width, frame.size.height *0.7)];
        
        _subImageView.contentMode = UIViewContentModeCenter;
        
        [self addSubview:_subImageView];
        
    }
    return self;
}


//6.截获button的 图片和标题 的赋值方法,将图片和标题用于 Label + ImageView

- (void)setSelected:(BOOL)selected{

    [super setSelected:selected];
    
    if (self.selected == YES) {
        
        _subImageView.image = _selectImg;
    }else{
        _subImageView.image = _normalImg;
    }
    
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state{
    
    if (state == UIControlStateNormal) {
        //保存默认图片
        _normalImg = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [_subImageView setImage:_normalImg];
        
    }else if (state == UIControlStateSelected){
        //保存选中图片
        _selectImg = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state{

    if (state == UIControlStateNormal) {
        //保存标题
        [_subLabel setText:title];
    }
    
}




@end


