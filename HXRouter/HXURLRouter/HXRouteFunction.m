//
//  HXRouteFunction.m
//  HXURLRouter
//
//  Created by LHX on 2017/1/17.
//  Copyright © 2017年 Udo. All rights reserved.
//

#import "HXRouteFunction.h"
#import "HXURLContext.h"

/**
 获取当前控制器的UINavigationController
 
 @return UINavigationController
 */
UINavigationController * HXTopViewController ()
{
    UIViewController * rootViewController = HXRootViewController();
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)rootViewController;
    } else if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController * tabVC = (UITabBarController *)rootViewController;
        return (UINavigationController *)[tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
    } else {
        return nil;
    }
}

UIViewController * HXFindVisibleViewController(UIViewController *from) {
    if (nil == from) { return nil; }
    
    UIViewController *presented = [from presentedViewController];
    if (nil != presented) {
        return HXFindVisibleViewController(presented);
    }
    
    if ([from isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *) from;
        if (tab.viewControllers.count > 0) {
            return HXFindVisibleViewController(tab.selectedViewController);
        }
        return tab;
    } else if ([from isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *) from;
        if (nav.viewControllers.count > 0) {
            return HXFindVisibleViewController(nav.topViewController);
        }
        return nav;
    } else {
        return from;
    }
}

UIViewController * HXCurrentViewController() {
    UIViewController *root = HXRootViewController();
    return HXFindVisibleViewController(root);
}


UIViewController * HXFindVisibleNonePresentViewController(UIViewController *from) {
    if (nil == from) { return nil; }
    
    if ([from isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *) from;
        if (tab.viewControllers.count > 0) {
            return HXFindVisibleNonePresentViewController(tab.selectedViewController);
        }
        return tab;
    } else if ([from isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nav = (UINavigationController *) from;
        if (nav.viewControllers.count > 0) {
            return HXFindVisibleNonePresentViewController(nav.topViewController);
        }
        return nav;
    } else {
        return from;
    }
}


UIViewController * HXCurrentNonePresentViewController() {
    UIViewController *root = HXRootViewController();
    return HXFindVisibleNonePresentViewController(root);
}

/**
 获取更控制器
 
 @return RootViewController
 */
UIViewController * HXRootViewController ()
{
    return [[[[UIApplication sharedApplication] delegate] window] rootViewController];
}

/**
 获取url中的参数
 
 @param url url
 @return 参数字典
 */
NSDictionary * HXRouteURLParameters (NSURL * url)
{
    if (!url) { return nil;}
    NSURLComponents * components = [[NSURLComponents alloc] initWithURL:url resolvingAgainstBaseURL:YES];
    if (!components) { return nil;}
    NSMutableDictionary * dictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    for (NSURLQueryItem * item in [components queryItems]) {
        dictionary[item.name] = (item.value.length) ? item.value : [NSNull null];
    }
    return dictionary;
}


/**
 给url添加参数
 
 @param baseURL baseURL
 @param parameters 参数字典
 @return 完整的url
 */
NSURL * HXAppendParameterWithURL(NSString * baseURL, NSDictionary * parameters)
{
    NSURL * url = [NSURL URLWithString:baseURL];
    if (!parameters.allKeys.count) { return url;}
    NSURLComponents * components = [NSURLComponents componentsWithString:baseURL];
    if (!components) { return url;}
    NSDictionary * originalParameters = HXRouteURLParameters(url);
    NSMutableArray <NSURLQueryItem *>* items = [[NSMutableArray alloc] initWithCapacity:parameters.allKeys.count];
    if (originalParameters) {
        [originalParameters enumerateKeysAndObjectsUsingBlock:^(NSString * key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if (!obj) { obj = [NSNull null];}
            NSURLQueryItem * item = [[NSURLQueryItem alloc] initWithName:key value:obj];
            [items addObject:item];
        }];
    }
    [parameters enumerateKeysAndObjectsUsingBlock:^(NSString * key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (!obj) { obj = [NSNull null];}
        NSURLQueryItem * item = [[NSURLQueryItem alloc] initWithName:key value:obj];
        [items addObject:item];
    }];
    
    [components setQueryItems:items];
    return components.URL;
}


/**
 字符串转url
 
 @param urlString 字符串
 @return url
 */
NSURL * HXURL(NSString * urlString)
{
    return [NSURL URLWithString:urlString];
}


/**
 HXURLContext
 
 @param context 需要携带的上下文
 @return HXURLContext
 */
HXURLContext * HXContext(id context)
{
    HXURLContext * con = [[HXURLContext alloc] init];
    con.obj = context;
    return con;
}


/**
 从路径中获取类名
 
 @param path 路径
 @return 类名
 */
NSString * HXClassNameFormPath(NSString * path)
{
    path = [path substringFromIndex:1];
    NSArray * paths = [path componentsSeparatedByString:@"/"];
    NSString * classPath = nil;
    for (NSString * x in paths) {
        NSRange range = [x rangeOfString:@"Controller"];
        if (range.location != NSNotFound) {
            classPath = x;
            break;
        }
    }
    if (!classPath.length) {
        classPath = [paths firstObject];
    }
    return classPath;
}

