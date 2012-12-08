//
//  AORSierpinski.m
//  Recursion
//
//  Created by Ayaka Nonaka on 12/7/12.
//  Copyright (c) 2012 CIS 399 Project. All rights reserved.
//

#import "AORSierpinski.h"
#import <QuartzCore/QuartzCore.h>

@interface AORSierpinski ()
@property (weak, nonatomic) CAShapeLayer *shapeLayer;
@property CGMutablePathRef linePath;
@end

@implementation AORSierpinski

-(id)initWithShapeLayer:(CAShapeLayer *)layer linePath:(CGMutablePathRef)path
{
    self = [super init];
    if (self) {
        self.shapeLayer = layer;
        self.linePath = path;
    }
    return self;
}

# pragma mark - The Magic

-(void)startAnimation
{
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 3.0;
    pathAnimation.fromValue = @0.0;
    pathAnimation.toValue = @1.0;
    [pathAnimation setDelegate:self];
    [self.shapeLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
}

-(void)setupPathWithPoint:(CGPoint)start endPoint:(CGPoint)end
{
    CGPathMoveToPoint(self.linePath, NULL, start.x, start.y);
    CGPathAddLineToPoint(self.linePath, NULL, end.x, end.y);
    
    CGPathCloseSubpath(self.linePath);
    [self startAnimation];
}

- (void)drawWithP1:(CGPoint)p1 p2:(CGPoint)p2 p3:(CGPoint)p3 depth:(int)depth
{
    CGPathMoveToPoint(self.linePath, NULL, p1.x, p1.y);
    CGPathAddLineToPoint(self.linePath, NULL, p2.x, p2.y);
    CGPathAddLineToPoint(self.linePath, NULL, p3.x, p3.y);
    CGPathAddLineToPoint(self.linePath, NULL, p1.x, p1.y);
    CGPathCloseSubpath(self.linePath);
    [self startAnimation];
    
    if (depth > 1) {
        CGPoint a = CGPointMake((p1.x + p3.x)/2, (p1.y + p3.y)/2);
        CGPoint b = CGPointMake((p3.x + p2.x)/2, (p2.y + p3.y)/2);
        CGPoint c = CGPointMake((p1.x + p2.x)/2, (p1.y + p2.y)/2);
        
        [self drawWithP1:a p2:b p3:p3 depth:depth-1];
        [self drawWithP1:p1 p2:c p3:a depth:depth-1];
        [self drawWithP1:c p2:p2 p3:b depth:depth-1];
    }
}

@end
