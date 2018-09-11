//
//  UIViewController+THXRouter.m
//  Teacher_iOS
//
//  Created by TAL on 2018/7/3.
//  Copyright © 2018年 whqfor. All rights reserved.
//

#import "UIViewController+THXRouter.h"
#import <objc/runtime.h>

@implementation UIViewController (THXRouter)

+ (void)setLoadErrorReason:(NSString *)loadErrorReason
{
    objc_setAssociatedObject([UIApplication sharedApplication], @selector(loadErrorReason), loadErrorReason, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

+ (NSString *)loadErrorReason
{
    return objc_getAssociatedObject([UIApplication sharedApplication], @selector(loadErrorReason));
}

+ (UIViewController *)hx_loadFromMainStoryboard
{
    return [self hx_loadFromStoryboard:@"Main" identifier:NSStringFromClass(self)];
}

+ (UIViewController *)hx_loadFromStoryboard:(NSString *)storyboardName
{
    return [self hx_loadFromStoryboard:storyboardName identifier:NSStringFromClass(self)];
}

+ (UIViewController *)hx_loadFromMainStoryboardWithIdentifier:(NSString *)identifier
{
    return [self hx_loadFromStoryboard:@"Main" identifier:identifier];
}

+ (UIViewController *)hx_loadFromStoryboard:(NSString *)storyboardName identifier:(NSString *)identifier
{
    NSAssert(storyboardName.length != 0, @"storyboardName不可为空");
    UIViewController * vc = nil;
    UIStoryboard * storyboard = nil;
    @try {
        storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:[NSBundle mainBundle]];
    } @catch (NSException *exception) {
        UIViewController.loadErrorReason = exception.reason;
    }
    
    @try {
        vc = [storyboard instantiateViewControllerWithIdentifier:identifier];
    } @catch (NSException *exception) {
        UIViewController.loadErrorReason = [NSString stringWithFormat:@"storyboard：%@\n%@", storyboardName, exception.reason];
    }
    if (vc) {
        UIViewController.loadErrorReason = nil;
    }
    return vc;
}

@end
