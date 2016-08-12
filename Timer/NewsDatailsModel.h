//
//  NewsDatailsModel.h
//  Timer
//
//  Created by LLQ on 16/5/24.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "BaseModel.h"

@interface NewsDatailsModel : BaseModel

@property(nonatomic,copy)NSString *title,*title2,*content,*time,*author,*source,*editor;

@property(nonatomic,strong)NSArray *relations,*images;

@end
