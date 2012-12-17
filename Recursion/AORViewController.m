//
//  AORViewController.m
//  Recursion
//
//  Created by Ayaka Nonaka on 12/7/12.
//  Copyright (c) 2012 CIS 399 Project. All rights reserved.
//

#import "AORViewController.h"
#import "AORSierpinski.h"
#import "AORStar.h"
#import "AORCarpet.h"
#import "AORLevy.h"
#import "AORExamples.h"
#import "AOROneTouch.h"
#import "AORPentaflake.h"
#import "AORMinkowski.h"
#import <QuartzCore/QuartzCore.h>
#include <math.h>

#define MAX_LAYER_COUNT 20
#define TOUCHES_DELTA 0.5
#define DOUBLE_TAP_INTERVAL 0.3

@interface AORViewController ()
@property (strong, nonatomic) CALayer *rootLayer;
@property (strong, nonatomic) AOROneTouch *oneTouch;
@property (strong, nonatomic) AORLevy *levy;
@property (strong, nonatomic) AORSierpinski *sierpinski;
@property (strong, nonatomic) AORCarpet *carpet;
@property (strong, nonatomic) AORStar *star;
@property (strong, nonatomic) AORPentaflake *pentaflake;
@property (strong, nonatomic) AORMinkowski *minkowski;
@property (strong, nonatomic) CALayer *previousLayer;
@property (strong, nonatomic) NSMutableArray *layerFadeQueue;
@property (strong, nonatomic) NSArray *colors;
@property int themeIndex;
@property (strong, nonatomic) NSArray *lastTouches;
@property BOOL touchesEnding;

@property (strong, nonatomic) NSDate *lastTap;

@end

@implementation AORViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.multipleTouchEnabled = YES;  

    // Set up the root layer.
    self.rootLayer	= [CALayer layer];
    self.rootLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:self.rootLayer];
    self.rootLayer.backgroundColor = [[UIColor blackColor] CGColor];
    self.layerFadeQueue = [NSMutableArray array];
    self.themeIndex = 3;
    [self initColors];
    
    // Initialize them all. They get re-configured
    // by setting new points.
    // We also want them to create all their children beforehand.
    self.oneTouch = [[AOROneTouch alloc] init];
    self.oneTouch.theme = [self.colors objectAtIndex:self.themeIndex];
    self.levy = [[AORLevy alloc] init];
    self.levy.theme = [self.colors objectAtIndex:self.themeIndex];
    self.sierpinski = [[AORSierpinski alloc] init];
    self.sierpinski.theme = [self.colors objectAtIndex:self.themeIndex];
    self.carpet = [[AORCarpet alloc] init];
    self.carpet.theme = [self.colors objectAtIndex:self.themeIndex];
    self.star = [[AORStar alloc] init];
    self.star.theme = [self.colors objectAtIndex:self.themeIndex];
    self.pentaflake = [[AORPentaflake alloc] init];
    self.pentaflake.theme = [self.colors objectAtIndex:self.themeIndex];
    self.minkowski = [[AORMinkowski alloc] init];
    self.minkowski.theme = [self.colors objectAtIndex:self.themeIndex];
}

