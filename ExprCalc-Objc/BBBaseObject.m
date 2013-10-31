//
//  BBBaseObject.m
//  ExprCalc-Objc
//
//  Created by wangsw on 10/31/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBBaseObject.h"

static BBBaseObject *g_null;

@implementation BBBaseObject

+ (BBBaseObject *)null {
    if (!g_null) {
        g_null = [[BBBaseObject alloc] init];
    }
    return g_null;
}

@end
