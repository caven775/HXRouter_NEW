//
//  HXRouteFunction.h
//  HXURLRouter
//
//  Created by LHX on 2017/1/17.
//  Copyright © 2017年 Udo. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class HXURLContext;

/**
 获取当前控制器的UINavigationController
 
 @return UINavigationController
 */
FOUNDATION_EXTERN UINavigationController * HXTopViewController (void);

FOUNDATION_EXPORT UIViewController * HXCurrentViewController(void);

FOUNDATION_EXPORT UIViewController * HXCurrentNonePresentViewController(void);

/**
 获取更控制器
 
 @return RootViewController
 */
FOUNDATION_EXTERN UIViewController * HXRootViewController (void);

/**
 获取url中的参数
 
 @param url url
 @return 参数字典
 */
FOUNDATION_EXTERN NSDictionary * HXRouteURLParameters (NSURL * url) API_AVAILABLE(ios(8.0));


/**
 给url添加参数
 
 @param baseURL baseURL
 @param parameters 参数字典
 @return 完整的url
 */
FOUNDATION_EXTERN NSURL * HXAppendParameterWithURL(NSString * baseURL, NSDictionary * parameters) API_AVAILABLE(ios(8.0));

/**
 字符串转url
 
 @param urlString 字符串
 @return url
 */
FOUNDATION_EXTERN NSURL * HXURL(NSString * urlString);

/**
 HXURLContext
 
 @param context 需要携带的上下文
 @return HXURLContext
 */
FOUNDATION_EXTERN HXURLContext * HXContext(id context);

/**
 从路径中获取类名
 
 @param path 路径
 @return 类名
 */
FOUNDATION_EXTERN NSString * HXClassNameFormPath(NSString * path);

