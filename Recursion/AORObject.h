//
//  AORObject.h
//  Recursion
//
//  Created by Mishal Awadah on 12/9/12.
//  Copyright (c) 2012 CIS 399 Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreImage/CoreImage.h>

@interface AORObject : NSObject
@property (strong, nonatomic) CAShapeLayer *layer;
/* Stores all paths for this shape. */
@property NSArray *paths;
/* The animations of each path */
@property CAAnimationGroup *pathAnimations;
/* The recursively created drawings */
@property NSArray *children;
/* The depth of this drawing */
@property int depth;
@property (atomic) BOOL animationStopped;
@property NSArray *theme;
/* If our object were represented by a single path, this 
 * would be it */
@property CGMutablePathRef path;
/* TODO: Ideally, this class method will create the appropriate
 * objects given the number of points. */
+ (AORObject *)objectFromPoints:(NSArray *) points;
/* Call this method after initializing your shape's points. */
- (id)configureShape;
- (void)setAnimationForPathLayer:(CAShapeLayer *)pathLayer;
@end

@protocol AORObjectProtocol <NSObject>
/* How to draw the shape */
- (void)defineShapePath;
/* How to draw the children */
- (void)defineChildren;
@end

/* Returns a CGPathRef configured to draw from p1 to p2. */
CGMutablePathRef createPathFromPoints(CGPoint p1, CGPoint p2);
/* Augments an existing CGPathRef to draw differently.
 * THIS DOES NOT WORK ON PATHS APPARENTLY.
 */
void augmentPath(CGMutablePathRef path, CGPoint p1, CGPoint p2);
