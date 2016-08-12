//
//  MainViewController.m
//  Timer
//
//  Created by LLQ on 16/5/25.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "CRITabBarController.h"
#import "MainViewController.h"
#import "BaseTabBarController.h"
#import "BaseNavViewController.h"
#import "ADView.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MainViewController createMainViewController];
    
}

+(void)createMainViewController{
    
    NSArray *imgNames = @[@"home",@"payticket",@"store",@"discover",@"myinfo"];
    //创建每个标签的视图控制器
    NSArray *viewControllersArray = @[@"HomeViewController",@"PayTicketViewController",@"StoreViewController",@"DiscoverViewController",@"MyInfoViewController"];
    //创建一个可变数组，用来给标签控制器添加标签数组
    NSMutableArray *bnvVcArray = [[NSMutableArray alloc] init];
    
//    for (NSString *str in viewControllersArray) {
//        //通过字符串创建控制器
//        UIViewController *uiVC = [[NSClassFromString(str) alloc] init];
//        uiVC.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_on",imgNames[i]]];
//        //给每个控制器添加一个导航栏控制器
//        BaseNavViewController *bnv = [[BaseNavViewController alloc] initWithRootViewController:uiVC];
//        //存入数组
//        [bnvVcArray addObject:bnv];
//    }
    
    for (int i = 0; i < 5; i ++) {
        NSString *str = viewControllersArray[i];
        UIViewController *uiVC = [[NSClassFromString(str) alloc] init];
        uiVC.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_on",imgNames[i]]];
        //给每个控制器添加一个导航栏控制器
        BaseNavViewController *bnv = [[BaseNavViewController alloc] initWithRootViewController:uiVC];
        //存入数组
        [bnvVcArray addObject:bnv];
    }
    
    CRITabBarController *criTbVC = [[CRITabBarController alloc] init];
    criTbVC.tabBar.selectionIndicatorImage = [UIImage imageNamed:@"选中"];
    criTbVC.tabBar.backgroundImage = [UIImage imageNamed:@"tab_bg_all"];
    criTbVC.viewControllers = bnvVcArray;
    
//    BaseTabBarController *btbVC = [[BaseTabBarController alloc] init];
//    //添加标签数组
//    btbVC.viewControllers = bnvVcArray;
    
    //获取本应用程序，并获取本应用程序的代理，再获取到代理的窗口，将标签控制器设置为窗口的根视图控制器
    [UIApplication sharedApplication].delegate.window.rootViewController = criTbVC;
    
    
    //设置显示时的动画
    //取到第一个控制器
//    BaseNavViewController *navaVC = btbVC.viewControllers[0];
    BaseNavViewController *navaVC = criTbVC.viewControllers[0];
    //将transform从0到1
    navaVC.view.transform = CGAffineTransformMakeScale(0, 0);
    
    [UIView animateWithDuration:1 animations:^{
        
        navaVC.view.transform = CGAffineTransformMakeScale(1, 1);
        
    } completion:^(BOOL finished) {
       
        //创建广告视图
        ADView *adView = [[ADView alloc] initWithFrame:CGRectMake((kScreen_W-300)/2, (kScreen_H-420)/2, 300, 420)];
        adView.closeImageStr = @"pic_ico_wrong";
        //给广告视图添加广告图片
        NSMutableArray *imageArr = [[NSMutableArray alloc] init];
        for (int i=0; i<4; i++) {
            NSString *imageStr = [NSString stringWithFormat:@"wizard%d_568@2x.jpg",i+1];
            [imageArr addObject:imageStr];
        }
        adView.imageNameArray = imageArr;
        //显示
        [adView showViewAnimation];
        
    }];
    
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
