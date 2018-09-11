//
//  HXURLRouter.m
//  HXURLRouter
//
//  Created by LHX on 2017/1/17.
//  Copyright © 2017年 Udo. All rights reserved.
//

#import "HXURLRouter.h"
#import "HXRouteRecode.h"
#import "HXRouteRequest.h"
#import "HXRouteFunction.h"
#import "UIViewController+THXRouter.h"

@interface HXURLRouter ()

@property (nonatomic, strong) HXRouteRecode * reocde404;
@property (nonatomic, strong) NSMutableDictionary * routeDictionary;

/**
 保存即将跳转的页面
 key: url
 value: date （本次跳转的时间戳）
 
 当检测到页面跳转时，判断本次跳转是否由短时间内频繁操作引起的，若是则不予跳转
 */
@property (nonatomic, strong) NSMutableDictionary * targetURLDictionary;

/**
 路由配置完成
 */
@property (nonatomic, assign) BOOL alreadyConfigRouter;


@end

@implementation HXURLRouter

- (NSMutableDictionary *)routeDictionary
{
    if (!_routeDictionary) {
        _routeDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    return _routeDictionary;
}

- (NSMutableDictionary *)classNameDictionary
{
    if (!_classNameDictionary) {
        _classNameDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    return _classNameDictionary;
}

- (NSMutableDictionary *)targetURLDictionary
{
    if (!_targetURLDictionary) {
        _targetURLDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    return _targetURLDictionary;
}


+ (instancetype)sharedRouter
{
    static HXURLRouter * route = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        route = [[self alloc] init];
        [route configErrorRouter];
    });
    return route;
}

- (BOOL)hx_routeURL:(NSURL *)route
{
    return [self _routeURL:route context:nil callBack:nil];
}

- (BOOL)hx_routeURL:(NSURL *)route context:(HXURLContext *)context
{
    return [self _routeURL:route context:context callBack:nil];
}

- (BOOL)hx_routeURL:(NSURL *)route storyboardName:(NSString *)storyboard
{
    return [self _routeURL:route context:nil storyboardName:storyboard identifier:nil callBack:nil];
}

- (BOOL)hx_routeURL:(NSURL *)route context:(HXURLContext *)context storyboardName:(NSString *)storyboard
{
    return [self _routeURL:route context:context storyboardName:storyboard identifier:nil callBack:nil];
}

- (BOOL)hx_routeURL:(NSURL *)route storyboardName:(NSString *)storyboard identifier:(NSString *)identifier
{
    return [self _routeURL:route context:nil storyboardName:storyboard identifier:identifier callBack:nil];
}

- (BOOL)hx_routeURL:(NSURL *)route context:(HXURLContext *)context storyboardName:(NSString *)storyboard identifier:(NSString *)identifier
{
    return [self _routeURL:route context:context storyboardName:storyboard identifier:identifier callBack:nil];
}

- (BOOL)hx_routeURL:(NSURL *)route callBack:(HXContextBlock)callBack
{
    return [self _routeURL:route context:nil callBack:callBack];
}

- (BOOL)hx_routeURL:(NSURL *)route context:(HXURLContext *)context callBack:(HXContextBlock)callBack
{
    return [self _routeURL:route context:context callBack:callBack];
}

- (BOOL)hx_routeURL:(NSURL *)route storyboardName:(NSString *)storyboard callBack:(HXContextBlock)callBack
{
    return [self _routeURL:route context:nil storyboardName:storyboard identifier:nil callBack:callBack];
}

- (BOOL)hx_routeURL:(NSURL *)route storyboardName:(NSString *)storyboard identifier:(NSString *)identifier callBack:(HXContextBlock)callBack
{
    return [self _routeURL:route context:nil storyboardName:storyboard identifier:identifier callBack:callBack];
}

- (BOOL)hx_routeURL:(NSURL *)route context:(HXURLContext *)context storyboardName:(NSString *)storyboard identifier:(NSString *)identifier callBack:(HXContextBlock)callBack
{
    return [self _routeURL:route context:context storyboardName:storyboard identifier:identifier callBack:callBack];
}

- (BOOL)hx_routeURL:(NSURL *)route context:(HXURLContext *)context storyboardName:(NSString *)storyboard callBack:(HXContextBlock)callBack
{
    return [self _routeURL:route context:context storyboardName:storyboard identifier:nil callBack:callBack];
}

- (BOOL)_routeURL:(NSURL *)route
          context:(HXURLContext *)context
   storyboardName:(NSString *)storyboard
       identifier:(NSString *)identifier
         callBack:(HXContextBlock)callBack
{
    if (!context) {
        context = [[HXURLContext alloc] init];
    }
    context.loadFromStoryboard = YES;
    context.storyboard = storyboard;
    context.controllerIdentifier = identifier;
    return [self _routeURL:route context:context callBack:callBack];
}

- (BOOL)_routeURL:(NSURL *)route context:(HXURLContext *)context callBack:(HXContextBlock)callBack
{
    if (!context) {
        context = [[HXURLContext alloc] init];
    }
    context.callBack = callBack;
    return [self getRoute:route context:context controllerIdentifier:context.controllerIdentifier failure404:YES];
}

- (void)hx_add404FailureWithHandler:(requestResponse)handler
{
    self.reocde404 = [[HXRouteRecode alloc] initWithURL:kFailureURL handler:handler];
}

- (void)hx_addRouterWithComplete:(requestResponse)request
{
    NSParameterAssert(kDefaultURL);
    NSParameterAssert(request);
    [self checkRoute:kDefaultURL request:request];
}

- (void)checkRoute:(NSString *)route request:(requestResponse)request
{
    [self hasRoute:route];
    HXRouteRecode * checkRecode = self.routeDictionary[route];
    if (!checkRecode) {
        HXRouteRecode * recode = [[HXRouteRecode alloc] initWithURL:route handler:request];
        [self.routeDictionary setValue:recode forKey:HXURL(route).path];
    }
}

- (BOOL)hasRoute:(NSString *)route
{
    HXRouteRecode * checkRecode = self.routeDictionary[route];
    if (!checkRecode) { return NO;}
    @throw [NSException exceptionWithName:NSInvalidArgumentException
                                   reason:[NSString stringWithFormat:@"该路径已存在[%@],请添加不同的路径", route]
                                 userInfo:nil];
    return YES;
}

- (BOOL)getRoute:(NSURL *)url
         context:(HXURLContext *)context
controllerIdentifier:(NSString *)controllerIdentifier
      failure404:(BOOL)failure
{
    NSString * absoluteString = url.absoluteString;
    if ([self.targetURLDictionary objectForKey:absoluteString]) {
        NSTimeInterval time = [[NSDate date] timeIntervalSinceDate:self.targetURLDictionary[absoluteString]];
        if (time <= HXMinJumpControllerTimeInterval) {
            NSLog(@"  频繁点击，屏蔽跳转  == %f", time);
            return NO;
        }
    }
    HXRouteRequest * request = [[HXRouteRequest alloc] initWithURL:url context:context];
    HXRouteRecode * routeRecode = self.routeDictionary[HXURL(kDefaultURL).path];
    
    NSString * className = self.classNameDictionary[url.path];
    if (!className.length) {
        className = HXClassNameFormPath(url.path);
        [self.classNameDictionary setValue:className forKey:url.path];
    }
    context.controllerIdentifier = controllerIdentifier ? controllerIdentifier : className;
    [self.targetURLDictionary setValue:[NSDate date] forKey:absoluteString];
    if (routeRecode) {
        BOOL jump = routeRecode.handler(request);
        if (!jump) {
            self.reocde404.handler(request);
        }
        return jump;
    } else if (!routeRecode && failure && self.reocde404) {
        return self.reocde404.handler(request);
    }
    return NO;
}


#pragma mark  路由启动和配置 

- (void)hx_startRouter
{
    [self configRouter];
}

- (void)configRouter
{
    self.alreadyConfigRouter = YES;
    [[HXURLRouter sharedRouter] hx_addRouterWithComplete:^BOOL(HXRouteRequest *request) {
        BOOL handle = NO;
        NSString * classPath = [HXURLRouter sharedRouter].classNameDictionary[request.originalURL.path];
        if (!classPath) {
            classPath = HXClassNameFormPath(request.originalURL.path);
        }
        UIViewController * vc = nil;
        if (request.context.loadFromStoryboard) {
            vc = [UIViewController hx_loadFromStoryboard:request.context.storyboard
                                              identifier:request.context.controllerIdentifier];
            if (!vc) {
                request.errorReason = UIViewController.loadErrorReason;
            }
        } else {
            if (classPath) {
                Class class = NSClassFromString(classPath);
                if (class != NULL) {
                    vc = (UIViewController *)[[class alloc] init];
                } else {
                    request.errorReason = [NSString stringWithFormat:@"could't init a class with %@", classPath];
                }
            }
        }
        if (vc) {
            handle = YES;
            if ([vc respondsToSelector:@selector(HX_routeHandle:)]) {
                [vc HX_routeHandle:request];
            }
            
            if (request.context.transitions == HXControllerTransitionsPush) {
                UIViewController * current = HXCurrentViewController();
                UINavigationController *nav = current.navigationController;
                vc.hidesBottomBarWhenPushed = nav.viewControllers.count >= 1;
                [nav pushViewController:vc animated:request.context.animation];
            } else if (request.context.transitions == HXControllerTransitionsPresent){
                UINavigationController * baseNavi = [[UINavigationController alloc] initWithRootViewController:vc];
                [HXRootViewController() presentViewController:baseNavi
                                                     animated:request.context.animation
                                                   completion:nil];
            }
        }
        return handle;
    }];
}

- (void)configErrorRouter
{
    [self hx_add404FailureWithHandler:^BOOL(HXRouteRequest *request) {
        NSString * message = [NSString stringWithFormat:@"Failed open->%@\n Reason->%@", request.originalURL.absoluteString, request.errorReason];
        if (!self.alreadyConfigRouter) {
            message = @"must to called selector hx_startRouter first";
        }
        if (@available(iOS 9.0, *)) {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                            message:message
                                                                     preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:sure];
            [HXRootViewController() presentViewController:alert animated:YES completion:nil];
        } else {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil
                                                             message:message
                                                            delegate:nil
                                                   cancelButtonTitle:@"确定"
                                                   otherButtonTitles:nil, nil];
            [alert show];
        }
        return NO;
    }];
}


@end

