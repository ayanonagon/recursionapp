//
//  AOROneTouch.m
//  Recursion
//
//  Created by Elissa Wolf on 12/9/12.
//  Copyright (c) 2012 CIS 399 Project. All rights reserved.
//

#import "AOROneTouch.h"
#import <QuartzCore/QuartzCore.h>

@interface AOROneTouch ()
@property CGPoint p1;
@property CGRect bounds;
@end

@implementation AOROneTouch

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (id)drawWithP1:(CGPoint)p1 bounds:(CGRect)bounds
{
    return [self drawWithP1:p1 bounds:bounds depth:ONE_TOUCH_MAX_DEPTH];
}

- (id)drawWithP1:(CGPoint)p1 bounds:(CGRect)bounds depth:(int)depth
{
    self.p1 = p1;
    self.bounds = bounds;
    self.depth = depth;
    [self configureShape];
    return self;
}

/**
 * Creating the children here doesn't seem to be detrimental
 * to performance, but it does feel like something that can 
 * be abstracted out.
 */
-(void)defineChildren
{
    AOROneTouch *c1 = [self.children objectAtIndex:0];
    AOROneTouch *c2 = [self.children objectAtIndex:1];
    
    if (!c1 && !c2) {
        c1 = [[AOROneTouch alloc] init];
        c1.theme = self.theme;
        c2 = [[AOROneTouch alloc] init];
        c2.theme = self.theme;
        self.children = [NSArray arrayWithObjects:c1, c2, nil];
    }
    else if (!c1 || !c2) {
        NSLog(@"ERROR: Some children uninitialized");
        return;
    }
    
    CGPoint p1 = CGPointMake(self.bounds.origin.x + ((self.p1.x-self.bounds.origin.x)*(self.p1.x-self.bounds.origin.x))/self.bounds.size.width, self.p1.y + (((self.p1.y - self.bounds.origin.y)*(self.bounds.origin.y + self.bounds.size.height - self.p1.y))/self.bounds.size.height));
    CGRect bounds1 = CGRectMake(self.bounds.origin.x, self.p1.y, (self.p1.x - self.bounds.origin.x), (self.bounds.origin.y + self.bounds.size.height - self.p1.y));
    [c1 drawWithP1:p1 bounds:bounds1 depth:self.depth-1];
    
    CGRect bounds2 = CGRectMake(self.p1.x, self.bounds.origin.y, (self.bounds.origin.x + self.bounds.size.width - self.p1.x), (self.p1.y - self.bounds.origin.y));
    CGPoint p2 = CGPointMake(self.p1.x + (((self.p1.x - self.bounds.origin.x) * (self.bounds.origin.x + self.bounds.size.width - self.p1.x))/self.bounds.size.width), self.bounds.origin.y + ((self.p1.y-self.bounds.origin.y) * (self.p1.y-self.bounds.origin.y)/self.bounds.size.height));
    [c2 drawWithP1:p2 bounds:bounds2 depth:self.depth-1];
    
    for (AOROneTouch *child in self.children) {
        [self.layer addSublayer:child.layer];
    }
}

- (void)defineShapePath
{
    CGMutablePathRef line1 = CGPathCreateMutable();
    CGMutablePathRef line2 = CGPathCreateMutable();
    CGMutablePathRef line3 = CGPathCreateMutable();
    CGMutablePathRef line4 = CGPathCreateMutable();
    CGMutablePathRef line5 = CGPathCreateMutable();
    CGMutablePathRef line6 = CGPathCreateMutable();
    CGMutablePathRef line7 = CGPathCreateMutable();
    CGMutablePathRef line8 = CGPathCreateMutable();
    
    //top left square
    CGPathMoveToPoint(line1, NULL, self.bounds.origin.x, self.bounds.origin.y);
    CGPathAddLineToPoint(line1, NULL, self.p1.x, self.bounds.origin.y);
    
    CGPathMoveToPoint(line2, NULL, self.p1.x, self.bounds.origin.y);
    CGPathAddLineToPoint(line2, NULL, self.p1.x, self.p1.y);
    
    CGPathMoveToPoint(line3, NULL, self.p1.x, self.p1.y);
    CGPathAddLineToPoint(line3, NULL, self.bounds.origin.x, self.p1.y);
    
    CGPathMoveToPoint(line4, NULL, self.bounds.origin.x, self.p1.y);
    CGPathAddLineToPoint(line4, NULL, self.bounds.origin.x, self.bounds.origin.y);
    
    //bottom right square
    CGPathMoveToPoint(line5, NULL, self.p1.x, self.p1.y);
    CGPathAddLineToPoint(line5, NULL, (self.bounds.origin.x + self.bounds.size.width), self.p1.y);
    
    CGPathMoveToPoint(line6, NULL, (self.bounds.origin.x + self.bounds.size.width), self.p1.y);
    CGPathAddLineToPoint(line6, NULL, (self.bounds.origin.x + self.bounds.size.width), (self.bounds.origin.y + self.bounds.size.height));
    
    CGPathMoveToPoint(line7, NULL, (self.bounds.origin.x + self.bounds.size.width), (self.bounds.origin.y + self.bounds.size.height));
    CGPathAddLineToPoint(line7, NULL, self.p1.x, (self.bounds.origin.y + self.bounds.size.height));
    
    CGPathMoveToPoint(line8, NULL, self.p1.x, (self.bounds.origin.y + self.bounds.size.height));
    CGPathAddLineToPoint(line8, NULL, self.p1.x, self.p1.y);
    
    self.paths = [NSArray arrayWithObjects:
                  [NSValue valueWithPointer:line1],
                  [NSValue valueWithPointer:line2],
                  [NSValue valueWithPointer:line3],
                  [NSValue valueWithPointer:line4],
                  [NSValue valueWithPointer:line5],
                  [NSValue valueWithPointer:line6],
                  [NSValue valueWithPointer:line7],
                  [NSValue valueWithPointer:line8], nil];
}


@end
