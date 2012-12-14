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
#import <QuartzCore/QuartzCore.h>

@interface AORViewController ()
@property (strong, nonatomic) CALayer *rootLayer;
@property (strong, nonatomic) AOROneTouch *oneTouch;
@property (strong, nonatomic) AORLevy *levy;
@property (strong, nonatomic) AORSierpinski *sierpinski;
@property (strong, nonatomic) AORCarpet *carpet;
@property (strong, nonatomic) AORStar *star;
@property (strong, nonatomic) CALayer *previousLayer;
@property (strong, nonatomic) NSMutableArray *layerFadeQueue;
@property (strong, nonatomic) NSArray *colors;
@property int themeIndex;

@end

@implementation AORViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Set up the root layer.
    self.rootLayer	= [CALayer layer];
    self.rootLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:self.rootLayer];
    self.rootLayer.backgroundColor = [[UIColor blackColor] CGColor];
    self.layerFadeQueue = [NSMutableArray array];
    self.themeIndex = 2;
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
    
    self.colors = [NSArray arrayWithObjects:christmas,
                   neon,
                   ocean,
                   nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Touch Handling

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self clearCanvas];
    //[self fadeOutPreviousLayer];
    NSArray *allTouches = [[event allTouches] allObjects];
    
    switch ([[event allTouches] count]) {
        case 1:
            [self handleOnePoint:allTouches];
            break;
        case 2:
            [self handleTwoPoints:allTouches];
            break;
        case 3:
            [self handleThreePoints:allTouches];
            break;
        case 4:
            [self handleFourPoints:allTouches];
            break;
        case 5:
            [self handleFivePoints:allTouches];
            break;
        default:
            break;
    }
    // After handling a touch some maintenance?
}

// This would work ideally. Trying to refine the interface to
// AOR objects
-(void)touchesMoved2:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSArray *allTouches = [[event allTouches] allObjects];
    int n = [[event allTouches] count];
    NSMutableArray *points = [NSMutableArray array];
    for (int i = 0; i < n; i++) {
        [points addObject:[NSValue valueWithCGPoint:
                           [[allTouches objectAtIndex:i]
                            locationInView:self.view]]];
    }
    //[self.objects addObject:[AORObject objectFromPoints:points]];
}

#pragma mark - Drawing

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    // Pop the queue and remove this layer
    CALayer *layerToRemove = [self.layerFadeQueue objectAtIndex:0];
    if (layerToRemove) {
        [self.layerFadeQueue removeObjectAtIndex:0];
        [layerToRemove removeFromSuperlayer];
    }
}

-(void)fadeOutLayer:(CALayer *)layer
{
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

-(void)fadeOutPreviousLayer
{
    // Pick up the last layer
    if (self.previousLayer) {
        [self fadeOutLayer:self.previousLayer];
        self.previousLayer = nil;
    }
}

-(void)handleOnePoint:(NSArray *)allTouches
{
    CGPoint point0 = [(UITouch *)[allTouches objectAtIndex:0] locationInView:self.view];
    
    // Reclaim old layer and animate to fade
    // This can be abstracted out with function call
    // Here should be fadeOutPreviousLayer
    //[self fadeOutLayer:self.oneTouch.layer];
    self.oneTouch = [self.oneTouch drawWithP1:point0 bounds:CGRectMake(0.0, 0.0, 755.0, 1024.0)];
    self.oneTouch.theme = [self.colors objectAtIndex:self.themeIndex];
    [self.rootLayer addSublayer:self.oneTouch.layer];
    // Add this layer to the layerQueue
    self.previousLayer = self.oneTouch.layer;
}

-(void)handleTwoPoints:(NSArray *)allTouches
{
    CGPoint point0 = [(UITouch *)[allTouches objectAtIndex:0] locationInView:self.view];
    CGPoint point1 = [(UITouch *)[allTouches objectAtIndex:1] locationInView:self.view];
    
    self.levy = [self.levy drawWithP1:point0 p2:point1];
    self.levy.theme = [self.colors objectAtIndex:self.themeIndex];
    [self.rootLayer addSublayer:self.levy.layer];
    self.previousLayer = self.levy.layer;
}

-(void)handleThreePoints:(NSArray *)allTouches
{
    CGPoint point0 = [(UITouch *)[allTouches objectAtIndex:0] locationInView:self.view];
    CGPoint point1 = [(UITouch *)[allTouches objectAtIndex:1] locationInView:self.view];
    CGPoint point2 = [(UITouch *)[allTouches objectAtIndex:2] locationInView:self.view];
    self.sierpinski = [self.sierpinski drawWithP1:point0 p2:point1 p3:point2];
    self.sierpinski.theme = [self.colors objectAtIndex:self.themeIndex];
    [self.rootLayer addSublayer:self.sierpinski.layer];
    self.previousLayer = self.sierpinski.layer;
}

-(void)handleFourPoints:(NSArray *)allTouches
{
    CGPoint point0 = [(UITouch *)[allTouches objectAtIndex:0] locationInView:self.view];
    CGPoint point1 = [(UITouch *)[allTouches objectAtIndex:1] locationInView:self.view];
    CGPoint point2 = [(UITouch *)[allTouches objectAtIndex:2] locationInView:self.view];
    CGPoint point3 = [(UITouch *)[allTouches objectAtIndex:3] locationInView:self.view];
    self.carpet = [self.carpet drawWithP1:point0 p2:point1 p3:point2 p4:point3];
    self.carpet.theme = [self.colors objectAtIndex:self.themeIndex];
    [self.rootLayer addSublayer:self.carpet.layer];
    self.previousLayer = self.carpet.layer;
}

-(void)handleFivePoints:(NSArray *)allTouches
{
    CGPoint point0 = [(UITouch *)[allTouches objectAtIndex:0] locationInView:self.view];
    CGPoint point1 = [(UITouch *)[allTouches objectAtIndex:1] locationInView:self.view];
    CGPoint point2 = [(UITouch *)[allTouches objectAtIndex:2] locationInView:self.view];
    CGPoint point3 = [(UITouch *)[allTouches objectAtIndex:3] locationInView:self.view];
    CGPoint point4 = [(UITouch *)[allTouches objectAtIndex:4] locationInView:self.view];
    self.star = [self.star drawWithPoints:[NSArray arrayWithObjects:
                                           [NSValue valueWithCGPoint:point0],
                                           [NSValue valueWithCGPoint: point1],
                                           [NSValue valueWithCGPoint:point2],
                                           [NSValue valueWithCGPoint:point3],
                                           [NSValue valueWithCGPoint:point4], nil]];
    [self.rootLayer addSublayer:self.star.layer];
}



#pragma mark - Utils

-(void)clearCanvas
{
    for (CALayer *layer in self.rootLayer.sublayers) {
        [layer removeFromSuperlayer];
        // Copy the object layer and delete the
    }
    // Also unnecessary if the current layer will just stay; on object death.
    // Objects die when user lets go, we'll need to call something for that.
//    [self.rootLayer removeFromSuperlayer];
//    self.rootLayer = [CALayer layer];
//    self.rootLayer.frame = self.view.bounds;
//    [self.view.layer addSublayer:self.rootLayer];
//    self.carpet = nil;
//    self.sierpinski = nil;
//    self.levy = nil; 
    // [self.levy clearLayers];
}

@end
