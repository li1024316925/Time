//
//  CinemaCell.m
//  Timer
//
//  Created by LLQ on 16/5/19.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "CinemaCell.h"

@implementation CinemaCell

- (void)awakeFromNib {
    // Initialization code
}

//复写set方法给属性赋值
-(void)setModel:(CinemaModel *)model{
    _model = model;
    
    _title.text = _model.cinameName;
    _address.text = _model.address;
    _length.text = [NSString stringWithFormat:@"距离%.2f公里",_model.length];
    CGFloat f = [_model.minPrice floatValue];
    _price.text = [NSString stringWithFormat:@"￥%.1f",f/100];
    
    int i = 0;
    //3D
    if ([[_model.feature objectForKey:@"has3D"] intValue] == 0) {
        _image1.hidden = YES;
        //每有一个图片隐藏，i+1
        i++;
    }
    //IMAX
    //首先平移
    _image2.transform = CGAffineTransformMakeTranslation(-i*36, 0);
    if ([[_model.feature objectForKey:@"hasIMAX"] intValue] == 0) {
        _image2.hidden = YES;
        i++;
    }
    //hasVIP
    _image3.transform = CGAffineTransformMakeTranslation(-i*36, 0);
    if ([[_model.feature objectForKey:@"hasVIP"] intValue] == 0) {
        _image3.hidden = YES;
        i++;
    }
    //hasPark
    _image4.transform = CGAffineTransformMakeTranslation(-i*36, 0);
    if ([[_model.feature objectForKey:@"hasPark"] intValue] == 0) {
        _image4.hidden = YES;
        i++;
    }
    //hasServiceTicket
    _image5.transform = CGAffineTransformMakeTranslation(-i*36, 0);
    if ([[_model.feature objectForKey:@"hasServiceTicket"] intValue] == 0) {
        _image5.hidden = YES;
        i++;
    }
    //hasWifi
    _image6.transform = CGAffineTransformMakeTranslation(-i*36, 0);
    if ([[_model.feature objectForKey:@"hasWifi"] intValue] == 0) {
        _image6.hidden = YES;
        i++;
    }
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
