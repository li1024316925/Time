//
//  CinemaModel.h
//  Timer
//
//  Created by LLQ on 16/5/19.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "BaseModel.h"

@interface CinemaModel : BaseModel

@property(nonatomic,copy)NSString *cinameName,*address;

@property(nonatomic,strong)NSNumber *minPrice,*longitude,*latitude;

@property(nonatomic,strong)NSDictionary *feature;

@property(nonatomic,assign)float length;
@end
