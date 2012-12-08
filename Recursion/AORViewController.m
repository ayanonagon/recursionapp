//
//  AORViewController.m
//  Recursion
//
//  Created by Ayaka Nonaka on 12/7/12.
//  Copyright (c) 2012 CIS 399 Project. All rights reserved.
//

#import "AORViewController.h"
#import "AORSierpinski.h"
#import <QuartzCore/QuartzCore.h>

@interface AORViewController ()
@property (strong, nonatomic) CALayer *rootLayer;
@property (strong, nonatomic) CAShapeLayer *shapeLayer;
@property CGMutablePathRef linePath;
@property (strong, nonatomic) AORSierpinski *sierpinski;
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
    
    // Set up drawing classes.
    self.sierpinski = [[AORSierpinski alloc] initWithShapeLayer:self.shapeLayer linePath:self.linePath];
    [self.sierpinski drawWithP1:CGPointMake(100.0, 800.0) p2:CGPointMake(800.0, 800.0) p3:CGPointMake(300.0, 150.0) depth:5];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark Touch Handling

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    // Set up line path and shape layer.
    [self setUpLinePathAndShapeLayer];
    
    // Set up drawing classes.
    self.sierpinski = [[AORSierpinski alloc] initWithShapeLayer:self.shapeLayer linePath:self.linePath];
    
    [self.sierpinski drawWithP1:point p2:CGPointMake(800.0, 800.0) p3:CGPointMake(300.0, 150.0) depth:5];
    [self.shapeLayer setNeedsDisplay];
}

# pragma mark Utils

-(void)setUpLinePathAndShapeLayer
{
    // Set up the line path.
    self.linePath = CGPathCreateMutable();
    
    // Set up shape layer.
    [self.shapeLayer removeFromSuperlayer];
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.path = self.linePath;
	UIColor *strokeColor = [UIColor blackColor];
	self.shapeLayer.strokeColor = strokeColor.CGColor;
	self.shapeLayer.lineWidth = 2.0;
    UIColor *fillColor = [UIColor darkGrayColor];
    self.shapeLayer.fillColor = fillColor.CGColor;
	self.shapeLayer.fillRule = kCAFillRuleNonZero;
	[self.rootLayer addSublayer:self.shapeLayer];
}
@end
