//
//  XCNavigationRouter.m
//  gotoVC
//
//  Created by qianjn on 2016/12/18.
//  Copyright © 2016年 SF. All rights reserved.
//

#import "XCNavigationRouter.h"
#import "UIViewController+Navigation.h"
#import "PageClassManager.h"
@interface XCNavigationRouter () {
    
}

@end

@implementation XCNavigationRouter

+ (instancetype)getInstance
{
    static XCNavigationRouter *_inatance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _inatance = [[XCNavigationRouter alloc] init];
    });
    return _inatance;
}

#pragma mark - page params
- (Class)getPageClassForPage:(NSString *)pageName
{
    if (!pageName) {
        return nil;
    }
    
    return [PageClassManager classWithPageName:pageName];
    
}




#pragma mark UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSDictionary *params = [navigationController getPageParameters];
    if (!params) {
        return;
    }
    
    NSString *command = [params valueForKey:@"command"];
    if([@"reset" isEqualToString:command]){
        NSArray *controllers = @[[navigationController topViewController]];
        navigationController.viewControllers = controllers;
        return;
    }
    
    if ([@"destroy" isEqualToString:command]) {
        NSMutableArray *controllers = [[navigationController viewControllers] mutableCopy];
        
        NSInteger count = controllers.count;
        if(count < 2) return;
        
        [controllers removeObjectAtIndex:(count - 2)];
        
        navigationController.viewControllers = controllers;
        return;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController*)fromController
                                                 toViewController:(UIViewController*)toVC
{
   
    NSDictionary *params = [navigationController getPageParameters];
    BOOL customAnimation = [[params valueForKey:@"custom_animation"] boolValue];
    [navigationController setPageParameters:params];
    if (operation == UINavigationControllerOperationPush && customAnimation){
        return [NSClassFromString(@"FMImageMoveAnnimator") new];
    }
    
    return nil;
}

@end
