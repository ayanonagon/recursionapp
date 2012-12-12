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
@property (strong, nonatomic) AORLevy *levy;
@property (strong, nonatomic) AORSierpinski *sierpinski;
@property (strong, nonatomic) AORCarpet *carpet;
@property (strong, nonatomic) AORStar *star;
<<<<<<< HEAD
@property (strong, nonatomic) NSMutableArray *objects;
=======
@property (strong, nonatomic) AOROneTouch *oneTouch;
>>>>>>> 47b70a7295d117ca80e238894544233d15c6e790
@end

@implementation AORViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Set up the root layer.
    self.rootLayer	= [CALayer layer];
<<<<<<< HEAD
    self.rootLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:self.rootLayer];

//    self.levy = [AORLevy alloc];
//    self.sierpinski = [AORSierpinski alloc];
//    self.carpet = [AORCarpet alloc];
//    self.star = [AORStar alloc];
=======
	self.rootLayer.frame = self.view.bounds;
	[self.view.layer addSublayer:self.rootLayer];
    
    self.levy = [AORLevy alloc];
    self.sierpinski = [AORSierpinski alloc];
    self.carpet = [AORCarpet alloc];
    self.star = [AORStar alloc];
    self.oneTouch = [AOROneTouch alloc];
>>>>>>> 47b70a7295d117ca80e238894544233d15c6e790

    //for testing star
    // self.star = [[AORStar alloc] initWithShapeLayer:self.shapeLayer linePath:self.linePath];
    /*
    [self.star drawWithPoints:points depth:6];*/
<<<<<<< HEAD

    //for testing carpet
    /*self.carpet = [[AORCarpet alloc] initWithShapeLayer:self.shapeLayer linePath:self.linePath];
    CGPoint p1 = CGPointMake(200.0, 200.0);
    CGPoint p2 = CGPointMake(600.0, 100.0);
    CGPoint p3 = CGPointMake(700.0, 600.0);
    CGPoint p4 = CGPointMake(400.0, 700.0);
    [self.carpet drawWithP1:p1 p2:p2 p3:p3 p4:p4 depth:5];*/

    //for testing levy
//    self.levy = [[AORLevy alloc] initWithShapeLayer:self.shapeLayer linePath:self.linePath];
//    CGPoint p1 = CGPointMake(200.0, 200.0);
//    CGPoint p2 = CGPointMake(500.0, 200.0);
//    [self.levy drawWithP1:p1 p2:p2 depth:15];
//[self.rootLayer addSublayer:[AORExamples drawSierpinski]];
//[ self.rootLayer addSublayer:[AORExamples drawCarpet]];
//[self.rootLayer addSublayer:[AORExamples drawStar]];
    //[self.rootLayer addSublayer:[AORExamples drawLevy]];
=======
    
        
//[self.rootLayer addSublayer:[AORExamples drawSierpinski]];
//[ self.rootLayer addSublayer:[AORExamples drawCarpet]];
[self.rootLayer addSublayer:[AORExamples drawStar]];
 //   [ self.rootLayer addSublayer:[AORExamples drawOneTouch]];
>>>>>>> 47b70a7295d117ca80e238894544233d15c6e790
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

-(void)handleOnePoint:(NSArray *)allTouches
{
    CGPoint point0 = [(UITouch *)[allTouches objectAtIndex:0] locationInView:self.view];
<<<<<<< HEAD
    self.carpet = [[AORCarpet alloc] initWithP1:point0 p2:CGPointMake(800.0, 800.0) p3:CGPointMake(300.0, 150.0) p4:CGPointMake(700.0, 700.0)];
    [self.rootLayer addSublayer:self.carpet.layer];
=======
    [self.oneTouch initWithP1:point0 bounds:CGRectMake(0.0, 0.0, 755.0, 1024.0)];
    [self.rootLayer addSublayer:self.oneTouch.layer];
>>>>>>> 47b70a7295d117ca80e238894544233d15c6e790
}

-(void)handleTwoPoints:(NSArray *)allTouches
{
    CGPoint point0 = [(UITouch *)[allTouches objectAtIndex:0] locationInView:self.view];
    CGPoint point1 = [(UITouch *)[allTouches objectAtIndex:1] locationInView:self.view];
    self.levy = [[AORLevy alloc] initWithP1:point0 p2:point1];
    [self.rootLayer addSublayer:self.levy.layer];

}

-(void)handleThreePoints:(NSArray *)allTouches
{
    CGPoint point0 = [(UITouch *)[allTouches objectAtIndex:0] locationInView:self.view];
    CGPoint point1 = [(UITouch *)[allTouches objectAtIndex:1] locationInView:self.view];
    CGPoint point2 = [(UITouch *)[allTouches objectAtIndex:2] locationInView:self.view];
    self.sierpinski = [[AORSierpinski alloc] initWithP1:point0 p2:point1 p3:point2];
    [self.rootLayer addSublayer:self.sierpinski.layer];
}

-(void)handleFourPoints:(NSArray *)allTouches
{
    CGPoint point0 = [(UITouch *)[allTouches objectAtIndex:0] locationInView:self.view];
    CGPoint point1 = [(UITouch *)[allTouches objectAtIndex:1] locationInView:self.view];
    CGPoint point2 = [(UITouch *)[allTouches objectAtIndex:2] locationInView:self.view];
    CGPoint point3 = [(UITouch *)[allTouches objectAtIndex:3] locationInView:self.view];
    self.carpet = [[AORCarpet alloc] initWithP1:point0 p2:point1 p3:point2 p4:point3];
    [self.rootLayer addSublayer:self.carpet.layer];
}

-(void)handleFivePoints:(NSArray *)allTouches
{
    CGPoint point0 = [(UITouch *)[allTouches objectAtIndex:0] locationInView:self.view];
    CGPoint point1 = [(UITouch *)[allTouches objectAtIndex:1] locationInView:self.view];
    CGPoint point2 = [(UITouch *)[allTouches objectAtIndex:2] locationInView:self.view];
    CGPoint point3 = [(UITouch *)[allTouches objectAtIndex:3] locationInView:self.view];
    CGPoint point4 = [(UITouch *)[allTouches objectAtIndex:4] locationInView:self.view];
    [self.sierpinski initWithP1:point0 p2:point1 p3:point2];
    [self.rootLayer addSublayer:self.sierpinski.layer];
}



#pragma mark - Utils

-(void)clearCanvas
{
//    for (CALayer *layer in self.rootLayer.sublayers) {
//        [layer removeFromSuperlayer];
//        // Copy the object layer and delete the
//    }
    // Also unnecessary if the current layer will just stay; on object death.
    // Objects die when user lets go, we'll need to call something for that.
    [self.rootLayer removeFromSuperlayer];
    self.rootLayer = [CALayer layer];
    self.rootLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:self.rootLayer];
    self.carpet = nil;
    self.sierpinski = nil;
    self.levy = nil; 
    // [self.levy clearLayers];
}

@end
