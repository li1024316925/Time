//
//  TrailerView.h
//  Timer
//
//  Created by LLQ on 16/5/21.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TrailerView : UIView<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSArray *dataList;

@end
