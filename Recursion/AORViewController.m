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
@property (strong, nonatomic) AOROneTouch *oneTouch;
@end

@implementation AORViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set up the root layer.
    self.rootLayer	= [CALayer layer];
	self.rootLayer.frame = self.view.bounds;
	[self.view.layer addSublayer:self.rootLayer];
    
    self.levy = [AORLevy alloc];
    self.sierpinski = [AORSierpinski alloc];
    self.carpet = [AORCarpet alloc];
    self.star = [AORStar alloc];
    self.oneTouch = [AOROneTouch alloc];

    //for testing star
    // self.star = [[AORStar alloc] initWithShapeLayer:self.shapeLayer linePath:self.linePath];
    /*
    [self.star drawWithPoints:points depth:6];*/
    
        
//[self.rootLayer addSublayer:[AORExamples drawSierpinski]];
//[ self.rootLayer addSublayer:[AORExamples drawCarpet]];
[self.rootLayer addSublayer:[AORExamples drawStar]];
 //   [ self.rootLayer addSublayer:[AORExamples drawOneTouch]];
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
    [self.oneTouch initWithP1:point0 bounds:CGRectMake(0.0, 0.0, 755.0, 1024.0)];
    [self.rootLayer addSublayer:self.oneTouch.layer];
}

-(void)handleTwoPoints:(NSArray *)allTouches
{
    CGPoint point0 = [(UITouch *)[allTouches objectAtIndex:0] locationInView:self.view];
    CGPoint point1 = [(UITouch *)[allTouches objectAtIndex:1] locationInView:self.view];
    [self.levy initWithP1:point0 p2:point1];
    [self.rootLayer addSublayer:self.levy.layer];
    
}

-(void)handleThreePoints:(NSArray *)allTouches
{
    CGPoint point0 = [(UITouch *)[allTouches objectAtIndex:0] locationInView:self.view];
    CGPoint point1 = [(UITouch *)[allTouches objectAtIndex:1] locationInView:self.view];
    CGPoint point2 = [(UITouch *)[allTouches objectAtIndex:2] locationInView:self.view];
    [self.sierpinski initWithP1:point0 p2:point1 p3:point2];
    [self.rootLayer addSublayer:self.sierpinski.layer];
}

-(void)handleFourPoints:(NSArray *)allTouches
{
    CGPoint point0 = [(UITouch *)[allTouches objectAtIndex:0] locationInView:self.view];
    CGPoint point1 = [(UITouch *)[allTouches objectAtIndex:1] locationInView:self.view];
    CGPoint point2 = [(UITouch *)[allTouches objectAtIndex:2] locationInView:self.view];
    CGPoint point3 = [(UITouch *)[allTouches objectAtIndex:3] locationInView:self.view];
    [self.carpet initWithP1:point0 p2:point1 p3:point2 p4:point3];
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
    for (CALayer *layer in self.rootLayer.sublayers) {
        [layer removeFromSuperlayer];
    }
    [self.levy clearLayers];
}

@end
