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
@property CGPoint p1, p2, p3, p4;
@end

#define MAX_DEPTH 3

@implementation AORCarpet

- (id)initWithP1:(CGPoint)p1 p2:(CGPoint)p2 p3:(CGPoint)p3 p4:(CGPoint)p4
{
    return [self initWithP1:p1 p2:p2 p3:p3 p4:p4 depth:MAX_DEPTH];
}

- (id)initWithP1:(CGPoint)p1 p2:(CGPoint)p2 p3:(CGPoint)p3 p4:(CGPoint)p4 depth:(int)depth
{
    self = [super init];
    if (self) {
        self.p1 = p1;
        self.p2 = p2;
        self.p3 = p3;
        self.p4 = p4;
        self.depth = depth;
        [self configureShape];
    }
    return self;
}

- (void)defineShapePath
{
    CGPoint A = CGPointMake(self.p1.x+((self.p2.x-self.p1.x)/3), self.p1.y+((self.p2.y-self.p1.y)/3));
    CGPoint B = CGPointMake(self.p1.x+((self.p2.x-self.p1.x)*2/3), self.p1.y+((self.p2.y-self.p1.y)*2/3));
    CGPoint K = CGPointMake(self.p4.x+((self.p3.x-self.p4.x)/3), self.p4.y+((self.p3.y-self.p4.y)/3));
    CGPoint L = CGPointMake(self.p4.x+((self.p3.x-self.p4.x)*2/3), self.p4.y+((self.p3.y-self.p4.y)*2/3));
    // Points D and H interpolate between A and K
    CGPoint D = CGPointMake(A.x+((K.x-A.x)/3), A.y+((K.y-A.y)/3));
    CGPoint H = CGPointMake(A.x+((K.x-A.x)*2/3), A.y+((K.y-A.y)*2/3));
    // Points E and I interpolate between B and L
    CGPoint E = CGPointMake(B.x+((L.x-B.x)/3), B.y+((L.y-B.y)/3));
    CGPoint I = CGPointMake(B.x+((L.x-B.x)*2/3), B.y+((L.y-B.y)*2/3));
    
    
    self.paths = [NSArray arrayWithObjects:
                  [NSValue valueWithPointer:createPathFromPoints(D, E)],
                  [NSValue valueWithPointer:createPathFromPoints(E, I)],
                  [NSValue valueWithPointer:createPathFromPoints(I, H)],
                  [NSValue valueWithPointer:createPathFromPoints(H, D)], nil];
}

- (void)defineChildren
{
    CGPoint A = CGPointMake(self.p1.x+((self.p2.x-self.p1.x)/3), self.p1.y+((self.p2.y-self.p1.y)/3));
    CGPoint B = CGPointMake(self.p1.x+((self.p2.x-self.p1.x)*2/3), self.p1.y+((self.p2.y-self.p1.y)*2/3));
    CGPoint C = CGPointMake(self.p1.x+((self.p4.x-self.p1.x)/3), self.p1.y+((self.p4.y-self.p1.y)/3));
    CGPoint G = CGPointMake(self.p1.x+((self.p4.x-self.p1.x)*2/3), self.p1.y+((self.p4.y-self.p1.y)*2/3));
    CGPoint F = CGPointMake(self.p2.x+((self.p3.x-self.p2.x)/3), self.p2.y+((self.p3.y-self.p2.y)/3));
    CGPoint J = CGPointMake(self.p2.x+((self.p3.x-self.p2.x)*2/3), self.p2.y+((self.p3.y-self.p2.y)*2/3));
    CGPoint K = CGPointMake(self.p4.x+((self.p3.x-self.p4.x)/3), self.p4.y+((self.p3.y-self.p4.y)/3));
    CGPoint L = CGPointMake(self.p4.x+((self.p3.x-self.p4.x)*2/3), self.p4.y+((self.p3.y-self.p4.y)*2/3));
    // Points D and H interpolate between A and K
    CGPoint D = CGPointMake(A.x+((K.x-A.x)/3), A.y+((K.y-A.y)/3));
    CGPoint H = CGPointMake(A.x+((K.x-A.x)*2/3), A.y+((K.y-A.y)*2/3));
    // Points E and I interpolate between B and L
    CGPoint E = CGPointMake(B.x+((L.x-B.x)/3), B.y+((L.y-B.y)/3));
    CGPoint I = CGPointMake(B.x+((L.x-B.x)*2/3), B.y+((L.y-B.y)*2/3));
    self.children = [NSArray arrayWithObjects:
                     [[AORCarpet alloc] initWithP1:self.p1 p2:A p3:D p4:C depth:self.depth-1],
                     [[AORCarpet alloc] initWithP1:A p2:B p3:E p4:D depth:self.depth-1],
                     [[AORCarpet alloc] initWithP1:B p2:self.p2 p3:F p4:E depth:self.depth-1],
                     [[AORCarpet alloc] initWithP1:C p2:D p3:H p4:G depth:self.depth-1],
                     [[AORCarpet alloc] initWithP1:E p2:F p3:J p4:I depth:self.depth-1],
                     [[AORCarpet alloc] initWithP1:G p2:H p3:K p4:self.p4 depth:self.depth-1],
                     [[AORCarpet alloc] initWithP1:H p2:I p3:L p4:K depth:self.depth-1],
                     [[AORCarpet alloc] initWithP1:I p2:J p3:self.p3 p4:L depth:self.depth-1], nil];
    for (AORCarpet *child in self.children) {
        [self.layer addSublayer:child.layer];
    }
}


@end
