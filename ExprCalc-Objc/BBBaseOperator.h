//
//  BBBaseOperator.h
//  ExprCalc-Objc
//
//  Created by wangsw on 10/31/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBBaseObject.h"

@interface BBBaseOperator : NSObject

@property (strong, nonatomic) BBBaseObject *left;
@property (strong, nonatomic) BBBaseObject *right;

- (id)initWithHavingLeft:(BOOL)canHaveLeft;
- (int)priority;
- (BOOL)needLeft;
- (BBBaseObject *)result;
- (BOOL)canGiveLeft;

@end
