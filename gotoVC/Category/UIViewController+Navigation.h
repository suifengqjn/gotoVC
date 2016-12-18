//
//  UIViewController+Navigation.h
//  gotoVC
//
//  Created by qianjn on 2016/12/18.
//  Copyright © 2016年 SF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Navigation)

//默认有动画
#pragma mark - gotopage
- (void)goToPage:(NSString *_Nonnull)pageName Params:(NSDictionary * __nullable)params;

- (void)goToPage:(NSString *_Nonnull)pageName Params:(NSDictionary *__nullable)params DestroyCurrent:(BOOL)destroy;

- (void)goToPage:(NSString *_Nonnull)pageName Params:(NSDictionary *__nullable)params Animated:(BOOL)Animated;

- (void)goToPage:(NSString *_Nonnull)pageName Params:(NSDictionary *__nullable)params Animated:(BOOL)Animated DestroyCurrent:(BOOL)destroy;

#pragma mark - gotourl
- (void)goToUrl:(NSURL * _Nonnull)url;
- (void)goToUrl:(NSURL *_Nonnull)url ResetStack:(BOOL)reset;
- (void)goToUrl:(NSURL *_Nonnull)url DestroyCurrent:(BOOL)destroy;


#pragma mark - present dismiss
- (void)presentPage:(NSString *_Nonnull)pageName Params:(NSDictionary *__nullable)params completion:(void (^ __nullable)(void))completion;

- (void)dismissPageWithParams:(NSDictionary *__nullable)params;

#pragma mark - pop
- (void)popWithParams:(NSDictionary *__nullable)params;
- (void)popToPage:(NSString *_Nonnull)pageName Params:(NSDictionary *__nullable)params;
- (void)popToPage:(NSString *_Nonnull)pageName Params:(NSDictionary *__nullable)params Animated:(BOOL)animated;

#pragma mark - params
- (NSDictionary *__nullable)getPageParameters;
- (void)setPageParameters:(NSDictionary *_Nonnull)params;




@end
