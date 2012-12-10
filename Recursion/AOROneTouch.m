//
//  AOROneTouch.m
//  Recursion
//
//  Created by Elissa Wolf on 12/9/12.
//  Copyright (c) 2012 CIS 399 Project. All rights reserved.
//

#import "AOROneTouch.h"
#import <QuartzCore/QuartzCore.h>

@interface AOROneTouch ()
@property NSArray *lines;
@property CAAnimationGroup *lineAnimations;
@property CGPoint p1;
@property CGRect bounds;
@property NSArray *children;
@property int depth;
@property (atomic) BOOL animationStopped;
@end

@implementation AOROneTouch

#define MAX_DEPTH 5

- (id)initWithP1:(CGPoint)p1 bounds:(CGRect)bounds
{
    self = [super init];
    return [self initWithP1:p1 bounds:bounds depth:MAX_DEPTH];
}

- (id)initWithP1:(CGPoint)p1 bounds:(CGRect)bounds depth:(int)depth
{
    self = [super init];
    if (self) {
        self.p1 = p1;
        self.bounds = bounds;
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
    CGPoint p1 = CGPointMake((self.p1.x*self.p1.x)/self.bounds.size.width, self.p1.y + (((self.p1.y - self.bounds.origin.y)*(self.bounds.origin.y + self.bounds.size.height - self.p1.y))/self.bounds.size.height));
    CGRect bounds1 = CGRectMake(self.bounds.origin.x, self.p1.y, (self.p1.x - self.bounds.origin.x), (self.bounds.origin.y + self.bounds.size.height - self.p1.y));
    AOROneTouch *c1 = [[AOROneTouch alloc] initWithP1:p1 bounds:bounds1 depth:self.depth-1];
    self.children = [NSArray arrayWithObjects:c1, nil];
    for (AOROneTouch *child in self.children) {
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
    CGMutablePathRef line4 = CGPathCreateMutable();
    CGMutablePathRef line5 = CGPathCreateMutable();
    CGMutablePathRef line6 = CGPathCreateMutable();
    CGMutablePathRef line7 = CGPathCreateMutable();
    CGMutablePathRef line8 = CGPathCreateMutable();
    
    //top left square
    CGPathMoveToPoint(line1, NULL, self.bounds.origin.x, self.bounds.origin.y);
    CGPathAddLineToPoint(line1, NULL, self.p1.x, self.bounds.origin.y);
    
    CGPathMoveToPoint(line2, NULL, self.p1.x, self.bounds.origin.y);
    CGPathAddLineToPoint(line2, NULL, self.p1.x, self.p1.y);
    
    CGPathMoveToPoint(line3, NULL, self.p1.x, self.p1.y);
    CGPathAddLineToPoint(line3, NULL, self.bounds.origin.x, self.p1.y);
    
    CGPathMoveToPoint(line4, NULL, self.bounds.origin.x, self.p1.y);
    CGPathAddLineToPoint(line4, NULL, self.bounds.origin.x, self.bounds.origin.y);
    
    //bottom right square
    CGPathMoveToPoint(line5, NULL, self.p1.x, self.p1.y);
    CGPathAddLineToPoint(line5, NULL, (self.bounds.origin.x + self.bounds.size.width), self.p1.y);
    
    CGPathMoveToPoint(line6, NULL, (self.bounds.origin.x + self.bounds.size.width), self.p1.y);
    CGPathAddLineToPoint(line6, NULL, (self.bounds.origin.x + self.bounds.size.width), (self.bounds.origin.y + self.bounds.size.height));
    
    CGPathMoveToPoint(line7, NULL, (self.bounds.origin.x + self.bounds.size.width), (self.bounds.origin.y + self.bounds.size.height));
    CGPathAddLineToPoint(line7, NULL, self.p1.x, (self.bounds.origin.y + self.bounds.size.height));
    
    CGPathMoveToPoint(line8, NULL, self.p1.x, (self.bounds.origin.y + self.bounds.size.height));
    CGPathAddLineToPoint(line8, NULL, self.p1.x, self.p1.y);
    
    self.lines = [NSArray arrayWithObjects:
                  [NSValue valueWithPointer:line1],
                  [NSValue valueWithPointer:line2],
                  [NSValue valueWithPointer:line3],
                  [NSValue valueWithPointer:line4],
                  [NSValue valueWithPointer:line5],
                  [NSValue valueWithPointer:line6],
                  [NSValue valueWithPointer:line7],
                  [NSValue valueWithPointer:line8], nil];
    
}

-(void)startDrawing {
    
}

-(void)stopDrawing {
    
}

@end
