//
//  CoreDataFromJson.m
//  Timer
//
//  Created by LLQ on 16/5/16.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "CoreDataFromJson.h"

@implementation CoreDataFromJson

//2.实现这个类方法
+(id)jsonObjectFromFileName:(NSString *)fileName{
    
    //获取json文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    //解析为NSData类型
    NSData *data = [NSData dataWithContentsOfFile:path];
    //解析为最外层容器
    id dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    return dic;
}

@end
