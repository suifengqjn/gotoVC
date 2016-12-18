//
//  PageClassManager.m
//  gotoVC
//
//  Created by qianjn on 2016/12/18.
//  Copyright © 2016年 SF. All rights reserved.
//

#import "PageClassManager.h"

@implementation PageClassManager
+(Class)classWithPageName:(NSString *)pageName
{
    if ([@"one" isEqualToString:pageName]) {
        return NSClassFromString(@"OneController");
    }
    if ([@"two" isEqualToString:pageName]) {
        return NSClassFromString(@"TwoController");
    }
    if ([@"three" isEqualToString:pageName]) {
        return NSClassFromString(@"ThreeViewController");
    }
    if ([@"present" isEqualToString:pageName]) {
        return NSClassFromString(@"PresentController");
    }
    return nil;
}

@end
