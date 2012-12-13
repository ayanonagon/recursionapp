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
@property CGPoint p1, p2;
@property AORLevy *child1, *child2;
@end

@implementation AORLevy

- (id)init
{
    self = [super init];
    if (self){
        
    }
    return self;
}

- (id)drawWithP1:(CGPoint)p1 p2:(CGPoint)p2
{
    return [self drawWithP1:p1 p2:p2 depth:LEVY_MAX_DEPTH];
}

- (id)drawWithP1:(CGPoint)p1 p2:(CGPoint)p2 depth:(int)depth
{
    self.p1 = p1;
    self.p2 = p2;
    self.depth = depth;
    [self configureShape];
//        if (!self.child1) {
//            self.child1 = [AORLevy alloc];
//        }
//        if (!self.child2) {
//            self.child2 = [AORLevy alloc];
//        }
    return self;
}

- (void)defineShapePath
{
    CGFloat xdir = self.p2.x-self.p1.x;
    CGFloat ydir = self.p2.y-self.p1.y;
    CGFloat perpx = -ydir/2;
    CGFloat perpy = xdir/2;
    CGPoint mid = CGPointMake((self.p1.x+self.p2.x)/2, (self.p1.y+self.p2.y)/2);
    CGPoint newPoint = CGPointMake(mid.x+perpx, mid.y+perpy);
    self.paths = [NSArray arrayWithObjects:
                  [NSValue valueWithPointer:createPathFromPoints(self.p1, newPoint)],
                  [NSValue valueWithPointer:createPathFromPoints(newPoint, self.p2)], nil];
}


- (void)defineChildren
{
    // Reclaim old children if exists
    AORLevy *c1 = [self.children objectAtIndex:0];
    AORLevy *c2 = [self.children objectAtIndex:1];
    
    if (!c1 && !c2) {
        c1 = [[AORLevy alloc] init];
        c2 = [[AORLevy alloc] init];
        self.children = [NSArray arrayWithObjects:c1, c2, nil];
    }
    else if (!c1 || !c2) {
        NSLog(@"ERROR: Some children uninitialized");
    }
    // Drawing code
    CGFloat xdir = self.p2.x-self.p1.x;
    CGFloat ydir = self.p2.y-self.p1.y;
    CGFloat perpx = -ydir/2;
    CGFloat perpy = xdir/2;
    CGPoint mid = CGPointMake((self.p1.x+self.p2.x)/2, (self.p1.y+self.p2.y)/2);
    CGPoint newPoint = CGPointMake(mid.x+perpx, mid.y+perpy);
    
    [c1 drawWithP1:self.p1 p2:newPoint depth:self.depth-1];
    [c2 drawWithP1:newPoint p2:self.p2 depth:self.depth-1];

    for (AORLevy *child in self.children) {
        [self.layer addSublayer:child.layer];
    }
}

@end
