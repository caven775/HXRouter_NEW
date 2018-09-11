//
//  HXRouteRequest.h
//  HXURLRouter
//
//  Created by LHX on 2017/1/17.
//  Copyright © 2017年 Udo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HXURLContext.h"

static NSString * const kFailureURL              = @"404-Failure://";
static NSString * const kDefaultURL              = @"defaultRouter://route/application";
static NSString * const kDefaultURLScheme        = @"defaultRouter";

@interface HXRouteRequest : NSObject

- (instancetype)initWithURL:(NSURL *)url context:(HXURLContext *)context;

/**url 的host */
@property (nonatomic, copy, readonly) NSString * host;
/**url 的scheme */
@property (nonatomic, copy, readonly) NSString * scheme;
/**originalURL */
@property (nonatomic, strong, readonly) NSURL * originalURL;
/**传入的对象 */
@property (nonatomic, strong, readonly) HXURLContext * context;
/**url 的参数字典 */
@property (nonatomic, strong, readonly) NSDictionary * parameters;
/** 跳转错误原因 */
@property (nonatomic, copy) NSString * errorReason;

@end

