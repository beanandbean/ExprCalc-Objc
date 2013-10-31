//
//  BBNumber.h
//  ExprCalc-Objc
//
//  Created by wangsw on 10/31/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBBaseObject.h"

@interface BBNumber : BBBaseObject

@property (nonatomic) double number;

- (id)initWithNumber:(double)number;

@end
