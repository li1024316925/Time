//
//  HomeModel.h
//  Timer
//
//  Created by LLQ on 16/5/13.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HomeModel : BaseModel

@property (nonatomic,copy)NSString *titleCn,*titleEn,*img,*commonSpecial;
@property (nonatomic,strong)NSNumber *ratingFinal,*rYear;

@end
