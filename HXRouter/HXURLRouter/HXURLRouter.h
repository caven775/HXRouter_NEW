//
//  HXURLRouter.h
//  HXURLRouter
//
//  Created by LHX on 2017/1/17.
//  Copyright © 2017年 Udo. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HX_deprecated(__msg) __attribute__((deprecated(__msg)))

//跳转同一控制器的最小间隔时间
static NSTimeInterval HXMinJumpControllerTimeInterval = 0.5;

@class HXURLContext;
@class HXRouteRequest;

typedef void(^HXContextBlock)(id item);
typedef BOOL(^requestResponse)(HXRouteRequest * request);

@interface HXURLRouter : NSObject

@property (nonatomic, strong) NSMutableDictionary * classNameDictionary;


+ (instancetype)sharedRouter;

#pragma mark  路由配置 

/**
 路由跳转启动
 */
- (void)hx_startRouter;

/**
 添加404
 
 @param handler handler
 */
- (void)hx_add404FailureWithHandler:(requestResponse)handler;

/**
 添加路径
 
 @param request 请求回馈
 */
- (void)hx_addRouterWithComplete:(requestResponse)request;

#pragma mark  正常跳转，无回调 

/**
 无对象的跳转
 
 @param route 跳转路径
 @return 是否成功
 */
- (BOOL)hx_routeURL:(NSURL *)route;

/**
 携带对象的跳转
 
 @param route 跳转路径
 @param context 传入的对象
 @return 是否成功
 */
- (BOOL)hx_routeURL:(NSURL *)route
            context:(HXURLContext *)context;


#pragma mark  storyboard跳转，无回调 

- (BOOL)hx_routeURL:(NSURL *)route
     storyboardName:(NSString *)storyboard;

- (BOOL)hx_routeURL:(NSURL *)route
            context:(HXURLContext *)context
     storyboardName:(NSString *)storyboard;

- (BOOL)hx_routeURL:(NSURL *)route
     storyboardName:(NSString *)storyboard
         identifier:(NSString *)identifier;

- (BOOL)hx_routeURL:(NSURL *)route
            context:(HXURLContext *)context
     storyboardName:(NSString *)storyboard
         identifier:(NSString *)identifier;

#pragma mark  正常跳转，有回调 

/**
 带block的无对象的跳转
 
 @param route 跳转路径
 @param callBack 回调blcok
 @return 是否成功
 */
- (BOOL)hx_routeURL:(NSURL *)route
           callBack:(HXContextBlock)callBack;

/**
 携带对象并且带block的跳转
 
 @param route 跳转路径
 @param context 传入的对象
 @param callBack 回调blcok
 @return 是否成功
 */
- (BOOL)hx_routeURL:(NSURL *)route
            context:(HXURLContext *)context
           callBack:(HXContextBlock)callBack;


#pragma mark  storyboard跳转，有回调 

- (BOOL)hx_routeURL:(NSURL *)route
     storyboardName:(NSString *)storyboard
           callBack:(HXContextBlock)callBack;

- (BOOL)hx_routeURL:(NSURL *)route
            context:(HXURLContext *)context
     storyboardName:(NSString *)storyboard
           callBack:(HXContextBlock)callBack;

- (BOOL)hx_routeURL:(NSURL *)route
     storyboardName:(NSString *)storyboard
         identifier:(NSString *)identifier
           callBack:(HXContextBlock)callBack;

- (BOOL)hx_routeURL:(NSURL *)route
            context:(HXURLContext *)context
     storyboardName:(NSString *)storyboard
         identifier:(NSString *)identifier
           callBack:(HXContextBlock)callBack;


@end

