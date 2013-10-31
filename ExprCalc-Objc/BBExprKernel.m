//
//  BBExprKernel.m
//  ExprCalc-Objc
//
//  Created by wangsw on 10/31/13.
//  Copyright (c) 2013 beanandbean. All rights reserved.
//

#import "BBExprKernel.h"

#import "BBBaseOperator.h"
#import "BBPlusMinus.h"
#import "BBMultiply.h"
#import "BBDivide.h"
#import "BBBracket.h"

#import "BBBaseObject.h"
#import "BBNumber.h"

typedef enum {
    BBExprKernelBufferTypeNoBuffer,
    BBExprKernelBufferTypeBufferEnd,
    BBExprKernelBufferTypeIdentify,
    BBExprKernelBufferTypeNumber
} BBExprKernelBufferType;

static NSCharacterSet *g_numberSet;
static NSCharacterSet *g_identifySet;

@interface BBExprKernel ()

@property (strong, nonatomic) NSMutableString *buffer;
@property (nonatomic) BBExprKernelBufferType bufferType;

@property (strong, nonatomic) NSMutableArray *queue;

@end

@implementation BBExprKernel

+ (NSCharacterSet *)numberSet {
    if (!g_numberSet) {
        g_numberSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    }
    return g_numberSet;
}

+ (NSCharacterSet *)identifySet {
    if (!g_identifySet) {
        g_identifySet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ012356789_$"];
    }
    return g_identifySet;
}

- (void)endBuffer {
    BBBaseObject *constant;
    if (self.bufferType == BBExprKernelBufferTypeIdentify) {
        constant = [[BBBaseObject alloc] init];
        constant.identify = self.buffer;
    } else if (self.bufferType == BBExprKernelBufferTypeNumber) {
        BBNumber *number = [[BBNumber alloc] init];
        double value = self.buffer.doubleValue;
        number.number = value;
        constant = number;
    } else {
        return;
    }
    
    ((BBBaseOperator *)self.queue.lastObject).right = constant;
    self.buffer = [NSMutableString string];
    self.bufferType = BBExprKernelBufferTypeBufferEnd;
}

- (void)appendOperator:(Class)operatorClass {
    BOOL canHaveLeft = ((BBBaseOperator *)self.queue.lastObject).canGiveLeft;
    BBBaseOperator *operator = [[operatorClass alloc] initWithHavingLeft:canHaveLeft];
    
    while (operator.priority <= ((BBBaseOperator *)self.queue.lastObject).priority) {
        BBBaseObject *result = ((BBBaseOperator *)self.queue.lastObject).result;
        [self.queue removeLastObject];
        ((BBBaseOperator *)self.queue.lastObject).right = result;
    }
    
    if (operator.needLeft) {
        operator.left = ((BBBaseOperator *)self.queue.lastObject).right;
        ((BBBaseOperator *)self.queue.lastObject).right = [BBBaseObject null];
    }
    
    [self.queue addObject:operator];
}

- (double)evaluate:(NSString *)expression {
    self.buffer = [NSMutableString string];
    self.bufferType = BBExprKernelBufferTypeNoBuffer;
    
    BBBaseOperator *baseOperator = [[BBBaseOperator alloc] init];
    self.queue = [NSMutableArray arrayWithObject:baseOperator];
    
    for (int i = 0; i < expression.length; i++) {
        unichar ch = [expression characterAtIndex:i];
        if ([[BBExprKernel numberSet] characterIsMember:ch] && (self.bufferType == BBExprKernelBufferTypeNoBuffer || self.bufferType == BBExprKernelBufferTypeNumber)) {
            [self.buffer appendFormat:@"%c", ch];
            self.bufferType = BBExprKernelBufferTypeNumber;
        } else if ([[BBExprKernel identifySet] characterIsMember:ch] && (self.bufferType == BBExprKernelBufferTypeNoBuffer || self.bufferType == BBExprKernelBufferTypeIdentify)) {
            [self.buffer appendFormat:@"%c", ch];
            self.bufferType = BBExprKernelBufferTypeIdentify;
        } else {
            [self endBuffer];
            
            if ([[NSCharacterSet whitespaceCharacterSet] characterIsMember:ch]) {
                continue;
            }
            
            Class operatorClass;
            if (ch == '+') {
                operatorClass = [BBPlus class];
            } else if (ch == '-') {
                operatorClass = [BBMinus class];
            } else if (ch == '*') {
                operatorClass = [BBMultiply class];
            } else if (ch == '/') {
                operatorClass = [BBDivide class];
            } else if (ch == '(') {
                operatorClass = [BBOpenBracket class];
            } else if (ch == ')') {
                operatorClass = [BBCloseBracket class];
            } else {
                return 0.0;
            }
            [self appendOperator:operatorClass];
            
            self.bufferType = BBExprKernelBufferTypeNoBuffer;
        }
    }
    
    [self endBuffer];
    
    while (self.queue.lastObject != baseOperator) {
        BBBaseObject *result = ((BBBaseOperator *)self.queue.lastObject).result;
        [self.queue removeLastObject];
        ((BBBaseOperator *)self.queue.lastObject).right = result;
    }
    
    BBBaseObject *result = baseOperator.result;
    if (result.class == [BBNumber class]) {
        return ((BBNumber *)result).number;
    } else {
        return 0.0;
    }
}

@end
