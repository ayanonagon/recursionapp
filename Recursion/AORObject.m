//
//  AORObject.m
//  Recursion
//
//  Created by Mishal Awadah on 12/9/12.
//  Copyright (c) 2012 CIS 399 Project. All rights reserved.
//

#import "AORObject.h"

@implementation AORObject

- (id)configureShape
{
    self.animationStopped = NO;
    self.layer = [CALayer layer];
    self.paths = nil;
    [self defineShapePath];
    [self defineShapeLayer];
    return self;
}

/**
 * The recursive call; creates child objects.
 *
 * The finished flag to tell if we continue, then query
 * the animation object for the key
 */
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.animationStopped) {
        return;
    }
    self.animationStopped = YES;
    if (self.depth) {
        [self defineChildren];
    }
    //[self destroyPaths];
}

// Why should they be destroyed? Can't I reuse them?
// The problem is, those with high depth won't be re-used as often.
// So, we look at the depth, and delete those with a larger than threshold
// depth.
- (void)destroyPaths
{
    for (NSValue *lineWrapped in self.paths) {
        CGMutablePathRef path = [lineWrapped pointerValue];
        CGPathRelease(path);
    }
    self.paths = nil;
    [self.layer removeAllAnimations];
}

/**
 * Color of lines for this object
 */
- (void)defineShapeLayer
{
    for (NSValue *lineWrapped in self.paths) {
        CGMutablePathRef line = [lineWrapped pointerValue];
        CAShapeLayer *pathLayer = [CAShapeLayer layer];
        pathLayer.path = line;
        UIColor *strokeColor = [UIColor blackColor];
        pathLayer.strokeColor = strokeColor.CGColor;
        pathLayer.lineWidth = 1.0;
        UIColor *fillColor = [UIColor darkGrayColor];
        pathLayer.fillColor = fillColor.CGColor;
        pathLayer.fillRule = kCAFillRuleNonZero;

        [self setAnimationForPathLayer:pathLayer];
        [self.layer addSublayer:pathLayer];
    }
}

- (void)setAnimationForPathLayer:(CAShapeLayer *)pathLayer
{
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 0.5;
    pathAnimation.fromValue = @0.0;
    pathAnimation.toValue = @1.0;
    [pathAnimation setDelegate:self];
    pathAnimation.autoreverses = NO;
    [pathLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
}

/**
 * Must be overridden!
 */
- (void)defineChildren {

}

/**
 * Must be overridden!
 */
- (void)defineShapePath {
    NSLog(@"The wrong shape path");
}

@end

CGMutablePathRef createPathFromPoints(CGPoint p1, CGPoint p2)
{
    CGMutablePathRef line = CGPathCreateMutable();
    CGPathMoveToPoint(line, NULL, p1.x, p1.y);
    CGPathAddLineToPoint(line, NULL, p2.x, p2.y);
    return line;
}

void augmentPath(CGMutablePathRef path, CGPoint p1, CGPoint p2) {
    // Need to clear path
    CGPathMoveToPoint(path, NULL, p1.x, p1.y);
    CGPathAddLineToPoint(path, NULL, p2.x, p2.y);
}
