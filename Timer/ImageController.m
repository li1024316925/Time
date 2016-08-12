//
//  ImageController.m
//  Timer
//
//  Created by LLQ on 16/5/24.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "ImageController.h"

@interface ImageController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation ImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor blackColor];
    
    
    //加载集合视图
    [self loadImageCollectionView];
    
}



//创建集合视图
-(void)loadImageCollectionView{
    
    //创建布局类
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kScreen_W+20, 400);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    //创建集合视图
    _imageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 150, kScreen_W+20, 300) collectionViewLayout:layout];
    _imageCollectionView.backgroundColor = [UIColor blackColor];
    _imageCollectionView.delegate = self;
    _imageCollectionView.dataSource = self;
    //开启分页
    _imageCollectionView.pagingEnabled = YES;
    //滑动到指定位置
    [_imageCollectionView scrollToItemAtIndexPath:_indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    //注册单元格
    [_imageCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    
    [self.view addSubview:_imageCollectionView];
    
}

#pragma mark-----------UICollectionViewDataSource

//返回每组单元格个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataList.count;
    
}

//返回单元格
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = _dataList[indexPath.item];
    //单元格复用
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //移除所有imageView，防止重复添加
    for (UIView *view in cell.contentView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(cell.bounds.origin.x, cell.bounds.origin.y, kScreen_W, cell.bounds.size.height)];
    [imageView setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"url2"]]];
    
    [cell addSubview:imageView];
    
    return cell;
}


#pragma mark------------UICollectionViewDelegate

//点击单元格时调用
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //模态消失
    [self dismissViewControllerAnimated:YES completion:nil];

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
