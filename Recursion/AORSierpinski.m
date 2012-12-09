//
//  AORSierpinski.m
//  Recursion
//
//  Created by Ayaka Nonaka on 12/7/12.
//  Copyright (c) 2012 CIS 399 Project. All rights reserved.
//

/**
 * By default, triangles will have a depth of 7, however,
 * ideally we would want to continue creating sub-shapes as
 * long as fingers are held down. Doing this dynamically is 
 * a bit complicated, but each AORSierpinski object would have
 * three children objects it calls the constructor and draw
 * on after it has done animating. It is the 'done animating' that is
 * difficult to figure out right now.
 *
 */

#import "AORSierpinski.h"
#import <QuartzCore/QuartzCore.h>

@interface AORSierpinski ()
@property CGPoint p1, p2, p3;
@end

@implementation AORSierpinski

#define MAX_DEPTH 7

- (id)initWithP1:(CGPoint)p1 p2:(CGPoint)p2 p3:(CGPoint)p3
{
    return [self initWithP1:p1 p2:p2 p3:p3 depth:MAX_DEPTH];
}

- (id)initWithP1:(CGPoint)p1 p2:(CGPoint)p2 p3:(CGPoint)p3 depth:(int)depth
{
    self = [super init];
    if (self) {
        self.p1 = p1;
        self.p2 = p2;
        self.p3 = p3;
        self.depth = depth;
        [self configureShape];
    }
    return self;
}

-(void)defineChildren
{
    CGPoint a = CGPointMake((self.p1.x + self.p3.x)/2, (self.p1.y + self.p3.y)/2);
    CGPoint b = CGPointMake((self.p3.x + self.p2.x)/2, (self.p2.y + self.p3.y)/2);
    CGPoint c = CGPointMake((self.p1.x + self.p2.x)/2, (self.p1.y + self.p2.y)/2);
    AORSierpinski *c1 = [[AORSierpinski alloc] initWithP1:a p2:b p3:self.p3 depth:self.depth-1];
    AORSierpinski *c2 = [[AORSierpinski alloc] initWithP1:self.p1 p2:c p3:a depth:self.depth-1];
    AORSierpinski *c3 = [[AORSierpinski alloc] initWithP1:c p2:self.p2 p3:b depth:self.depth-1];
    self.children = [NSArray arrayWithObjects:c1, c2, c3, nil];
    for (AORSierpinski *child in self.children) {
        [self.layer addSublayer:child.layer];
    }
}

- (void)defineShapePath
{
    CGMutablePathRef line1 = CGPathCreateMutable();
    CGMutablePathRef line2 = CGPathCreateMutable();
    CGMutablePathRef line3 = CGPathCreateMutable();
    
    CGPathMoveToPoint(line1, NULL, self.p1.x, self.p1.y);
    CGPathAddLineToPoint(line1, NULL, self.p2.x, self.p2.y);
    
    CGPathMoveToPoint(line2, NULL, self.p2.x, self.p2.y);
    CGPathAddLineToPoint(line2, NULL, self.p3.x, self.p3.y);

    CGPathMoveToPoint(line3, NULL, self.p3.x, self.p3.y);
    CGPathAddLineToPoint(line3, NULL, self.p1.x, self.p1.y);
    
    self.paths = [NSArray arrayWithObjects:
                  [NSValue valueWithPointer:line1],
                  [NSValue valueWithPointer:line2],
                  [NSValue valueWithPointer:line3], nil];
}

@end
