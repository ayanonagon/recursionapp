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
#import <QuartzCore/QuartzCore.h>

@interface AORViewController ()
@property (strong, nonatomic) CALayer *rootLayer;
@property (strong, nonatomic) AORSierpinski *sierpinski;
@property (strong, nonatomic) AORStar *star;
@property (strong, nonatomic) AORCarpet *carpet;
@property (strong, nonatomic) AORLevy *levy;
@end

@implementation AORViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set up the root layer.
    self.rootLayer	= [CALayer layer];
	self.rootLayer.frame = self.view.bounds;
	[self.view.layer addSublayer:self.rootLayer];

    //for testing star
    // self.star = [[AORStar alloc] initWithShapeLayer:self.shapeLayer linePath:self.linePath];
    /*CGPoint p0 = CGPointMake(500, 500);
    CGPoint p1 = CGPointMake(600, 500);
    CGPoint p2 = CGPointMake(625, 575);
    CGPoint p3 = CGPointMake(550, 625);
    CGPoint p4 = CGPointMake(475, 575);
    CGPoint p0 = CGPointMake(400, 600);
    CGPoint p1 = CGPointMake(410, 600);
    CGPoint p2 = CGPointMake(412, 607.2);
    CGPoint p3 = CGPointMake(405, 612);
    CGPoint p4 = CGPointMake(398, 607.2);
    NSArray *points = [NSArray arrayWithObjects:
                       [NSValue valueWithCGPoint:p0],
                       [NSValue valueWithCGPoint:p1],
                       [NSValue valueWithCGPoint:p2],
                       [NSValue valueWithCGPoint:p3],
                       [NSValue valueWithCGPoint:p4],
                       nil];

    [self.star drawWithPoints:points depth:6];
    [self.star drawWithPoints:points depth:6];*/
    
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
    [self.rootLayer addSublayer:[AORExamples drawSierpinski]];
    [self.rootLayer addSublayer:[AORExamples drawCarpet]];
    [self.rootLayer addSublayer:[AORExamples drawLevy]];
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

#pragma mark - Drawing

-(void)handleOnePoint:(NSArray *)allTouches
{
    CGPoint point0 = [(UITouch *)[allTouches objectAtIndex:0] locationInView:self.view];
    self.sierpinski = [[AORSierpinski alloc] initWithP1:point0 p2:CGPointMake(800.0, 800.0) p3:CGPointMake(300.0, 150.0)];
    [self.rootLayer addSublayer:self.sierpinski.layer];
}

-(void)handleTwoPoints:(NSArray *)allTouches
{
    CGPoint point0 = [(UITouch *)[allTouches objectAtIndex:0] locationInView:self.view];
    CGPoint point1 = [(UITouch *)[allTouches objectAtIndex:1] locationInView:self.view];
    self.sierpinski = [[AORSierpinski alloc] initWithP1:point0 p2:point1 p3:CGPointMake(300.0, 150.0)];
    [self.rootLayer addSublayer:self.sierpinski.layer];
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
    self.sierpinski = [[AORSierpinski alloc] initWithP1:point0 p2:point1 p3:point2];
    [self.rootLayer addSublayer:self.sierpinski.layer];
}


#pragma mark - Utils

-(void)clearCanvas
{
    for (CALayer *layer in self.rootLayer.sublayers) {
        [layer removeFromSuperlayer];
    }
}

@end
