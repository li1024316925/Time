//
//  TopListModel.h
//  Timer
//
//  Created by LLQ on 16/5/22.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "BaseModel.h"

@interface TopListModel : BaseModel

@property(nonatomic,copy)NSString *topListNameCn,*topListNameEn,*summary;

@property(nonatomic,strong)NSNumber *type;

@end
