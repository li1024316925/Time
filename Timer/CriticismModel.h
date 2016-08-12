//
//  CriticismModel.h
//  Timer
//
//  Created by LLQ on 16/5/22.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "BaseModel.h"

@interface CriticismModel : BaseModel

@property(nonatomic,copy)NSString *nickname,*userImage,*rating,*title,*summary;

@property(nonatomic,strong)NSDictionary *relatedObj;

@end
