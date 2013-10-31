//
//  BBMultiply.m
//  ExprCalc-Objc
//
//  Created by wangsw on 10/31/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBMultiply.h"

#import "BBBaseObject.h"
#import "BBNumber.h"

@implementation BBMultiply

- (int)priority {
    return 200;
}

- (BOOL)needLeft {
    return YES;
}

- (BBBaseObject *)result {
    if (self.left.class == [BBNumber class] && self.right.class == [BBNumber class]) {
        double left = ((BBNumber *)self.left).number;
        double right = ((BBNumber *)self.right).number;
        double result = left * right;
        return [[BBNumber alloc] initWithNumber:result];
    } else {
        return [BBBaseObject null];
    }
}

@end