- (void)initColors
{
    UIColor *christmasRed = [UIColor colorWithRed:.6901 green:.0902 blue:.1216 alpha:1];
    UIColor *christmasGreen = [UIColor colorWithRed:.1882 green:.502 blue:.0784 alpha:1];
    UIColor *christmasWhite = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    NSArray *christmas = [NSArray arrayWithObjects:christmasRed,
                          christmasGreen,
                          christmasWhite,
                          nil];
    
    UIColor *neonPink = [UIColor colorWithRed:.9333 green:0 blue:.9333 alpha:1];
    UIColor *neonGold = [UIColor colorWithRed:1 green:.8431 blue:0 alpha:1];
    UIColor *neonGreen = [UIColor colorWithRed:.4627 green:.9333 blue:0 alpha:1];
    NSArray *neon = [NSArray arrayWithObjects:neonPink,
                     neonGold,
                     neonGreen,
                     nil];
    
    UIColor *ocean1 = [UIColor colorWithRed:0 green:.545 blue:.545 alpha:1];
    UIColor *ocean2 = [UIColor colorWithRed:.2 green:.6314 blue:.7882 alpha:1];
    UIColor *ocean3 = [UIColor colorWithRed:0 green:.7804 blue:.549 alpha:1];
    UIColor *ocean4 = [UIColor colorWithRed:.498 green:1 blue:.8314 alpha:1];
    UIColor *ocean5 = [UIColor colorWithRed:0 green:.4078 blue:.545 alpha:1];
    NSArray *ocean = [NSArray arrayWithObjects:ocean1,
                      ocean2,
                      ocean3,
                      ocean4,
                      ocean5,
                      nil];
    
    UIColor *neo1 = [UIColor colorWithRed:.8039 green:.7529 blue:.6902 alpha:1];
    UIColor *neo2 = [UIColor colorWithRed:1 green:.9373 blue:.8588 alpha:1];
    UIColor *neo3 = [UIColor colorWithRed:1 green:.7529 blue:.796 alpha:1];
    UIColor *neo4 = [UIColor colorWithRed:1 green:.5098 blue:.6076 alpha:1];
    UIColor *neo5 = [UIColor colorWithRed:.545 green:.3412 blue:.2588 alpha:1];
    NSArray *neopolitan = [NSArray arrayWithObjects:neo1,
                           neo2,
                           neo3,
                           neo4,
                           neo5, nil];
    
    UIColor *sun1 = [UIColor colorWithRed:1 green:.549 blue:.4118 alpha:1];
    UIColor *sun2 = [UIColor colorWithRed:1 green:.4157 blue:.4157 alpha:1];
    UIColor *sun3 = [UIColor colorWithRed:.8039 green:.4078 blue:.5373 alpha:1];
    UIColor *sun4 = [UIColor colorWithRed:.545 green:.4 blue:.545 alpha:1];
    UIColor *sun5 = [UIColor colorWithRed:.2745 green:.5098 blue:.7059 alpha:1];
    NSArray *sunset = [NSArray arrayWithObjects:sun1,
                       sun2,
                       sun3,
                       sun4,
                       sun5, nil];
    
    self.colors = [NSArray arrayWithObjects:christmas,
                   neon,
                   ocean,
                   neopolitan,
                   sunset,
                   nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Touch Handling

- (int)distanceBetweenPoint1:(CGPoint)p1 Point2:(CGPoint)p2
{
    return sqrt(pow(p1.x - p2.x, 2) + pow(p1.y - p2.y ,2));
}

/** 
 * Check to see if this set of points is distinct enough
 * from the previous set, via distance or number of 
 * touches, and save the points as last seen points for the
 * next time this is called. 
 */ 
- (BOOL)pointsAreDistinctEnough:(NSArray *)allTouches
{
    BOOL result = NO;
    if ([allTouches count] != [self.lastTouches count]) {
        result = YES;
    }
    else {
        // Find distance
        int distanceSum = 0;
        for (int i = 0; i < [allTouches count]; i++) {
            UITouch *touch = [allTouches objectAtIndex:i];
            CGPoint p1 = [touch locationInView:self.view];
            CGPoint p2 = [touch previousLocationInView:self.view];
            distanceSum += [self distanceBetweenPoint1:p1 Point2:p2];
        }
        if (distanceSum > TOUCHES_DELTA) {
            result = YES;
        }
    }
    // Either way, save new points
    [self setLastTouches:allTouches];
    return result;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];

    if (self.touchesEnding) return;

    [self fadeOutPreviousLayer];

    NSArray *allTouches = [[event allTouches] allObjects];

    switch ([[event allTouches] count]) {
        case 1:
            [self handleOnePoint:allTouches all:NO];
            break;
        case 2:
            [self handleTwoPoints:allTouches all:NO];
            break;
        case 3:
            [self handleThreePoints:allTouches all:NO];
            break;
        case 4:
            [self handleFourPoints:allTouches all:NO];
            break;
        case 5:
            [self handleFivePoints:allTouches all:NO];
            break;
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    // Logic for switching between colors with double tap.
    NSDate *currentTime = [NSDate date];
    NSTimeInterval timeSinceLastTap = [currentTime timeIntervalSinceDate:self.lastTap];
    self.lastTap = currentTime;
    if ([[event allTouches] count] == 1 && timeSinceLastTap < DOUBLE_TAP_INTERVAL) {
        self.themeIndex = (self.themeIndex + 1) % self.colors.count;
        NSLog(@"changing theme");
    }

    self.touchesEnding = NO;
    [super touchesBegan:touches withEvent:event];
    [self touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];

    if (!self.touchesEnding) {
        self.lastTouches = [event.allTouches allObjects];
        self.touchesEnding = YES;
    }

    if ([touches count] == [[event.allTouches allObjects] count]) {
        self.touchesEnding = NO;
    } else {
        return;
    }
    
    [self fadeOutPreviousLayer];
    NSArray* allTouches = self.lastTouches;
    switch ([allTouches count]) {
        case 1:
            [self handleOnePoint:allTouches all:YES];
            break;
        case 2:
            [self handleTwoPoints:allTouches all:YES];
             break;
        case 3:
            [self handleThreePoints:allTouches all:YES];
            break;
        case 4:
            [self handleFourPoints:allTouches all:YES];
            break;
        case 5:
            [self handleFivePoints:allTouches all:YES];
            break;
        default:
            break;
     }
}

#pragma mark - Drawing

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    // Pop the queue and remove this layer
    CALayer *layerToRemove = [self.layerFadeQueue objectAtIndex:0];
    if (layerToRemove) {
        [self.layerFadeQueue removeObjectAtIndex:0];
        [layerToRemove removeFromSuperlayer];
    }
}

- (void)fadeOutLayer:(CALayer *)layer
{
    // If we have too many layers on screen, get rid of this one.
    if ([self.layerFadeQueue count] > MAX_LAYER_COUNT) {
        [layer removeFromSuperlayer];
    }
    [layer removeAllAnimations];
    layer.opacity = 0.0;
    CABasicAnimation *fadeOutAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeOutAnimation.duration = 1.0;
    fadeOutAnimation.fromValue = @1.0;
    fadeOutAnimation.toValue = @0.0;
    // Add to queue so it can be cleaned after
    [self.layerFadeQueue addObject:layer];
    [fadeOutAnimation setDelegate:self];
    [layer addAnimation:fadeOutAnimation forKey:@"animateOpacity"];

}

- (void)fadeOutPreviousLayer
{
    // Pick up the last layer
    if (self.previousLayer) {
        [self fadeOutLayer:self.previousLayer];
        self.previousLayer = nil;
    }
}

- (void)handleOnePoint:(NSArray *)allTouches all:(BOOL)all
{
    CGPoint p1 = CGPointMake(200, 200);
    CGPoint p2 = CGPointMake(600, 200);
    self.minkowski = [self.minkowski drawWithP1:p1 p2:p2];
    self.minkowski.theme = [self.colors objectAtIndex:self.themeIndex];
    [self.rootLayer addSublayer:self.minkowski.layer];
    
    
    /*CGPoint point0 = [(UITouch *)[allTouches objectAtIndex:0] locationInView:self.view];
    if (all) {
        self.oneTouch = [self.oneTouch drawWithP1:point0 bounds:CGRectMake(0.0, 0.0, 755.0, 1024.0)];
    } else {
        self.oneTouch = [self.oneTouch drawWithP1:point0 bounds:CGRectMake(0.0, 0.0, 755.0, 1024.0) depth:0];
    }
    self.oneTouch.theme = [self.colors objectAtIndex:self.themeIndex];
    [self.rootLayer addSublayer:self.oneTouch.layer];
    // Add this layer to the layerQueue
    self.previousLayer = self.oneTouch.layer;*/
}

- (void)handleTwoPoints:(NSArray *)allTouches all:(BOOL)all
{
    CGPoint point0 = [(UITouch *)[allTouches objectAtIndex:0] locationInView:self.view];
    CGPoint point1 = [(UITouch *)[allTouches objectAtIndex:1] locationInView:self.view];
    if (all) {
        self.levy = [self.levy drawWithP1:point0 p2:point1];
    } else {
        self.levy = [self.levy drawWithP1:point0 p2:point1 depth:0];
    }
    self.levy.theme = [self.colors objectAtIndex:self.themeIndex];
    [self.rootLayer addSublayer:self.levy.layer];
    self.previousLayer = self.levy.layer;
}

- (void)handleThreePoints:(NSArray *)allTouches all:(BOOL)all
{
    CGPoint point0 = [(UITouch *)[allTouches objectAtIndex:0] locationInView:self.view];
    CGPoint point1 = [(UITouch *)[allTouches objectAtIndex:1] locationInView:self.view];
    CGPoint point2 = [(UITouch *)[allTouches objectAtIndex:2] locationInView:self.view];
    if (all) {
        self.sierpinski = [self.sierpinski drawWithP1:point0 p2:point1 p3:point2];
    } else {
        self.sierpinski = [self.sierpinski drawWithP1:point0 p2:point1 p3:point2 depth:0];
    }
    self.sierpinski.theme = [self.colors objectAtIndex:self.themeIndex];
    [self.rootLayer addSublayer:self.sierpinski.layer];
    self.previousLayer = self.sierpinski.layer;
}

- (void)handleFourPoints:(NSArray *)allTouches all:(BOOL)all
{
    CGPoint point0 = [(UITouch *)[allTouches objectAtIndex:0] locationInView:self.view];
    CGPoint point1 = [(UITouch *)[allTouches objectAtIndex:1] locationInView:self.view];
    CGPoint point2 = [(UITouch *)[allTouches objectAtIndex:2] locationInView:self.view];
    CGPoint point3 = [(UITouch *)[allTouches objectAtIndex:3] locationInView:self.view];
    if (all) {
        self.carpet = [self.carpet drawWithP1:point0 p2:point1 p3:point2 p4:point3];
    } else {
        self.carpet = [self.carpet drawWithP1:point0 p2:point1 p3:point2 p4:point3 depth:0];
    }
    self.carpet.theme = [self.colors objectAtIndex:self.themeIndex];
    [self.rootLayer addSublayer:self.carpet.layer];
    self.previousLayer = self.carpet.layer;
}

- (void)handleFivePoints:(NSArray *)allTouches all:(BOOL)all
{
    CGPoint point0 = [(UITouch *)[allTouches objectAtIndex:0] locationInView:self.view];
    CGPoint point1 = [(UITouch *)[allTouches objectAtIndex:1] locationInView:self.view];
    CGPoint point2 = [(UITouch *)[allTouches objectAtIndex:2] locationInView:self.view];
    CGPoint point3 = [(UITouch *)[allTouches objectAtIndex:3] locationInView:self.view];
    CGPoint point4 = [(UITouch *)[allTouches objectAtIndex:4] locationInView:self.view];
    if (all) {
        self.pentaflake = [self.pentaflake drawWithPoints:[NSArray arrayWithObjects:
                                               [NSValue valueWithCGPoint:point0],
                                               [NSValue valueWithCGPoint:point1],
                                               [NSValue valueWithCGPoint:point2],
                                               [NSValue valueWithCGPoint:point3],
                                               [NSValue valueWithCGPoint:point4], nil]];
    } else {
        self.pentaflake = [self.pentaflake drawWithPoints:[NSArray arrayWithObjects:
                                               [NSValue valueWithCGPoint:point0],
                                               [NSValue valueWithCGPoint:point1],
                                               [NSValue valueWithCGPoint:point2],
                                               [NSValue valueWithCGPoint:point3],
                                               [NSValue valueWithCGPoint:point4], nil] depth:0];
    }
    self.pentaflake.theme = [self.colors objectAtIndex:self.themeIndex];
    [self.rootLayer addSublayer:self.pentaflake.layer];
    self.previousLayer = self.pentaflake.layer;
}

#pragma mark - Utils

- (void)clearCanvas
{
    for (CALayer *layer in self.rootLayer.sublayers) {
        [layer removeFromSuperlayer];
    }
}

@end
