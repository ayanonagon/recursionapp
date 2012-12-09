//
//  AORCarpet.m
//  Recursion
//
//  Created by Elissa Wolf on 12/8/12.
//  Copyright (c) 2012 CIS 399 Project. All rights reserved.
//

#import "AORCarpet.h"
#import <QuartzCore/QuartzCore.h>

@interface AORCarpet ()
@property (weak, nonatomic) CAShapeLayer *shapeLayer;
@property CGMutablePathRef linePath;
@end

@implementation AORCarpet

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

- (void)drawWithP1:(CGPoint)p1 p2:(CGPoint)p2 p3:(CGPoint)p3 p4:(CGPoint)p4 depth:(int)depth
{
    CGPoint A = CGPointMake(p1.x+((p2.x-p1.x)/3), p1.y+((p2.y-p1.y)/3));
    CGPoint B = CGPointMake(p1.x+((p2.x-p1.x)*2/3), p1.y+((p2.y-p1.y)*2/3));
    CGPoint C = CGPointMake(p1.x+((p4.x-p1.x)/3), p1.y+((p4.y-p1.y)/3));
    CGPoint G = CGPointMake(p1.x+((p4.x-p1.x)*2/3), p1.y+((p4.y-p1.y)*2/3));
    CGPoint F = CGPointMake(p2.x+((p3.x-p2.x)/3), p2.y+((p3.y-p2.y)/3));
    CGPoint J = CGPointMake(p2.x+((p3.x-p2.x)*2/3), p2.y+((p3.y-p2.y)*2/3));
    CGPoint K = CGPointMake(p4.x+((p3.x-p4.x)/3), p4.y+((p3.y-p4.y)/3));
    CGPoint L = CGPointMake(p4.x+((p3.x-p4.x)*2/3), p4.y+((p3.y-p4.y)*2/3));
    // Points D and H interpolate between A and K
    CGPoint D = CGPointMake(A.x+((K.x-A.x)/3), A.y+((K.y-A.y)/3));
    CGPoint H = CGPointMake(A.x+((K.x-A.x)*2/3), A.y+((K.y-A.y)*2/3));
    // Points E and I interpolate between B and L
    CGPoint E = CGPointMake(B.x+((L.x-B.x)/3), B.y+((L.y-B.y)/3));
    CGPoint I = CGPointMake(B.x+((L.x-B.x)*2/3), B.y+((L.y-B.y)*2/3));
    
    CGPathMoveToPoint(self.linePath, NULL, D.x, D.y);
    CGPathAddLineToPoint(self.linePath, NULL, E.x, E.y);
    CGPathAddLineToPoint(self.linePath, NULL, I.x, I.y);
    CGPathAddLineToPoint(self.linePath, NULL, H.x, H.y);
    CGPathAddLineToPoint(self.linePath, NULL, D.x, D.y);
    CGPathCloseSubpath(self.linePath);
    [self startAnimation];
    
    if (depth > 1){
        [self drawWithP1:p1 p2:A p3:D p4:C depth:depth-1];
        [self drawWithP1:A p2:B p3:E p4:D depth:depth-1];
        [self drawWithP1:B p2:p2 p3:F p4:E depth:depth-1];
        [self drawWithP1:C p2:D p3:H p4:G depth:depth-1];
        [self drawWithP1:E p2:F p3:J p4:I depth:depth-1];
        [self drawWithP1:G p2:H p3:K p4:p4 depth:depth-1];
        [self drawWithP1:H p2:I p3:L p4:K depth:depth-1];
        [self drawWithP1:I p2:J p3:p3 p4:L depth:depth-1];
    }
    
   
}


@end
