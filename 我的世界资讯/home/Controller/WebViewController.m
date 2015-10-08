//
//  WebViewController.m
//  我的世界资讯
//
//  Created by huchunyuan on 15/10/4.
//  Copyright (c) 2015年 Lafree. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"webBackImage"];
    
    UIView *view = [[UIView alloc] initWithFrame:imageView.frame];
    view.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6];
    [imageView addSubview:view];
    [self.view addSubview:imageView];
    
    UIWebView * webView = [[UIWebView alloc] initWithFrame:CGRectMake(5, 5+64, self.view.frame.size.width-10, self.view.frame.size.height-64-10)];
    webView.backgroundColor = [UIColor clearColor];
    webView.scalesPageToFit = YES;

   
    
    
    self.navigationItem.title = self.navigationTitle;
    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:_urlStr]];
    [webView loadRequest:request];
    [self.view addSubview: webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
