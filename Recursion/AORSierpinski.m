//
//  AORSierpinski.m
//  Recursion
//
//  Created by Ayaka Nonaka on 12/7/12.
//  Copyright (c) 2012 CIS 399 Project. All rights reserved.
//

/**
 * By default, triangles will have a depth of 7, however,
 * ideally we would want to continue creating sub-shapes as
 * long as fingers are held down. Doing this dynamically is 
 * a bit complicated, but each AORSierpinski object would have
 * three children objects it calls the constructor and draw
 * on after it has done animating. It is the 'done animating' that is
 * difficult to figure out right now.
 *
 */

#import "AORSierpinski.h"
#import <QuartzCore/QuartzCore.h>

@interface AORSierpinski ()
@property NSArray *lines;
@property CAAnimationGroup *lineAnimations;
@property CGPoint p1, p2, p3;
@property NSArray *children;
@property int depth;
@property (atomic) BOOL animationStopped;
@end

@implementation AORSierpinski

#define MAX_DEPTH 5

- (id)initWithP1:(CGPoint)p1 p2:(CGPoint)p2 p3:(CGPoint)p3
{
    self = [super init];
    return [self initWithP1:p1 p2:p2 p3:p3 depth:MAX_DEPTH];
}

- (id)initWithP1:(CGPoint)p1 p2:(CGPoint)p2 p3:(CGPoint)p3 depth:(int)depth
{
    self = [super init];
    if (self) {
        self.p1 = p1;
        self.p2 = p2;
        self.p3 = p3;
        self.depth = depth;
        self.animationStopped = NO;
        [self defineShapePath];
        [self defineShapeLayer];
    }
    return self;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.animationStopped) {
        return;
    }
    self.animationStopped = YES;
    if (self.depth) {
        [self defineChildren];
    }

}

#pragma mark - The Magic

-(void)defineChildren
{
    CGPoint a = CGPointMake((self.p1.x + self.p3.x)/2, (self.p1.y + self.p3.y)/2);
    CGPoint b = CGPointMake((self.p3.x + self.p2.x)/2, (self.p2.y + self.p3.y)/2);
    CGPoint c = CGPointMake((self.p1.x + self.p2.x)/2, (self.p1.y + self.p2.y)/2);
    AORSierpinski *c1 = [[AORSierpinski alloc] initWithP1:a p2:b p3:self.p3 depth:self.depth-1];
    AORSierpinski *c2 = [[AORSierpinski alloc] initWithP1:self.p1 p2:c p3:a depth:self.depth-1];
    AORSierpinski *c3 = [[AORSierpinski alloc] initWithP1:c p2:self.p2 p3:b depth:self.depth-1];
    self.children = [NSArray arrayWithObjects:c1, c2, c3, nil];
    for (AORSierpinski *child in self.children) {
        [self.layer addSublayer:child.layer];
    }
}

-(void)defineShapeLayer
{
    self.layer = [CALayer layer];
    
    for (NSValue *lineWrapped in self.lines) {
        CGMutablePathRef line = [lineWrapped pointerValue];
        CAShapeLayer *lineLayer = [CAShapeLayer layer];
        lineLayer.path = line;
        UIColor *strokeColor = [UIColor blackColor];
        lineLayer.strokeColor = strokeColor.CGColor;
        lineLayer.lineWidth = 2.0;
        UIColor *fillColor = [UIColor darkGrayColor];
        lineLayer.fillColor = fillColor.CGColor;
        lineLayer.fillRule = kCAFillRuleNonZero;
        
        [self setAnimationForLineLayer:lineLayer];
        
        [self.layer addSublayer:lineLayer];
    }
    
	
}

-(void)setAnimationForLineLayer:(CAShapeLayer*) lineLayer
{
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 0.5;
    pathAnimation.fromValue = @0.0;
    pathAnimation.toValue = @1.0;
    [pathAnimation setDelegate:self];
    pathAnimation.autoreverses = NO;
    [lineLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
}

- (void)defineShapePath
{
    CGMutablePathRef line1 = CGPathCreateMutable();
    CGMutablePathRef line2 = CGPathCreateMutable();
    CGMutablePathRef line3 = CGPathCreateMutable();
    
    CGPathMoveToPoint(line1, NULL, self.p1.x, self.p1.y);
    CGPathAddLineToPoint(line1, NULL, self.p2.x, self.p2.y);
    //CGPathCloseSubpath(line1);
    
    CGPathMoveToPoint(line2, NULL, self.p2.x, self.p2.y);
    CGPathAddLineToPoint(line2, NULL, self.p3.x, self.p3.y);
    //CGPathCloseSubpath(line2);
    
    CGPathMoveToPoint(line3, NULL, self.p3.x, self.p3.y);
    CGPathAddLineToPoint(line3, NULL, self.p1.x, self.p1.y);
    //CGPathCloseSubpath(line3);
    
    self.lines = [NSArray arrayWithObjects:
                  [NSValue valueWithPointer:line1],
                  [NSValue valueWithPointer:line2],
                  [NSValue valueWithPointer:line3], nil];
}

-(void)startDrawing {

}

-(void)stopDrawing {
    
}

@end
