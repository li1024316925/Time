//
//  CoreDataFromJson.h
//  Timer
//
//  Created by LLQ on 16/5/16.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataFromJson : NSObject


//1.声明一个类方法，返回值为id类型（因为我们不是道json文件中最外层是什么容器）
//通过文件名加载json文件方法
+(id)jsonObjectFromFileName:(NSString *)fileName;

@end
