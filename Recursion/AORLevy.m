//
//  AORLevy.m
//  Recursion
//
//  Created by Elissa Wolf on 12/8/12.
//  Copyright (c) 2012 CIS 399 Project. All rights reserved.
//

#import "AORLevy.h"
#import <QuartzCore/QuartzCore.h>

@interface AORLevy ()
@property (weak, nonatomic) CAShapeLayer *shapeLayer;
@property CGMutablePathRef linePath;
@end

@implementation AORLevy

-(id)initWithShapeLayer:(CAShapeLayer *)layer linePath:(CGMutablePathRef)path
{
    self = [super init];
    if (self) {
        self.shapeLayer = layer;
        self.linePath = path;
    }
    return self;
}

#pragma mark - The Magic

-(void)startAnimation
{
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 3.0;
    pathAnimation.fromValue = @0.0;
    pathAnimation.toValue = @1.0;
    [pathAnimation setDelegate:self];
    [self.shapeLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
}

- (void)drawWithP1:(CGPoint)p1 p2:(CGPoint)p2 depth:(int)depth
{
    CGFloat dist = sqrt(powf((p1.x+p2.x),2) + powf((p1.y+p2.y), 2));
    CGFloat xdir = p2.x-p1.x;
    CGFloat ydir = p2.y-p1.y;
    CGFloat perpx = -ydir/2;
    CGFloat perpy = xdir/2;
    CGPoint mid = CGPointMake((p1.x+p2.x)/2, (p1.y+p2.y)/2);
    CGPoint newPoint = CGPointMake(mid.x+perpx, mid.y+perpy);
    
    if (depth == 1){
    CGPathMoveToPoint(self.linePath, NULL, p1.x, p1.y);
    CGPathAddLineToPoint(self.linePath, NULL, newPoint.x, newPoint.y);
    CGPathAddLineToPoint(self.linePath, NULL, p2.x, p2.y);
    //CGPathCloseSubpath(self.linePath);
    [self startAnimation];
    }
    
    else {
        [self drawWithP1:p1 p2:newPoint depth:depth-1];
        [self drawWithP1:newPoint p2:p2 depth:depth-1];
    }
    
    
}


@end
