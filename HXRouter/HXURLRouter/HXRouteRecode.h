//
//  HXRouteRecode.h
//  HXURLRouter
//
//  Created by LHX on 2017/1/17.
//  Copyright © 2017年 Udo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HXRouteRequest;

@interface HXRouteRecode : NSObject

typedef BOOL(^requestResponseHandler)(HXRouteRequest * request);

@property (nonatomic, copy, readonly) NSString * url;
@property (nonatomic, copy, readonly) requestResponseHandler handler;

- (instancetype)initWithURL:(NSString *)url handler:(requestResponseHandler)handler;
- (BOOL)canHandlerRequestURL:(NSString *)url;

@end

