//
//  AORObject.h
//  Recursion
//
//  Created by Mishal Awadah on 12/9/12.
//  Copyright (c) 2012 CIS 399 Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@protocol AORObject <NSObject>


/* Defines children and their behavior for recursive animation/drawing */
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;

/* How to draw the shape */
- (void)defineShapePath;

- (void)defineChildren;

- (void)defineShapeLayer;

- (void)setAnimationForLineLayer:(CAShapeLayer *) lineLayer;

@end
