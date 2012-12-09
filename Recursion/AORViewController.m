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
#import <QuartzCore/QuartzCore.h>

@interface AORViewController ()
@property (strong, nonatomic) CALayer *rootLayer;
@property (strong, nonatomic) CAShapeLayer *shapeLayer;
@property CGMutablePathRef linePath;
@property (strong, nonatomic) AORSierpinski *sierpinski;
@property (strong, nonatomic) AORStar *star;
@property (strong, nonatomic) AORCarpet *carpet;
@end

@implementation AORViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set up the root layer.
    self.rootLayer	= [CALayer layer];
	self.rootLayer.frame = self.view.bounds;
	[self.view.layer addSublayer:self.rootLayer];
    
    // Set up line path and shape layer.
    [self setUpLinePathAndShapeLayer];
    
    //for testing star
    self.star = [[AORStar alloc] initWithShapeLayer:self.shapeLayer linePath:self.linePath];
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
    [self.star drawWithPoints:points depth:6];*/
    
    //for testing carpet
    self.carpet = [[AORCarpet alloc] initWithShapeLayer:self.shapeLayer linePath:self.linePath];
    CGPoint p1 = CGPointMake(200.0, 200.0);
    CGPoint p2 = CGPointMake(600.0, 200.0);
    CGPoint p3 = CGPointMake(600.0, 600.0);
    CGPoint p4 = CGPointMake(200.0, 600.0);
    [self.carpet drawWithP1:p1 p2:p2 p3:p3 p4:p4 depth:5];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Touch Handling

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    // Set up line path and shape layer.
    [self setUpLinePathAndShapeLayer];

    switch ([[event allTouches] count]) {
        case 1:
            // This should be not a Sierpinski.
            self.sierpinski = [[AORSierpinski alloc] initWithShapeLayer:self.shapeLayer linePath:self.linePath];
            [self.sierpinski drawWithP1:point p2:CGPointMake(800.0, 800.0) p3:CGPointMake(300.0, 150.0) depth:5];
            break;
        case 2:
            // This should also be not a Sierpinski.
            self.sierpinski = [[AORSierpinski alloc] initWithShapeLayer:self.shapeLayer linePath:self.linePath];
            [self.sierpinski drawWithP1:point p2:CGPointMake(800.0, 800.0) p3:CGPointMake(300.0, 150.0) depth:5];
        case 3:
            // Draw Sierpinski
            self.sierpinski = [[AORSierpinski alloc] initWithShapeLayer:self.shapeLayer linePath:self.linePath];
            [self.sierpinski drawWithP1:point p2:CGPointMake(800.0, 800.0) p3:CGPointMake(300.0, 150.0) depth:5];
        case 4:
            // This should also be not a Sierpinski.
            self.sierpinski = [[AORSierpinski alloc] initWithShapeLayer:self.shapeLayer linePath:self.linePath];
            [self.sierpinski drawWithP1:point p2:CGPointMake(800.0, 800.0) p3:CGPointMake(300.0, 150.0) depth:5];
        case 5:
            // This should be the star.
            self.sierpinski = [[AORSierpinski alloc] initWithShapeLayer:self.shapeLayer linePath:self.linePath];
            [self.sierpinski drawWithP1:point p2:CGPointMake(800.0, 800.0) p3:CGPointMake(300.0, 150.0) depth:5];
        default:
            break;
    }
}

#pragma mark - Utils

-(void)setUpLinePathAndShapeLayer
{
    // Set up the line path.
    self.linePath = CGPathCreateMutable();
    
    // Set up shape layer.
    [self.shapeLayer removeFromSuperlayer];
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.path = self.linePath;
	UIColor *strokeColor = [UIColor colorWithRed:0.2 green:.6313 blue:.7882 alpha:1.0];
	self.shapeLayer.strokeColor = strokeColor.CGColor;
	self.shapeLayer.lineWidth = 1.5;
    UIColor *fillColor = [UIColor darkGrayColor];
    self.shapeLayer.fillColor = fillColor.CGColor;
	self.shapeLayer.fillRule = kCAFillRuleNonZero;
	[self.rootLayer addSublayer:self.shapeLayer];
}
@end
