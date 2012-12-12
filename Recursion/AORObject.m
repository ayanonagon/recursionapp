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
    self.layer = [CAShapeLayer layer];
    self.paths = nil;
    [self defineShapePath];
    [self defineShapeLayer];
    [self defineTheme];
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
    if (self.animationStopped || !flag) {
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
    // We need to assign a new layer, because the old one will
    // have been faded out, and it contains the sublayers we will
    // resuse.. Actually, do we not create new ones?
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
    UIColor *strokeColor = [UIColor blackColor];
    switch (self.depth) {
        case 0:
        case 3:
        case 6:
        case 9:
            strokeColor = [UIColor purpleColor];
            break;
        case 1:
        case 4:
        case 7:
        case 10:
            strokeColor = [UIColor redColor];
            break;
        case 2:
        case 5:
        case 8:
        case 11:
            strokeColor = [UIColor brownColor];
            break;
        default:
            strokeColor = [UIColor blackColor];
            break;
    }
    
    UIColor *fillColor = [UIColor redColor];
    
    for (NSValue *lineWrapped in self.paths) {
        CGMutablePathRef line = [lineWrapped pointerValue];
        CAShapeLayer *pathLayer = [CAShapeLayer layer];
        pathLayer.path = line;
        pathLayer.strokeColor = strokeColor.CGColor;
        pathLayer.lineWidth = 1.0;
        pathLayer.fillColor = fillColor.CGColor;
        pathLayer.fillRule = kCAFillRuleNonZero;

        [self setAnimationForPathLayer:pathLayer];
        [self.layer addSublayer:pathLayer];
    }
    self.layer.fillColor = [[UIColor redColor] CGColor];
    self.layer.fillRule = kCAFillRuleNonZero;
}

- (void)setAnimationForPathLayer:(CAShapeLayer *)pathLayer
{
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 0.3;
    pathAnimation.fromValue = @0.0;
    pathAnimation.toValue = @1.0;
    [pathAnimation setDelegate:self];
    pathAnimation.autoreverses = NO;
    [pathLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
}

- (void)defineTheme
{
    // A theme is an array of colors that will be
    // applied to recursive levels
    
}

/* We need this to get rid of CG objects that are 
 * not automatically looked after by ARC.
 */
- (void)dealloc {
    NSLog(@"Deallocating AORObject.");
    for (NSValue *lineWrapped in self.paths) {
        CGMutablePathRef line = [lineWrapped pointerValue];
        CGPathRelease(line);
    }
    [self.layer removeFromSuperlayer];
    self.children = nil;
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
