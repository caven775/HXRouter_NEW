//
//  HXRouteRequest.m
//  HXURLRouter
//
//  Created by LHX on 2017/1/17.
//  Copyright © 2017年 Udo. All rights reserved.
//

#import "HXRouteRequest.h"
#import "HXRouteFunction.h"

@implementation HXRouteRequest

- (instancetype)initWithURL:(NSURL *)url context:(HXURLContext *)context
{
    self = [super init];
    if (self) {
        _host = url.host;
        _originalURL = url;
        _context = context;
        _scheme = url.scheme;
        _parameters = HXRouteURLParameters(url);
    }
    return self;
}


@end
