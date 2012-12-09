//
//  AORStar.h
//  Recursion
//
//  Created by Elissa Wolf on 12/8/12.
//  Copyright (c) 2012 CIS 399 Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CAShapeLayer;

@interface AORStar : NSObject
-(id)initWithShapeLayer:(CAShapeLayer *)layer linePath:(CGMutablePathRef)path;
- (void)drawWithPoints:(NSArray*)points depth:(int)depth;
@end
