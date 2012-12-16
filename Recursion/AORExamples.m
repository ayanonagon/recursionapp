//
//  AORExamples.m
//  Recursion
//
//  Created by Mishal Awadah on 12/8/12.
//  Copyright (c) 2012 CIS 399 Project. All rights reserved.
//

#import "AORExamples.h"
#import "AORSierpinski.h"
#import "AORCarpet.h"
#import "AORLevy.h"
#import "AORStar.h"
#import "AOROneTouch.h"

#include <QuartzCore/QuartzCore.h>

@implementation AORExamples

+ (CALayer *)drawSierpinski
{
    return [[[[AORSierpinski alloc] init] drawWithP1:CGPointMake(600.0, 400.0) p2:CGPointMake(400.0, 400.0) p3:CGPointMake(200.0, 600.0)] layer];
}

+ (CALayer*)drawCarpet
{
    CGPoint A = CGPointMake(100.0, 100.0);
    CGPoint B = CGPointMake(100.0, 500.0);
    CGPoint C = CGPointMake(500.0, 500.0);
    CGPoint D = CGPointMake(500.0, 100.0);
}

+ (CALayer*)drawLevy
{
    return [[[[AORLevy alloc] init] drawWithP1:CGPointMake(300.0, 200.0) p2:CGPointMake(300.0, 500.0)] layer];
}

+ (CALayer *)drawStar
{
    CGPoint p0 = CGPointMake(500, 500);
    CGPoint p1 = CGPointMake(600, 500);
    CGPoint p2 = CGPointMake(625, 575);
    CGPoint p3 = CGPointMake(550, 625);
    CGPoint p4 = CGPointMake(475, 575);
    NSArray *points = [NSArray arrayWithObjects:
                       [NSValue valueWithCGPoint:p0],
                       [NSValue valueWithCGPoint:p1],
                       [NSValue valueWithCGPoint:p2],
                       [NSValue valueWithCGPoint:p3],
                       [NSValue valueWithCGPoint:p4],
                       nil];
    
    return [[[[AORStar alloc] init] drawWithPoints:points] layer];
}

+ (CALayer *)drawOneTouch
{
    CGRect bounds = CGRectMake(0.0, 0.0, 755.0, 1024.0);
    CGPoint p = CGPointMake(400, 200.0);
    return [[[[AOROneTouch alloc] init] drawWithP1:p bounds:bounds] layer];
}

@end
