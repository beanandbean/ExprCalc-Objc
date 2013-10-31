//
//  BBBaseObject.h
//  ExprCalc-Objc
//
//  Created by wangsw on 10/31/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

@interface BBBaseObject : NSObject

@property (strong, nonatomic) NSString *identify;

+ (BBBaseObject *)null;

@end
