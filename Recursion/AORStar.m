//
//  AORStar.m
//  Recursion
//
//  Created by Elissa Wolf on 12/8/12.
//  Copyright (c) 2012 CIS 399 Project. All rights reserved.
//

#import "AORStar.h"
#import <QuartzCore/QuartzCore.h>

@interface AORStar ()
@property (weak, nonatomic) CAShapeLayer *shapeLayer;
@property CGMutablePathRef linePath;
@end

@implementation AORStar

-(id)initWithShapeLayer:(CAShapeLayer *)layer linePath:(CGMutablePathRef)path
{
    self = [super init];
    if (self) {
        self.shapeLayer = layer;
        self.linePath = path;
    }
    return self;
}

-(void)startAnimation
{
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 10.0;
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

- (void)drawWithPoints:(NSArray *)points depth:(int)depth
{
    NSMutableArray *newPoints = [NSMutableArray array];
    NSValue *val = [points objectAtIndex:0];
    CGPoint start = [val CGPointValue];
    CGPathMoveToPoint(self.linePath, NULL, start.x, start.y);
    for(int i = 0; i < 5; i++){
        NSValue *val;
        CGPoint p1, p1co, p2, p2co;
        
        val = points[i];
        p1 = [val CGPointValue];
        if (i == 0){
            val = points[4];
            p1co = [val CGPointValue];
        }
        else {
            val = points[i-1];
            p1co = [val CGPointValue];
        }
        if (i==4){
            val = points[0];
            p2 = [val CGPointValue];
            val = points[1];
            p2co = [val CGPointValue];
        }
        else {
            val = points[i+1];
            p2 = [val CGPointValue];
        }
        if (i==3) {
            val = points[0];
            p2co = [val CGPointValue];
        }
        else if (i!=4){
            val = points[i+2];
            p2co = [val CGPointValue];
        }
        
        CGFloat ax = p1.x - p1co.x;
        CGFloat ay = p1.y - p1co.y;
        CGFloat bx = p2.x - p2co.x;
        CGFloat by = p2.y - p2co.y;
        
        CGFloat s = ((p2co.y*ax) - (p1co.y*ax) - (p2co.x*ay) + (p1co.x*ay)) / ((bx*ay) - (by*ax));
        
        CGPoint intersect = CGPointMake(p2co.x + (s * bx), p2co.y + (s * by));
        NSValue *v = [NSValue valueWithCGPoint:intersect];
        [newPoints insertObject:v atIndex:i];
        
        CGPathAddLineToPoint(self.linePath, NULL, intersect.x, intersect.y);
        CGPathAddLineToPoint(self.linePath, NULL, p2.x, p2.y);
        
    }
    
    CGPathCloseSubpath(self.linePath);
    [self startAnimation];
    
    if (depth > 1){
        [self drawWithPoints:newPoints depth:depth-1];
    
    }
    
}



@end
