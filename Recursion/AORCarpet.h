//
//  AORCarpet.h
//  Recursion
//
//  Created by Elissa Wolf on 12/8/12.
//  Copyright (c) 2012 CIS 399 Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CAShapeLayer;

@interface AORCarpet : NSObject
-(id)initWithShapeLayer:(CAShapeLayer *)layer linePath:(CGMutablePathRef)path;
- (void)drawWithP1:(CGPoint)p1 p2:(CGPoint)p2 p3:(CGPoint)p3 p4:(CGPoint)p4 depth:(int)depth;

@end
