//
//  TwoController.m
//  goToUrl
//
//  Created by qianjn on 2016/12/3.
//  Copyright © 2016年 SF. All rights reserved.
//

#import "TwoController.h"

@interface TwoController ()

@end

@implementation TwoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"two";
    self.view.backgroundColor =[UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor grayColor];
    button.frame = CGRectMake(100, 100, 100, 100);
    [button setTitle:@"push" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pushClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.backgroundColor = [UIColor grayColor];
    button2.frame = CGRectMake(100, 300, 100, 100);
    [button2 setTitle:@"pop" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(popClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
}


- (void)pushClick
{
    [self goToPage:@"three" Params:@{@"from":@"two"}];
}

- (void)popClick
{
    [self popWithParams:@{@"from":@"two"}];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSDictionary *param  = [self getPageParameters];
    if (param) {
        
    }
}

@end
