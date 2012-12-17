//
//  AORMinkowski.h
//  Recursion
//
//  Created by Elissa Wolf on 12/17/12.
//  Copyright (c) 2012 CIS 399 Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AORObject.h"

#define MINKOWSKI_MAX_DEPTH 4

@interface AORMinkowski : AORObject <AORObjectProtocol>
-(id)init;
- (id)drawWithP1:(CGPoint)p1 p2:(CGPoint)p2;
- (id)drawWithP1:(CGPoint)p1 p2:(CGPoint)p2 depth:(int)depth;
@end
