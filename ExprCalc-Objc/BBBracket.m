//
//  BBBracket.m
//  ExprCalc-Objc
//
//  Created by wangsw on 10/31/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBBracket.h"

static BOOL g_openBracketOperated = NO;

@interface BBOpenBracket ()

@property (nonatomic) BOOL placing;
@property (nonatomic) BOOL _runFunction;
@property (nonatomic) int _priority;

@end

@implementation BBOpenBracket

- (id)initWithHavingLeft:(BOOL)canHaveLeft {
    self = [super initWithHavingLeft:canHaveLeft];
    if (self) {
        self.placing = YES;
        
        if (canHaveLeft) {
            self._runFunction = YES;
            self._priority = 4000;
        } else {
            self._runFunction = NO;
            self._priority = 10000;
        }
    }
    return self;
}

- (int)priority {
    if (self.placing) {
        self.placing = self._runFunction && self.left == [BBBaseObject null];
        return self._priority;
    } else {
        return -100;
    }
}

- (BOOL)needLeft {
    return self._runFunction;
}

- (BBBaseObject *)result {
    g_openBracketOperated = YES;
    
    if (self._runFunction) {
        // TODO: Running Function Not Implemented
        return [BBBaseObject null];
    } else {
        return self.right;
    }
}

@end

@interface BBCloseBracket ()

@property (nonatomic) int _priority;

@end

@implementation BBCloseBracket

- (id)initWithHavingLeft:(BOOL)canHaveLeft {
    self = [super initWithHavingLeft:canHaveLeft];
    if (self) {
        self._priority = -110;
    }
    return self;
}

- (int)priority {
    if (g_openBracketOperated) {
        g_openBracketOperated = NO;
        self._priority = 10001;
    }
    return self._priority;
}

- (BOOL)needLeft {
    return YES;
}

- (BBBaseObject *)result {
    return self.left;
}

- (BOOL)canGiveLeft {
    return YES;
}

@end
