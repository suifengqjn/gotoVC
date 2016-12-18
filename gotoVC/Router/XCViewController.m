//
//  XCViewController.m
//  gotoVC
//
//  Created by qianjn on 2016/12/18.
//  Copyright © 2016年 SF. All rights reserved.
//

#import "XCViewController.h"

@interface XCViewController ()

@end

@implementation XCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.navigationController.viewControllers.count > 1) {
        [self setUpNavigation];
    }
    
}


- (void)setUpNavigation
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"navigation_back"] style:UIBarButtonItemStyleDone target:self action:@selector(go_back)];
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
}

//子类可重写此方法获得返回事件
- (void)go_back
{
    [self popWithParams:nil];
}
@end
