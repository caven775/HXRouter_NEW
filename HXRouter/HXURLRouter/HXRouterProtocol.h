//
//  HXURLRouterProtocol.h
//  Finance
//
//  Created by LHX on 2017/11/27.
//  Copyright © 2017年 Udo. All rights reserved.
//


#import <Foundation/Foundation.h>

@class HXRouteRequest;

@protocol HXRouterProtocol <NSObject>

@optional
/**
 处理跳转参数
 
 @param request 跳转参数
 */
- (void)hx_routeHandle:(HXRouteRequest *)request;

@end
