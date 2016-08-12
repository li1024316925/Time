//
//  TrailerViewController.m
//  Timer
//
//  Created by LLQ on 16/5/24.
//  Copyright © 2016年 LLQ. All rights reserved.
//

#import "TrailerViewController.h"

@interface TrailerViewController ()
{
    UIWebView *_trailerWebView;
}

@end

@implementation TrailerViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _model.videoTitle;
    
    _trailerWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    //通过网址创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_model.url]];
    //网页加载请求
    [_trailerWebView loadRequest:request];
    
    [self.view addSubview:_trailerWebView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
