//
//  AOROneTouch.h
//  Recursion
//
//  Created by Elissa Wolf on 12/9/12.
//  Copyright (c) 2012 CIS 399 Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AORObject.h"

@class CAShapeLayer;

@interface AOROneTouch : NSObject <AORObjectProtocol>

@property (strong, nonatomic) CALayer *layer;

-(id)initWithP1:(CGPoint)p1 bounds:(CGRect)bounds;
-(id)initWithP1:(CGPoint)p1 bounds:(CGRect)bounds depth:(int)depth;


@end
