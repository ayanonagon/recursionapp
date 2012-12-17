//
//  AORPentaflake.m
//  Recursion
//
//  Created by Elissa Wolf on 12/8/12.
//  Copyright (c) 2012 CIS 399 Project. All rights reserved.
//

#import "AORPentaflake.h"
#import <QuartzCore/QuartzCore.h>

@interface AORPentaflake ()
@property NSArray *points;
@end

@implementation AORPentaflake

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id)drawWithPoints:(NSArray *)points
{
    return [self drawWithPoints:points depth:PENTAFLAKE_MAX_DEPTH];
}

- (id)drawWithPoints:(NSArray *)points depth:(int)depth
{
    self.points = points;
    self.depth = depth;
    [self configureShape];
    return self;
}


- (void)defineShapePath
{
    
    CGPoint p0 = [[self.points objectAtIndex:0] CGPointValue];
    CGPoint p1 = [[self.points objectAtIndex:1] CGPointValue];
    CGPoint p2 = [[self.points objectAtIndex:2] CGPointValue];
    CGPoint p3 = [[self.points objectAtIndex:3] CGPointValue];
    CGPoint p4 = [[self.points objectAtIndex:4] CGPointValue];
    
    CGMutablePathRef path0 = CGPathCreateMutable();
    CGPathMoveToPoint(path0, NULL, p0.x, p0.y);
    CGPathAddLineToPoint(path0, NULL, p1.x, p1.y);
    
    CGMutablePathRef path1 = CGPathCreateMutable();
    CGPathMoveToPoint(path1, NULL, p1.x, p1.y);
    CGPathAddLineToPoint(path1, NULL, p2.x, p2.y);
    
    CGMutablePathRef path2 = CGPathCreateMutable();
    CGPathMoveToPoint(path2, NULL, p2.x, p2.y);
    CGPathAddLineToPoint(path2, NULL, p3.x, p3.y);
    
    CGMutablePathRef path3 = CGPathCreateMutable();
    CGPathMoveToPoint(path3, NULL, p3.x, p3.y);
    CGPathAddLineToPoint(path3, NULL, p4.x, p4.y);
    
    CGMutablePathRef path4 = CGPathCreateMutable();
    CGPathMoveToPoint(path4, NULL, p4.x, p4.y);
    CGPathAddLineToPoint(path4, NULL, p0.x, p0.y);
    
    self.paths = [NSArray arrayWithObjects:
                  [NSValue valueWithPointer:path0],
                  [NSValue valueWithPointer:path1],
                  [NSValue valueWithPointer:path2],
                  [NSValue valueWithPointer:path3],
                  [NSValue valueWithPointer:path4],
                  nil];

}

