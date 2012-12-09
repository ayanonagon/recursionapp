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
@property CGMutablePathRef linePath;
@property CABasicAnimation *pathAnimation;
@property CGPoint p1;
@property CGPoint p2;
@property CGPoint p3;
@property NSArray *children;
@property int depth;
@end

@implementation AORSierpinski

- (id)initWithP1:(CGPoint)p1 p2:(CGPoint)p2 p3:(CGPoint)p3
{
    self = [super init];
    if (self) {
        self.p1 = p1;
        self.p2 = p2;
        self.p3 = p3;
        self.depth = 5;
        [self defineShapePath];
        [self defineShapeLayer];
        [self defineShapeAnimation];
        //[self defineChildren];
    }
    return self;
}

- (id)initWithP1:(CGPoint)p1 p2:(CGPoint)p2 p3:(CGPoint)p3 depth:(int)depth
{
    self = [super init];
    if (self) {
        self.p1 = p1;
        self.p2 = p2;
        self.p3 = p3;
        self.depth = depth;
        [self defineShapePath];
        [self defineShapeLayer];
        [self defineShapeAnimation];
//        if (self.depth)
  //          [self defineChildren];
    }
    return self;
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
        [self.shapeLayer addSublayer:child.shapeLayer];
    }
}

-(void)defineShapeLayer
{
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.path = self.linePath;
	UIColor *strokeColor = [UIColor blackColor];
	self.shapeLayer.strokeColor = strokeColor.CGColor;
	self.shapeLayer.lineWidth = 2.0;
    UIColor *fillColor = [UIColor darkGrayColor];
    self.shapeLayer.fillColor = fillColor.CGColor;
	self.shapeLayer.fillRule = kCAFillRuleNonZero;
}

-(void)defineShapeAnimation
{
    self.pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    self.pathAnimation.duration = 3.0;
    self.pathAnimation.fromValue = @0.0;
    self.pathAnimation.toValue = @1.0;
    [self.pathAnimation setDelegate:self];
    [self.shapeLayer addAnimation:self.pathAnimation forKey:@"strokeEndAnimation"];
}

- (void)defineShapePath
{
    self.linePath = CGPathCreateMutable();
    CGPathMoveToPoint(self.linePath, NULL, self.p1.x, self.p1.y);
    CGPathAddLineToPoint(self.linePath, NULL, self.p2.x, self.p2.y);
    CGPathAddLineToPoint(self.linePath, NULL, self.p3.x, self.p3.y);
    CGPathAddLineToPoint(self.linePath, NULL, self.p1.x, self.p1.y);
    CGPathCloseSubpath(self.linePath);
}

-(void)startDrawing {

}

-(void)stopDrawing {
    
}

@end
