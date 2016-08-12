//
//  HomeViewController.m
//  Timer
//
//  Created by LLQ on 16/5/13.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeModel.h"
#import "HomeTableViewCell.h"
#import "PosterView.h"
#import "CitiesViewController.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    PosterView *_view;
    UITableView *_tableView;
    
}

@end

@implementation HomeViewController

//复写init在初始化的时候给属性赋值
-(instancetype)init{
    
    self = [super init];
    
    if (self) {
        self.title = @"主页";
//        self.tabBarItem.image = [UIImage imageNamed:@"home_on"];
        self.tabBarItem.image = [UIImage imageNamed:@"home"];
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self createNavBarItem];
    [self loadData];
    [self createTableView];
    
    
}

//创建tableViewController
-(void)createTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_W, kScreen_H-65-50) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
    
    //再添加一个视图，用于展示海报，并实现翻转
    _view = [[PosterView alloc] initWithFrame:_tableView.frame];
    //首先隐藏
    _view.hidden = YES;
    _view.dataList = _dataList;
    _view.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_view];
}

#pragma mark-------UITableViewDataSource

//返回多少个单元格
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataList.count;
}

//返回单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //查找复用单元格
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        //用nib文件创建单元格
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HomeTableViewCell" owner:nil options:nil] lastObject];
        
    }
    //给cell的model属性赋值
    cell.homeModel = _dataList[indexPath.row];
    
    return cell;
}

#pragma mark-------UITableViewDelegate

//返回单元格高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 110;
}

#pragma mark-------加载json文件

-(void)loadData{
    //可变数组初始化
    _dataList = [[NSMutableArray alloc] init];
    
//    //按路径加载json文件
//    NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"home_header" ofType:@"json"];
//    NSData *data= [NSData dataWithContentsOfFile:pathStr];
    
    //解析json数据
//    NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    NSDictionary *dataDic = [CoreDataFromJson jsonObjectFromFileName:@"home_header"];
    
    NSArray *dataArray = [dataDic objectForKey:@"movies"];
    
    //创建数据模型
    //数据中有多少个字典，就创建多少个model，每个model对应一个单元格
    for (NSDictionary *dic in dataArray) {
        //创建数据模型
//        HomeModel *homeModel = [[HomeModel alloc] init];
//        homeModel.titleCn = [dic objectForKey:@"titleCn"];
//        homeModel.titleEn = [dic objectForKey:@"titleEn"];
//        homeModel.img = [dic objectForKey:@"img"];
//        homeModel.ratingFinal = [dic objectForKey:@"ratingFinal"];
//        homeModel.rYear = [dic objectForKey:@"rYear"];
//        homeModel.commonSpecial = [dic objectForKey:@"commomSpecial"];
        
        HomeModel *homeModel = [[HomeModel alloc] initWithDic:dic];
        //存入数据模型数组
        [_dataList addObject:homeModel];
        
    }
    
}



#pragma mark-------设置导航栏按钮

-(void)createNavBarItem{
    //左边按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 100, 30);
    [leftBtn setTitle:@"北京市" forState:UIControlStateNormal];
    //添加点击事件
    [leftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    //将按钮添加入导航栏
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //右侧按钮
    //右侧第一个按钮
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, 49, 25);
    [btn1 setImage:[UIImage imageNamed:@"list_home"] forState:UIControlStateNormal];
    [btn1 setBackgroundImage:[UIImage imageNamed:@"exchange_bg_home"] forState:UIControlStateNormal];
    btn1.tag = 1001;
    //第一个按钮添加点击事件
    [btn1 addTarget:self action:@selector(rightButAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //右侧第二个按钮
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, 0, 49, 25);
    [btn2 setImage:[UIImage imageNamed:@"poster_home"] forState:UIControlStateNormal];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"exchange_bg_home"] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(rightButAction:) forControlEvents:UIControlEventTouchUpInside];
    btn2.tag = 1002;
    
    //将最初的btn2隐藏
    btn2.hidden = YES;
    
    //创建一个UIView作为两个按钮的父视图
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 49, 25)];
    [view addSubview:btn1];
    [view addSubview:btn2];
    
    //添加右侧按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    
    
    
}

//右侧按钮点击事件
-(void)rightButAction:(UIButton *)btn{
    
    //通过导航栏获取右侧按钮的自定义视图
    UIView *view = self.navigationItem.rightBarButtonItem.customView;
    //按钮点击时隐藏自身
    btn.hidden = YES;
    if (btn.tag == 1001) {
        //如果点击的是第一个按钮，就将第二个按钮显示
        [view viewWithTag:1002].hidden = NO;
        //并添加旋转
        [self flipWithView:view isleft:YES];
        //点击第一个按钮时导航栏变为透明
        self.navigationController.navigationBar.alpha = 0.5;
        //点击第一个按钮时隐藏表视图，显示海报视图
        _tableView.hidden = YES;
        _view.hidden = NO;
        
        
    }else{
        //如果点击的是第二个按钮，就将第一个按钮显示
        [view viewWithTag:1001].hidden = NO;
        //添加旋转（向右）
        [self flipWithView:view isleft:NO];
        //点击第二个按钮时导航栏变为不透明
        self.navigationController.navigationBar.alpha = 1;
        //点击第二个按钮隐藏海报视图，显示表视图
        _view.hidden = YES;
        _tableView.hidden = NO;
        
        
    }
    
    //翻转主界面（按钮1向左，按钮2向右）
    [self flipWithView:self.view isleft:btn.tag == 1001 ? YES : NO];
    
}

//左按钮点击事件
-(void)leftBtnAction:(UIButton *)btn{
    
    CitiesViewController *citiesVC = [[CitiesViewController alloc] init];
    
    //调用block
    [citiesVC setCitiesBlock:^(NSString *name) {
        [btn setTitle:name forState:UIControlStateNormal];
    }];
    
    //当push进来时隐藏标签栏
    citiesVC.hidesBottomBarWhenPushed = YES;
//    [citiesVC.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
//    citiesVC.navigationItem.leftBarButtonItem. = [UIColor whiteColor];
    
    [self.navigationController pushViewController:citiesVC animated:YES];
    
}

//实现翻转动画方法
-(void)flipWithView:(UIView *)supView isleft:(BOOL)left{
    
    [UIView animateWithDuration:0.3 animations:^{
        //为supView添加一个旋转动画 当left为YES时，向左旋转，当left为NO时，向右旋转 缓存为YES
        [UIView setAnimationTransition:left ? UIViewAnimationTransitionFlipFromLeft : UIViewAnimationTransitionFlipFromRight forView:supView cache:YES];
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