- (void)defineChildren
{
    CGPoint p0 = [[self.points objectAtIndex:0] CGPointValue];
    CGPoint p1 = [[self.points objectAtIndex:1] CGPointValue];
    CGPoint p2 = [[self.points objectAtIndex:2] CGPointValue];
    CGPoint p3 = [[self.points objectAtIndex:3] CGPointValue];
    CGPoint p4 = [[self.points objectAtIndex:4] CGPointValue];
    
    CGPoint mid01 = CGPointMake((p0.x+p1.x)/2, (p0.y+p1.y)/2);
    CGPoint mid12 = CGPointMake((p1.x+p2.x)/2, (p1.y+p2.y)/2);
    CGPoint mid23 = CGPointMake((p2.x+p3.x)/2, (p2.y+p3.y)/2);
    CGPoint mid34 = CGPointMake((p3.x+p4.x)/2, (p3.y+p4.y)/2);
    CGPoint mid40 = CGPointMake((p4.x+p0.x)/2, (p4.y+p0.y)/2);
    
    CGPoint A = CGPointMake((p1.x + (mid34.x-p1.x)*.75), (p1.y + (mid34.y-p1.y)*.75));
    CGPoint B = CGPointMake((p2.x + (mid40.x-p2.x)*.75), (p2.y + (mid40.y-p2.y)*.75));
    CGPoint C = CGPointMake((p3.x + (mid01.x-p3.x)*.75), (p3.y + (mid01.y-p3.y)*.75));
    CGPoint D = CGPointMake((p4.x + (mid12.x-p4.x)*.75), (p4.y + (mid12.y-p4.y)*.75));
    CGPoint E = CGPointMake((p0.x + (mid23.x-p0.x)*.75), (p0.y + (mid23.y-p0.y)*.75));
    
    CGPoint F = CGPointMake((p1.x + (p2.x-p1.x)*.4), (p1.y + (p2.y-p1.y)*.4));
    CGPoint G = CGPointMake((p1.x + (p2.x-p1.x)*.6), (p1.y + (p2.y-p1.y)*.6));
    
    CGPoint H = CGPointMake((p2.x + (p3.x-p2.x)*.4), (p2.y + (p3.y-p2.y)*.4));
    CGPoint I = CGPointMake((p2.x + (p3.x-p2.x)*.6), (p2.y + (p3.y-p2.y)*.6));
    
    CGPoint J = CGPointMake((p3.x + (p4.x-p3.x)*.4), (p3.y + (p4.y-p3.y)*.4));
    CGPoint K = CGPointMake((p3.x + (p4.x-p3.x)*.6), (p3.y + (p4.y-p3.y)*.6));
    
    CGPoint L = CGPointMake((p4.x + (p0.x-p4.x)*.4), (p4.y + (p0.y-p4.y)*.4));
    CGPoint M = CGPointMake((p4.x + (p0.x-p4.x)*.6), (p4.y + (p0.y-p4.y)*.6));
    
    CGPoint N = CGPointMake((p0.x + (p1.x-p0.x)*.4), (p0.y + (p1.y-p0.y)*.4));
    CGPoint O = CGPointMake((p0.x + ((p1.x-p0.x)*.6)), p0.y + ((p1.y-p0.y)*.6));
    
    NSArray *points0 = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:A],
                       [NSValue valueWithCGPoint:B],
                       [NSValue valueWithCGPoint:C],
                       [NSValue valueWithCGPoint:D],
                       [NSValue valueWithCGPoint:E], nil];
    
    NSArray *points1 = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:C],
                        [NSValue valueWithCGPoint:O],
                        [NSValue valueWithCGPoint:p1],
                        [NSValue valueWithCGPoint:F],
                        [NSValue valueWithCGPoint:D], nil];
    
    NSArray *points2 = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:G],
                        [NSValue valueWithCGPoint:p2],
                        [NSValue valueWithCGPoint:H],
                        [NSValue valueWithCGPoint:E],
                        [NSValue valueWithCGPoint:D], nil];
    
    NSArray *points3 = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:I],
                        [NSValue valueWithCGPoint:p3],
                        [NSValue valueWithCGPoint:J],
                        [NSValue valueWithCGPoint:A],
                        [NSValue valueWithCGPoint:E], nil];
    
    NSArray *points4 = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:K],
                        [NSValue valueWithCGPoint:p4],
                        [NSValue valueWithCGPoint:L],
                        [NSValue valueWithCGPoint:B],
                        [NSValue valueWithCGPoint:A], nil];
    
    NSArray *points5 = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:M],
                        [NSValue valueWithCGPoint:p0],
                        [NSValue valueWithCGPoint:N],
                        [NSValue valueWithCGPoint:C],
                        [NSValue valueWithCGPoint:B], nil];
    
    AORPentaflake *c0 = [self.children objectAtIndex:0];
    AORPentaflake *c1 = [self.children objectAtIndex:1];
    AORPentaflake *c2 = [self.children objectAtIndex:2];
    AORPentaflake *c3 = [self.children objectAtIndex:3];
    AORPentaflake *c4 = [self.children objectAtIndex:4];
    AORPentaflake *c5 = [self.children objectAtIndex:5];
    
    if (!c0 && !c1 && !c2 && !c3 && !c4 && !c5){
        c0 = [[AORPentaflake alloc] init];
        c0.theme = self.theme;
        c1 = [[AORPentaflake alloc] init];
        c1.theme = self.theme;
        c2 = [[AORPentaflake alloc] init];
        c2.theme = self.theme;
        c3 = [[AORPentaflake alloc] init];
        c3.theme = self.theme;
        c4 = [[AORPentaflake alloc] init];
        c4.theme = self.theme;
        c5 = [[AORPentaflake alloc] init];
        c5.theme = self.theme;
        self.children = [NSArray arrayWithObjects:c0,
                         c1,
                         c2,
                         c3,
                         c4,
                         c5,
                         nil];
    }
    
    [c0 drawWithPoints:points0 depth:self.depth-1];
    [c1 drawWithPoints:points1 depth:self.depth-1];
    [c2 drawWithPoints:points2 depth:self.depth-1];
    [c3 drawWithPoints:points3 depth:self.depth-1];
    [c4 drawWithPoints:points4 depth:self.depth-1];
    [c5 drawWithPoints:points5 depth:self.depth-1];
    
    for (AORPentaflake *child in self.children) {
        [self.layer addSublayer:child.layer];
    }
    
}



@end

