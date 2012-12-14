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
@property NSArray *points;
@end

@implementation AORStar

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id)drawWithPoints:(NSArray *)points
{
    return [self drawWithPoints:points depth:STAR_MAX_DEPTH];
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
    NSMutableArray *newPoints = [NSMutableArray array];
    NSValue *val = [self.points objectAtIndex:0];
    CGPoint start = [val CGPointValue];
    // CGPathMoveToPoint(self.linePath, NULL, start.x, start.y);
    CGMutablePathRef firstPath = nil;
    NSMutableArray *mutablePaths = [NSMutableArray array];
    for(int i = 0; i < 5; i++){
        NSValue *val;
        CGPoint p1, p1co, p2, p2co;
        
        val = self.points[i];
        p1 = [val CGPointValue];
        if (i == 0){
            val = self.points[4];
            p1co = [val CGPointValue];
        }
        else {
            val = self.points[i-1];
            p1co = [val CGPointValue];
        }
        if (i==4){
            val = self.points[0];
            p2 = [val CGPointValue];
            val = self.points[1];
            p2co = [val CGPointValue];
        }
        else {
            val = self.points[i+1];
            p2 = [val CGPointValue];
        }
        if (i==3) {
            val = self.points[0];
            p2co = [val CGPointValue];
        }
        else if (i!=4){
            val = self.points[i+2];
            p2co = [val CGPointValue];
        }
        
        //p1 = [val CGPointValue];
        
        CGFloat ax = p1.x - p1co.x;
        CGFloat ay = p1.y - p1co.y;
        CGFloat bx = p2.x - p2co.x;
        CGFloat by = p2.y - p2co.y;
        
        CGFloat s = ((p2co.y*ax) - (p1co.y*ax) - (p2co.x*ay) + (p1co.x*ay)) / ((bx*ay) - (by*ax));
        
        CGPoint intersect = CGPointMake(p2co.x + (s * bx), p2co.y + (s * by));
        NSValue *v = [NSValue valueWithCGPoint:intersect];
        [newPoints insertObject:v atIndex:i];
        
        /*if (!firstPath) {
            firstPath = CGPathCreateMutable();
            CGPathMoveToPoint(firstPath, NULL, start.x, start.y);
            CGPathAddLineToPoint(firstPath, NULL, intersect.x, intersect.y);
            CGPathAddLineToPoint(firstPath, NULL, p2.x, p2.y);
            [mutablePaths addObject:[NSValue valueWithPointer:firstPath]];
        }
        else {*/
        CGMutablePathRef path1 = CGPathCreateMutable();
        CGMutablePathRef path2 = CGPathCreateMutable();

        CGPathMoveToPoint(path1, NULL, p1.x, p1.y);
        CGPathAddLineToPoint(path1, NULL, intersect.x, intersect.y);
        CGPathMoveToPoint(path2, NULL, intersect.x, intersect.y);
        CGPathAddLineToPoint(path2, NULL, p2.x, p2.y);

        [mutablePaths addObject:[NSValue valueWithPointer:path1]];
        [mutablePaths addObject:[NSValue valueWithPointer:path2]];
        //}
    }
    
    self.paths = [NSArray arrayWithArray:mutablePaths];
    self.points = [NSArray arrayWithArray:newPoints];
    
    // CGPathCloseSubpath(self.linePath);
    // [self startAnimation];
//    
//    if (depth > 1){
//        [self drawWithPoints:newPoints depth:depth-1];
//    
//    }
    
}

- (void)defineChildren
{
    AORStar *child = [self.children objectAtIndex:0];
    if (!child) {
        self.children = [NSArray arrayWithObjects:
                         [[[AORStar alloc] init] drawWithPoints:self.points depth:self.depth-1], nil];
    }
    else {
        [child drawWithPoints:self.points depth:self.depth-1];
    }
    for (AORStar *child in self.children) {
        [self.layer addSublayer:child.layer];
    }
}



@end
