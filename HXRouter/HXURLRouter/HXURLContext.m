//
//  HXURLContext.m
//  HXURLRouter
//
//  Created by LHX on 2017/1/17.
//  Copyright © 2017年 Udo. All rights reserved.
//

#import "HXURLContext.h"

@implementation HXURLContext

- (instancetype)init
{
    self = [super init];
    if (self) {
        _animation = YES;
        _transitions = HXControllerTransitionsPush;
    }
    return self;
}

- (HXURLContext *(^)(BOOL))kAnimation
{
    return ^(BOOL animation) {
        self->_animation = animation;
        return self;
    };
}

- (HXURLContext *(^)(HXControllerTransitionsType))kTransitions
{
    return ^(HXControllerTransitionsType transitions) {
        self->_transitions = transitions;
        return self;
    };
}

@end

