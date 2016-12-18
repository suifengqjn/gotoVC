//
//  UIViewController+Navigation.m
//  gotoVC
//
//  Created by qianjn on 2016/12/18.
//  Copyright © 2016年 SF. All rights reserved.
//

#import "UIViewController+Navigation.h"
#import "XCNavigationRouter.h"
#import "NSURL+Utility.h"
@implementation UIViewController (Navigation)

#pragma mark - gotopage
- (void)goToPage:(NSString *_Nonnull)pageName Params:(NSDictionary * __nullable)params {
    [self goToPage:pageName Params:params DestroyCurrent:NO];
}

- (void)goToPage:(NSString *_Nonnull)pageName Params:(NSDictionary *__nullable)params DestroyCurrent:(BOOL)destroy {
    [self goToPage:pageName Params:params Animated:YES DestroyCurrent:destroy];
}

- (void)goToPage:(NSString *_Nonnull)pageName Params:(NSDictionary *__nullable)params Animated:(BOOL)Animated {
    [self goToPage:pageName Params:params Animated:YES DestroyCurrent:NO];
}

- (void)goToPage:(NSString *_Nonnull)pageName Params:(NSDictionary *__nullable)params Animated:(BOOL)Animated DestroyCurrent:(BOOL)destroy {
    
    Class nextPageClass = [[XCNavigationRouter getInstance] getPageClassForPage:pageName];
    if (!nextPageClass) {
        return;
    }
    UIViewController *targetController = [nextPageClass new];
    //[targetController setValue:pageName forKey:@"page_name"];
    [targetController setValue:params forKey:@"xc_page_parameters"];
    if ([targetController isKindOfClass:[UIViewController class]]) {
        targetController.hidesBottomBarWhenPushed = YES;
        [self checkNavigationDelegate];
        [self markCurrentChildController];
        if (destroy) {
            [self.navigationController setPageParameters:@{@"command" : @"destroy"}];
        }
        
        [self.navigationController pushViewController:targetController animated:Animated];
    }
    
    
}


#pragma mark - gotourl
- (void)goToUrl:(NSURL * _Nonnull)url {
    [self goToUrl:url Params:nil];
}
- (void)goToUrl:(NSURL * _Nonnull)url Params:(NSDictionary * __nullable)params{
    [self goToUrl:url Params:params DestroyCurrent:NO];
}
- (void)goToUrl:(NSURL *_Nonnull)url Params:(NSDictionary * __nullable)params ResetStack:(BOOL)reset {
    [self goToUrl:url Params:params ResetStack:reset DestroyCurrent:NO];
}
- (void)goToUrl:(NSURL *_Nonnull)url Params:(NSDictionary * __nullable)params DestroyCurrent:(BOOL)destroy {
    [self goToUrl:url Params:params ResetStack:NO DestroyCurrent:destroy];
}
- (void)goToUrl:(NSURL *)url Params:(NSDictionary * __nullable)params ResetStack:(BOOL)reset DestroyCurrent:(BOOL)destroy {
    
    UIViewController *targetController = nil;
    
    // 跳转到网页
    if ([url.scheme isEqualToString:@"http"] || [url.scheme isEqualToString:@"https"]) {
        targetController = [[[XCNavigationRouter getInstance] getPageClassForPage:@"webview"] new];
        NSMutableDictionary *newParam = [NSMutableDictionary dictionaryWithDictionary:params];
        [newParam setValue:[url absoluteString] forKey:@"url"];
        [newParam setValue:@(1) forKey:@"hidesBottomBarWhenPushed"];
        //[newParam setValue:@"webview" forKey:@"page_name"];
        [targetController setValue:newParam forKey:@"xc_page_parameters"];
        
    }
    //根据deeplink 跳转到控制器
    if ([url.scheme isEqualToString:@"fivemiles"]) {
        NSString *pageName = [url host];
        NSDictionary *params = [NSURL parserQueryText:[url query]];
        
        Class clazz = [[XCNavigationRouter getInstance] getPageClassForPage:pageName];
        if (!clazz) {
            return;
        }
        targetController = [clazz new];
        
        //[targetController setValue:url.host forKey:@"page_name"];
        [targetController setValue:params forKey:@"xc_page_parameters"];
    }
    
    if ([targetController isKindOfClass:[UIViewController class]]) {
        [self checkNavigationDelegate];
        [self markCurrentChildController];
        if (reset) {
            [self.navigationController setPageParameters:@{@"command" : @"reset"}];
        }else if (destroy) {
            [self.navigationController setPageParameters:@{@"command" : @"destroy"}];
        }
        
        targetController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:targetController animated:YES];
    }
}



#pragma mark - params
- (NSDictionary *)getPageParameters {
    NSDictionary *params = [self valueForKey:@"xc_page_parameters"];
    if (params) {
        [self setValue:nil forKey:@"xc_page_parameters"];
        return params;
    }
    
    UIViewController *parent = [self parentViewController];
    if (parent) {
        UIViewController *activeChild = [parent valueForKey:@"xc_current_active_child_controller"];
        if(activeChild != self) {
            return params;
        }
        params = [parent valueForKey:@"xc_page_parameters"];
        if (params) {
            [parent setValue:nil forKey:@"xc_page_parameters"];
        }
    }
    return params;
}

- (void)setPageParameters:(NSDictionary *)params {
    NSDictionary *originParams = [self valueForKey:@"xc_page_parameters"];
    if (!originParams) {
        [self setValue:params forKey:@"xc_page_parameters"];
        return;
    }
    
    NSMutableDictionary *newParams = [NSMutableDictionary dictionaryWithDictionary:originParams];
    [newParams setValuesForKeysWithDictionary:params];
    
    [self setValue:newParams forKey:@"xc_page_parameters"];
}



- (void)checkNavigationDelegate {
    if (self.navigationController.delegate) {
        return;
    }
    self.navigationController.delegate = [XCNavigationRouter getInstance];
}

- (void)markCurrentChildController {
    Class fmclazz = NSClassFromString(@"XCViewController");
    if ([self.parentViewController isKindOfClass:fmclazz]) {
        [self.parentViewController setValue:self
                                     forKey:@"xc_current_active_child_controller"];
    }
}
@end
