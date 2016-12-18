//
//  XCNavigationRouter.h
//  gotoVC
//
//  Created by qianjn on 2016/12/18.
//  Copyright © 2016年 SF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCNavigationRouter : NSObject<UINavigationControllerDelegate> {
    
}
+(instancetype)getInstance;

- (Class)getPageClassForPage:(NSString *)pageName;

@end
