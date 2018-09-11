//
//  HXURLContext.h
//  HXURLRouter
//
//  Created by LHX on 2017/1/17.
//  Copyright © 2017年 Udo. All rights reserved.
//

/*
 摘要:
 进行路由跳转时, 传给目的页面的上下文Model类, 用来封装数据或者block(或两者兼有), 主要行为:
 1.定义了目的页面的进场类型枚举(push, present)
 2.定义了目的页面回调源页面的block类型(用于反向的数据传递)
 3.封装一个id类型对象(正向传值), 回调block, 以及进场动画相关的属性
 说明: A -> B, A为源页面, B为目的页面
 */

#import <Foundation/Foundation.h>


/**
 进场类型
 
 - HXControllerTransitionsPush: 推出
 - HXControllerTransitionsPresent: 弹出
 */
typedef NS_ENUM(NSInteger, HXControllerTransitionsType){
    HXControllerTransitionsPush,
    HXControllerTransitionsPresent
};

/**
 目的页面回调源页面的block类型
 
 @param item 目的页面传递给源页面的数据对象
 */
typedef void(^HXContextBlock)(id item);

@interface HXURLContext : NSObject

/**
 上下文对象
 */
@property (nonatomic, strong) id obj;

/**
 传值block
 */
@property (nonatomic, copy) HXContextBlock callBack;

/**
 设置是否有进场动画
 */
@property (nonatomic, strong, readonly) HXURLContext * (^kAnimation)(BOOL nimation);

/**
 设置进场类型
 */
@property (nonatomic, strong, readonly) HXURLContext * (^kTransitions)(HXControllerTransitionsType transitions);

/**
 是否有进场动画 默认有动画
 */
@property (nonatomic, assign, readonly) BOOL animation;

/**
 进场类型 默认为 HX_ControllerTransitionsPush
 */
@property (nonatomic, assign, readonly) HXControllerTransitionsType transitions;

@property (nonatomic, assign) BOOL loadFromStoryboard;
@property (nonatomic, copy) NSString * storyboard;
@property (nonatomic, copy) NSString * controllerIdentifier;

@end



