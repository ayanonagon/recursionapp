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

- (id)initWithP1:(CGPoint)p1 p2:(CGPoint)p2
{
    return [self initWithP1:p1 p2:p2 depth:LEVY_MAX_DEPTH];
}

- (id)initWithP1:(CGPoint)p1 p2:(CGPoint)p2 depth:(int)depth
{
    self = [super init];
    if (self) {
        self.p1 = p1;
        self.p2 = p2;
        self.depth = depth;
        [self configureShape];
        if (!self.child1) {
            self.child1 = [AORLevy alloc];
        }
        if (!self.child2) {
            self.child2 = [AORLevy alloc];
        }
    }
    return self;
}

- (void)clearLayers
{
    [self.child1.layer removeFromSuperlayer];
    [self.child2.layer removeFromSuperlayer];
    [self.child1 clearLayers];
    [self.child2 clearLayers];
}

- (void)defineShapePath
{
    CGFloat xdir = self.p2.x-self.p1.x;
    CGFloat ydir = self.p2.y-self.p1.y;
    CGFloat perpx = -ydir/2;
    CGFloat perpy = xdir/2;
    CGPoint mid = CGPointMake((self.p1.x+self.p2.x)/2, (self.p1.y+self.p2.y)/2);
    CGPoint newPoint = CGPointMake(mid.x+perpx, mid.y+perpy);
    
    if (!self.paths) {
    
        self.paths = [NSArray arrayWithObjects:
                      [NSValue valueWithPointer:createPathFromPoints(self.p1, newPoint)],
                      [NSValue valueWithPointer:createPathFromPoints(newPoint, self.p2)], nil];
    }
    else {
        augmentPath([[self.paths objectAtIndex:0] pointerValue], self.p1, newPoint);
        augmentPath([[self.paths objectAtIndex:1] pointerValue], newPoint, self.p2);
    }
}


- (void)defineChildren
{
    CGFloat xdir = self.p2.x-self.p1.x;
    CGFloat ydir = self.p2.y-self.p1.y;
    CGFloat perpx = -ydir/2;
    CGFloat perpy = xdir/2;
    CGPoint mid = CGPointMake((self.p1.x+self.p2.x)/2, (self.p1.y+self.p2.y)/2);
    CGPoint newPoint = CGPointMake(mid.x+perpx, mid.y+perpy);
    
//    self.children = [NSArray arrayWithObjects:
//                     [[AORLevy alloc] initWithP1:self.p1 p2:newPoint depth:self.depth-1],
//                     [[AORLevy alloc] initWithP1:newPoint p2:self.p2 depth:self.depth-1], nil];
//    for (AORLevy *child in self.children) {
//        [self.layer addSublayer:child.layer];
//    }
    [self.child1 initWithP1:self.p1 p2:newPoint depth:self.depth-1];
    [self.child2 initWithP1:newPoint p2:self.p2 depth:self.depth-1];
    [self.layer addSublayer:self.child1.layer];
    [self.layer addSublayer:self.child2.layer];
}

@end
