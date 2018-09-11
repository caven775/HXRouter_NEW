//
//  UIViewController+THXRouter.h
//  Teacher_iOS
//
//  Created by TAL on 2018/7/3.
//  Copyright © 2018年 whqfor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXRouterProtocol.h"

@interface UIViewController (THXRouter) <HXRouterProtocol>

@property (nonatomic, copy, class) NSString * loadErrorReason;

+ (UIViewController *)hx_loadFromMainStoryboard;
+ (UIViewController *)hx_loadFromStoryboard:(NSString *)storyboardName;
+ (UIViewController *)hx_loadFromMainStoryboardWithIdentifier:(NSString *)identifier;
+ (UIViewController *)hx_loadFromStoryboard:(NSString *)storyboardName
                              identifier:(NSString *)identifier;

@end
