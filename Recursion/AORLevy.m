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
@end

@implementation AORLevy

- (id)initWithP1:(CGPoint)p1 p2:(CGPoint)p2
{
    return [self initWithP1:p1 p2:p2 depth:MAX_DEPTH];
}

- (id)initWithP1:(CGPoint)p1 p2:(CGPoint)p2 depth:(int)depth
{
    self = [super init];
    if (self) {
        self.p1 = p1;
        self.p2 = p2;
        self.depth = depth;
        [self configureShape];
    }
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
    CGFloat xdir = self.p2.x-self.p1.x;
    CGFloat ydir = self.p2.y-self.p1.y;
    CGFloat perpx = -ydir/2;
    CGFloat perpy = xdir/2;
    CGPoint mid = CGPointMake((self.p1.x+self.p2.x)/2, (self.p1.y+self.p2.y)/2);
    CGPoint newPoint = CGPointMake(mid.x+perpx, mid.y+perpy);
    
    self.children = [NSArray arrayWithObjects:
                     [[AORLevy alloc] initWithP1:self.p1 p2:newPoint depth:self.depth-1],
                     [[AORLevy alloc] initWithP1:newPoint p2:self.p2 depth:self.depth-1], nil];
    for (AORLevy *child in self.children) {
        [self.layer addSublayer:child.layer];
    }
}

@end
