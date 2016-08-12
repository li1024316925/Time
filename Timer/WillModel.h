//
//  WillModel.h
//  Timer
//
//  Created by LLQ on 16/5/18.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "BaseModel.h"

@interface WillModel : BaseModel

//标题 类型 导演 主演1 主演2 上映日期
@property(nonatomic,copy)NSString *title,*type,*director,*actor1,*actor2,*releaseDate,*image;

//月份 日 期待人数
@property(nonatomic,strong)NSNumber *rMonth,*rDay,*wantedCount;

@end
