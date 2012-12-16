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
 */
- (id)configureShape
{
    self.animationStopped = NO;
    // Make a new layer, the old one is degrading.
    self.layer = [CAShapeLayer layer];
    // Destroy old paths first; no need if using bezier
    [self destroyPaths];
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
    if (self.animationStopped || !flag) {
        return;
    }
    self.animationStopped = YES;
    if (self.depth) {
        [self defineChildren];
    }
}

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
 * Color of lines for this object
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

- (void)dealloc
{
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
- (void)defineChildren
{

}

/**
 * Must be overridden!
 */
- (void)defineShapePath
{
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

void augmentPath(CGMutablePathRef path, CGPoint p1, CGPoint p2)
{
    CGPathMoveToPoint(path, NULL, p1.x, p1.y);
    CGPathAddLineToPoint(path, NULL, p2.x, p2.y);
}
