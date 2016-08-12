//
//  ADView.h
//  Timer
//
//  Created by LLQ on 16/5/25.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADView : UIView

@property(nonatomic,copy)NSString *closeImageStr;

@property(nonatomic,strong)NSArray *imageNameArray;

-(void)showViewAnimation;

@end
