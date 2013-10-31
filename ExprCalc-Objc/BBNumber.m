//
//  BBNumber.m
//  ExprCalc-Objc
//
//  Created by wangsw on 10/31/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBNumber.h"

@implementation BBNumber

- (id)initWithNumber:(double)number {
    self = [super init];
    if (self) {
        self.number = number;
    }
    return self;
}

@end
