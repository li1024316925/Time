//
//  CitiesModel.m
//  Timer
//
//  Created by LLQ on 16/5/16.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "CitiesModel.h"

@implementation CitiesModel


//由于属性名修改，复写重构键--属性关系的方法
-(NSDictionary *)attributesDic:(NSDictionary *)dic{
    
    NSMutableDictionary *mudic = [[NSMutableDictionary alloc] initWithDictionary:[super attributesDic:dic]];
    
    //修改原来的键--属性
    [mudic setObject:@"names" forKey:@"name"];
    
    return mudic;
}

@end
