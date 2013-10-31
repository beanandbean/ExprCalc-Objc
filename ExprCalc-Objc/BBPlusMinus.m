//
//  BBPlusMinus.m
//  ExprCalc-Objc
//
//  Created by wangsw on 10/31/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBPlusMinus.h"

#import "BBBaseObject.h"
#import "BBNumber.h"

static int g_signPriority = 1000;

@interface BBPlus ()

@property (nonatomic) BOOL _needLeft;
@property (nonatomic) int _priority;

@end

@implementation BBPlus

- (id)initWithHavingLeft:(BOOL)canHaveLeft {
    self = [super initWithHavingLeft:canHaveLeft];
    if (self) {
        self._needLeft = canHaveLeft;
        if (canHaveLeft) {
            self._priority = 100;
        } else {
            self._priority = g_signPriority;
            g_signPriority++;
        }
    }
    return self;
}

- (int)priority {
    return self._priority;
}

- (BOOL)needLeft {
    return self._needLeft;
}

- (BBBaseObject *)result {
    if (self._needLeft) {
        if (self.left.class == [BBNumber class] && self.right.class == [BBNumber class]) {
            double left = ((BBNumber *)self.left).number;
            double right = ((BBNumber *)self.right).number;
            double result = left + right;
            return [[BBNumber alloc] initWithNumber:result];
        } else {
            return [BBBaseObject null];
        }
    } else {
        g_signPriority = 1000;
        if (self.right.class == [BBNumber class]) {
            return self.right;
        } else {
            return [BBBaseObject null];
        }
    }
}

@end

@interface BBMinus ()

@property (nonatomic) BOOL _needLeft;
@property (nonatomic) int _priority;

@end

@implementation BBMinus

- (id)initWithHavingLeft:(BOOL)canHaveLeft {
    self = [super initWithHavingLeft:canHaveLeft];
    if (self) {
        self._needLeft = canHaveLeft;
        if (canHaveLeft) {
            self._priority = 100;
        } else {
            self._priority = g_signPriority;
            g_signPriority++;
        }
    }
    return self;
}

- (int)priority {
    return self._priority;
}

- (BOOL)needLeft {
    return self._needLeft;
}

- (BBBaseObject *)result {
    if (self._needLeft) {
        if (self.left.class == [BBNumber class] && self.right.class == [BBNumber class]) {
            double left = ((BBNumber *)self.left).number;
            double right = ((BBNumber *)self.right).number;
            double result = left - right;
            return [[BBNumber alloc] initWithNumber:result];
        } else {
            return [BBBaseObject null];
        }
    } else {
        g_signPriority = 1000;
        if (self.right.class == [BBNumber class]) {
            double right = ((BBNumber *)self.right).number;
            return [[BBNumber alloc] initWithNumber:-right];
        } else {
            return [BBBaseObject null];
        }
    }
}

@end
