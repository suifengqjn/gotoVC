//
//  XCWebViewController.m
//  gotoVC
//
//  Created by qianjn on 2016/12/18.
//  Copyright © 2016年 SF. All rights reserved.
//

#import "XCWebViewController.h"

@interface XCWebViewController ()
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSString *url;
@end

@implementation XCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [UIWebView new];
    //fix 在6p web不能滑动的bug
    self.webView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-44);
    self.webView.backgroundColor = [UIColor clearColor];
    [self.webView setOpaque:YES];
    self.webView.dataDetectorTypes = UIDataDetectorTypeNone;
    self.webView.keyboardDisplayRequiresUserAction = NO;
    [self.view addSubview:self.webView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSDictionary *param = [self getPageParameters];
    if (param) {
        if ([param valueForKey:@"url"]) {
            self.url = [param valueForKey:@"url"];
            [self reloadUrl];
        }
    }
}


-(void)reloadUrl
{
    if (self.url == nil) {
        return;
    }
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:self.url]];
    [request setHTTPMethod:@"GET"];
    [self.webView stopLoading];
    [self.webView loadRequest:request];
    
    
    
}
@end
