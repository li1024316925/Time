//
//  CitiesViewController.m
//  Timer
//
//  Created by LLQ on 16/5/16.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "CitiesViewController.h"
#import "CitiesModel.h"

@interface CitiesViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSMutableDictionary *_citiesDic;
    NSMutableArray *_hotCities;
    NSMutableArray *_latestCities;
    
    NSArray *_dataListn;
    
    __weak IBOutlet UITextField *_textField;
    
}

@end

@implementation CitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    
    [self loadCollectionView];
    
    //设置输入框的通知监听（当输入框文字改变时自动发送通知）
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNotification:) name:UITextFieldTextDidChangeNotification object:nil];
    
    
}

//当接收到通知时调用
-(void)changeNotification:(NSNotification *)notification{
    //创建过滤条件
    /*
     [C]  不区分大小写
     self 字符串本身
    */
    //查找字符串中带有输入框中字符串的字符串
    NSString *str = [NSString stringWithFormat:@"self like [C] '*%@*'",_textField.text];
    //通过过滤条件创建谓词对象
    NSPredicate *predicate = [NSPredicate predicateWithFormat:str];
    //过滤
    //在不变数组中过滤
    _dataList = [_dataListn filteredArrayUsingPredicate:predicate];
    
    //刷新集合视图
    [_citiesCollectionView reloadData];
    
}



//加载集合视图
-(void)loadCollectionView{
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_top_movie_background_cover"]];
    //注册单元格
    [_citiesCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    //注册头视图
    [_citiesCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
}


//加载数据
-(void)loadData{
    
    //初始化字典与数组
    _citiesDic = [[NSMutableDictionary alloc] init];
    _hotCities = [[NSMutableArray alloc] init];
    _latestCities = [[NSMutableArray alloc] init];
    
    //解包
    NSDictionary *dic = [CoreDataFromJson jsonObjectFromFileName:@"cities"];
    NSDictionary *infor = [dic objectForKey:@"infor"];
    NSArray *listItems = [infor objectForKey:@"listItems"];
    
    //遍历数组
    for (NSDictionary *dic in listItems) {
        
        CitiesModel *model = [[CitiesModel alloc] initWithDic:dic];
//        model.name = [dic objectForKey:@"name"];
//        model.nodepath = [dic objectForKey:@"nodepath"];
//        model.charindex = [dic objectForKey:@"charindex"];
//        model.level = [dic objectForKey:@"level"];
//        model.orderby = [dic objectForKey:@"orderby"];
        
        //通过首字母从数据字典中取出城市
        NSMutableArray *citiesArray = [_citiesDic objectForKey:model.charindex];
        if (citiesArray == nil){
            //如果取到的城市为空则创建一个数组添加到字典中，键为城市首字母
            NSMutableArray *newArray = [[NSMutableArray alloc] init];
            [newArray addObject:model];
            [_citiesDic setObject:newArray forKey:model.charindex];
        
        }else{
            //如果不为空，则说明该组数组已经存在，直接添加入数组
            [citiesArray addObject:model];
            [_citiesDic setObject:citiesArray forKey:model.charindex];
            
        }
        
        //给热门城市分组
        if ([model.level isEqualToString:@"1"]) {
            [_hotCities addObject:model];
            [_citiesDic setObject:_hotCities forKey:@"热门城市"];
            
        }
        
        //给最近访问分组
        if ([model.nodepath isEqualToString:@"0"]) {
            
            [_latestCities addObject:model];
            [_citiesDic setObject:_latestCities forKey:@"最近访问城市"];
        }
        
        
    }
    
    //获取所有键
    _dataList = [_citiesDic allKeys];
    //排序
    _dataList = [_dataList sortedArrayUsingSelector:@selector(compare:)];
    
    //转化为可变数组
    NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:_dataList];
    [arr removeObject:@"热门城市"];
    [arr removeObject:@"最近访问城市"];
    [arr insertObject:@"最近访问城市" atIndex:0];
    [arr insertObject:@"热门城市" atIndex:0];
    
    _dataList = arr;
    
    _dataListn = _dataList;
}

//


#pragma mark---------UICollectionViewDataSource

//组数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return _dataList.count;
    
}

//每组单元格数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSArray *array = [_citiesDic objectForKey:_dataList[section]];
    
    return array.count;
    
}

//单元格
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //复用单元格
    UICollectionViewCell *cell = [_citiesCollectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    //移除单元格上面所有label视图
    for (UIView *subView in cell.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {
            [subView removeFromSuperview];
        }
    }
    //添加一个label
    UILabel *cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
    NSArray *arr = [_citiesDic objectForKey:_dataList[indexPath.section]];
    CitiesModel *model = arr[indexPath.item];
    
    cellLabel.text = model.names;
//    NSLog(@"%@",cellLabel.text);
    cellLabel.backgroundColor = [UIColor clearColor];
    cellLabel.textColor = [UIColor whiteColor];
    cellLabel.textAlignment = NSTextAlignmentCenter;
    cellLabel.font = [UIFont boldSystemFontOfSize:19];
    
    [cell addSubview:cellLabel];
    cell.layer.cornerRadius = 10;
    cell.layer.borderColor = [[UIColor grayColor] CGColor];
    cell.layer.borderWidth = 3;
    cell.clipsToBounds = YES;
    cell.backgroundColor = [UIColor clearColor];
    
    
    return cell;
}

//头视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
 
    //复用头视图
    UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    //移除头视图上面的所有视图
    for (UIView *subView in header.subviews) {
        if ([subView isKindOfClass:[UILabel class]]) {
            [subView removeFromSuperview];
        }
    }
    //添加一个label
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:header.bounds];
    
    
    headerLabel.text = _dataList[indexPath.section];
    headerLabel.backgroundColor = [UIColor colorWithRed:82/255.0 green:72/255.0 blue:255/255.0 alpha:0.5];
    headerLabel.layer.cornerRadius = 10;
    headerLabel.clipsToBounds = YES;
    
    [header addSubview:headerLabel];
    
    
    return header;
}

//点击单元格时调用
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //取数据
    NSArray *arr = [_citiesDic objectForKey:_dataList[indexPath.section]];
    CitiesModel *model = arr[indexPath.item];
    
    //调用block
    _citiesBlock(model.names);
    
    //pop回根视图控制器
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
