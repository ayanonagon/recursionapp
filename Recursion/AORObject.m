//
//  AORObject.m
//  Recursion
//
//  Created by Mishal Awadah on 12/9/12.
//  Copyright (c) 2012 CIS 399 Project. All rights reserved.
//

#import "AORObject.h"

@implementation AORObject

- (id)init
{
    self = [super init];
    if (self) {
        self.paths = nil;
        self.children = nil;
        self.layer = nil;
        self.theme = [NSArray arrayWithObjects:[UIColor blueColor], nil];
        self.path = nil;
    }
    return self;
}

/**
 * A new shape configuration means new paths, and a new layer.
 * Thus, this method must destroy the old paths (responsibly).
 */
- (id)configureShape
{
    self.animationStopped = NO;
    self.layer = [CAShapeLayer layer];
    [self destroyPaths];
    [self defineShapePath];
    [self defineShapeLayer];
    return self;
}

/**
 * The recursive call; creates child objects.
 * Does not create any more children after depth limit.
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
}

/**
 * Responsibly destroys C path objects from memory.
 */
- (void)destroyPaths
{
    for (NSValue *lineWrapped in self.paths) {
        CGMutablePathRef path = [lineWrapped pointerValue];
        CGPathRelease(path);
    }
    self.paths = nil;
    CGPathRelease(self.path);
    self.path = nil;
}

/**
 * Defines the colors of lines for this object, but primarily, builds
 * and sets the animation of the path from all the sub-paths.
 */
- (void)defineShapeLayer
{
    UIColor *strokeColor = [UIColor blackColor];
    int colorIndex = self.depth % [self.theme count];
    strokeColor = [self.theme objectAtIndex:colorIndex];

    UIColor *fillColor = [UIColor redColor];
    self.path = CGPathCreateMutable();

    for (NSValue *lineWrapped in self.paths) {
        CGMutablePathRef line = [lineWrapped pointerValue];
        CGPathAddPath(self.path, NULL, line);
    }
    self.layer.path = self.path;
    self.layer.strokeColor = strokeColor.CGColor;
    self.layer.lineWidth = 1.0;
    self.layer.fillColor = fillColor.CGColor;
    self.layer.fillRule = kCAFillRuleNonZero;
    [self setAnimationForPathLayer:self.layer];
}

/**
 * Given a path layer, sets its animation to the correct value.
 */
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

/// Garbage collection for C objects not taken care of by Obj-C ARC.
- (void)dealloc
{
    for (NSValue *lineWrapped in self.paths) {
        CGMutablePathRef line = [lineWrapped pointerValue];
        CGPathRelease(line);
    }
    [self.layer removeFromSuperlayer];
    self.children = nil;
}

/// Overridden by subclass
- (void)defineChildren
{

}

/// Overridden by subclass
- (void)defineShapePath
{
    NSLog(@"The wrong shape path");
}

@end

/**
 * Creates a pathref that draws single line from p1 to p2.
 */
CGMutablePathRef createPathFromPoints(CGPoint p1, CGPoint p2)
{
    CGMutablePathRef line = CGPathCreateMutable();
    CGPathMoveToPoint(line, NULL, p1.x, p1.y);
    CGPathAddLineToPoint(line, NULL, p2.x, p2.y);
    return line;
}
