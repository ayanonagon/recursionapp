//
//  AOROneTouch.h
//  Recursion
//
//  Created by Elissa Wolf on 12/9/12.
//  Copyright (c) 2012 CIS 399 Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AORObject.h"

#define ONE_TOUCH_MAX_DEPTH 6

@interface AOROneTouch : AORObject <AORObjectProtocol>
-(id)init;
-(id)drawWithP1:(CGPoint)p1 bounds:(CGRect)bounds;
- (id)drawWithP1:(CGPoint)p1 bounds:(CGRect)bounds depth:(int)depth;
@end
