//
//  HXRouteRecode.m
//  HXURLRouter
//
//  Created by LHX on 2017/1/17.
//  Copyright © 2017年 Udo. All rights reserved.
//

#import "HXRouteRecode.h"
#import "HXRouteRequest.h"
#import "HXRouteFunction.h"

@interface HXRouteRecode ()
{
    NSRegularExpression * _regx;
}

@end

@implementation HXRouteRecode

- (instancetype)initWithURL:(NSString *)url handler:(requestResponseHandler)handler
{
    self = [super init];
    if (self) {
        _url = url;
        _handler = handler;
        NSError * error;
        if (url.length) {
            NSRegularExpression * regx = [NSRegularExpression regularExpressionWithPattern:_url
                                                                                   options:NSRegularExpressionCaseInsensitive
                                                                                     error:&error];
            if (error) {
                @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"url不合法 %@;\n %@", _url, error] userInfo:@{NSLocalizedFailureReasonErrorKey:_url?:@"nil"}];
            }
            _regx = regx;
        }
    }
    return self;
}

- (BOOL)canHandlerRequestURL:(NSString *)url
{
    if (url == nil || !url.length || [url isEqual:[NSNull null]] || !_regx) {
        return NO;
    }
    NSArray<NSTextCheckingResult*> * result = [_regx matchesInString:url options:0 range:NSMakeRange(0, url.length)];
    if (result.count == 0) {
        return NO;
    }
    NSTextCheckingResult * firstResult = result.firstObject;
    if (firstResult.range.location != 0) {
        return NO;
    }
    return YES;
}

@end

