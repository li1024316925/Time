//
//  NewsModel.h
//  Timer
//
//  Created by LLQ on 16/5/21.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "BaseModel.h"

@interface NewsModel : BaseModel

@property(nonatomic,copy)NSString *image,*title,*title2,*summary,*summaryInfo,*tag;

@property(nonatomic,strong)NSArray *images;

@property(nonatomic,strong)NSNumber *type,*publishTime,*commentCount;

@end
