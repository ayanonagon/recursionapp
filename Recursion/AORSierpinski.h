//
//  AORSierpinski.h
//  Recursion
//
//  Created by Ayaka Nonaka on 12/7/12.
//  Copyright (c) 2012 CIS 399 Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CAShapeLayer;

@interface AORSierpinski : NSObject
-(id)initWithShapeLayer:(CAShapeLayer *)layer linePath:(CGMutablePathRef)path;
- (void)drawWithP1:(CGPoint)p1 p2:(CGPoint)p2 p3:(CGPoint)p3 depth:(int)depth;
@end

