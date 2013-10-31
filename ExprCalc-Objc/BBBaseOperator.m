//
//  BBBaseOperator.m
//  ExprCalc-Objc
//
//  Created by wangsw on 10/31/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBBaseOperator.h"

@implementation BBBaseOperator

- (id)init {
    self = [self initWithHavingLeft:NO];
    return self;
}

- (id)initWithHavingLeft:(BOOL)canHaveLeft {
    self = [super init];
    if (self) {
        self.left = [BBBaseObject null];
        self.right = [BBBaseObject null];
    }
    return self;
}

- (int)priority {
    return 0;
}

- (BOOL)needLeft {
    return NO;
}

- (BBBaseObject *)result {
    return self.right;
}

- (BOOL)canGiveLeft {
    return self.right != [BBBaseObject null];
}

@end
