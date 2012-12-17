//
//  AORPentaflake.m
//  Recursion
//
//  Created by Elissa Wolf on 12/8/12.
//  Copyright (c) 2012 CIS 399 Project. All rights reserved.
//

#import "AORMinkowski.h"
#import <QuartzCore/QuartzCore.h>

@interface AORMinkowski ()
@property CGPoint p1;
@property CGPoint p2;
@end

@implementation AORMinkowski

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id)drawWithP1:(CGPoint)p1 p2:(CGPoint)p2;
{
    return [self drawWithP1:p1 p2:p2 depth:MINKOWSKI_MAX_DEPTH];
}

- (id)drawWithP1:(CGPoint)p1 p2:(CGPoint)p2 depth:(int)depth
{
    self.p1 = p1;
    self.p2 = p2;
    self.depth = depth;
    [self configureShape];
    return self;
}


- (void)defineShapePath
{
    
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, self.p1.x, self.p1.y);
    CGPathAddLineToPoint(path, NULL, self.p2.x, self.p2.y);
    
        
    self.paths = [NSArray arrayWithObjects:
                  [NSValue valueWithPointer:path],
                  nil];
    
}

- (void)defineChildren
{
    float dx = self.p2.x-self.p1.x;
    float dy = self.p2.y-self.p1.y;
    
    CGPoint q1 = CGPointMake(self.p1.x+(.25*dx), self.p1.y+(.25*dy));
    CGPoint mid = CGPointMake(self.p1.x+ (.5*dx), self.p1.y+(.5*dy));
    CGPoint q3 = CGPointMake(self.p1.x+(.75*dx), self.p1.y+(.75*dy));
    
    float n1x = -dy;
    float n1y = dx;
    float n2x = dy;
    float n2y = -dx;
    
    CGPoint A = CGPointMake(q1.x+(.25*n2x), q1.y+(.25*n2y));
    CGPoint B = CGPointMake(mid.x+(.25*n2x), mid.y+(.25*n2y));
    CGPoint C = CGPointMake(mid.x+(.25*n1x), mid.y+(.25*n1y));
    CGPoint D = CGPointMake(q3.x+(.25*n1x), q3.y+(.25*n1y));
    
    AORMinkowski *c0 = [self.children objectAtIndex:0];
    AORMinkowski *c1 = [self.children objectAtIndex:1];
    AORMinkowski *c2 = [self.children objectAtIndex:2];
    AORMinkowski *c3 = [self.children objectAtIndex:3];
    AORMinkowski *c4 = [self.children objectAtIndex:4];
    AORMinkowski *c5 = [self.children objectAtIndex:5];
    AORMinkowski *c6 = [self.children objectAtIndex:6];
    AORMinkowski *c7 = [self.children objectAtIndex:7];
    
    if (!c0 && !c1 && !c2 && !c3 && !c4 && !c5 && !c6 && !c7){
        c0 = [[AORMinkowski alloc] init];
        c0.theme = self.theme;
        c1 = [[AORMinkowski alloc] init];
        c1.theme = self.theme;
        c2 = [[AORMinkowski alloc] init];
        c2.theme = self.theme;
        c3 = [[AORMinkowski alloc] init];
        c3.theme = self.theme;
        c4 = [[AORMinkowski alloc] init];
        c4.theme = self.theme;
        c5 = [[AORMinkowski alloc] init];
        c5.theme = self.theme;
        c6 = [[AORMinkowski alloc] init];
        c6.theme = self.theme;
        c7 = [[AORMinkowski alloc] init];
        c7.theme = self.theme;
        self.children = [NSArray arrayWithObjects:c0,
                         c1,
                         c2,
                         c3,
                         c4,
                         c5,
                         c6,
                         c7,
                         nil];
    }

    [c0 drawWithP1:self.p1 p2:q1 depth:self.depth-1];
    [c1 drawWithP1:q1 p2:A depth:self.depth-1];
    [c2 drawWithP1:A p2:B depth:self.depth-1];
    [c3 drawWithP1:B p2:mid depth:self.depth-1];
    [c4 drawWithP1:mid p2:C depth:self.depth-1];
    [c5 drawWithP1:C p2:D depth:self.depth-1];
    [c6 drawWithP1:D p2:q3 depth:self.depth-1];
    [c7 drawWithP1:q3 p2:self.p2 depth:self.depth-1];
    
    for (AORMinkowski *child in self.children) {
        [self.layer addSublayer:child.layer];
    }

}



@end

