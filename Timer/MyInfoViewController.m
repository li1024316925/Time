//
//  MyInfoViewController.m
//  Timer
//
//  Created by LLQ on 16/5/13.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "MyInfoViewController.h"
#import "MyInfoView.h"

@interface MyInfoViewController ()

@end

@implementation MyInfoViewController

//复写init，设置标签栏按钮
-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        self.title = @"个人";
//        self.tabBarItem.image = [UIImage imageNamed:@"myinfo_on"];
        self.tabBarItem.image = [UIImage imageNamed:@"myinfo"];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadMyInfoView];
}


//创建个人视图
-(void)loadMyInfoView{
    
    MyInfoView *myInfoView = [[MyInfoView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-60-50)];
    
    [self.view addSubview:myInfoView];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
