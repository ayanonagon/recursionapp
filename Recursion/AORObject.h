//
//  AORObject.h
//  Recursion
//
//  Created by Mishal Awadah on 12/9/12.
//  Copyright (c) 2012 CIS 399 Project. All rights reserved.
//

/**
 * This object is the parent of all drawn objects. It provides
 * the necessary utilities and helper functions that manage layers and
 * paths, and perform animations.
 */

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreImage/CoreImage.h>

@interface AORObject : NSObject
@property (strong, nonatomic) CAShapeLayer *layer;
@property NSArray *paths;       /**< Stores all paths for this shape. */
@property CAAnimationGroup *pathAnimations; /**< The animations of each path */
@property NSArray *children;    /**< The recursively created drawings */
@property int depth;            /**< The depth of this drawing */
@property (atomic) BOOL animationStopped;
@property NSArray *theme;
@property CGMutablePathRef path; /**< Path representing this drawn object. */
/* TODO: Ideally, this class method will create the appropriate
 * objects given the number of points. */
// + (AORObject *)objectFromPoints:(NSArray *) points;

/* Call this method after initializing your shape's points. It must be called
 * on every redraw. */
- (id)configureShape;

/* Internal helper function provided publicly for hacking around reasons. */
- (void)setAnimationForPathLayer:(CAShapeLayer *)pathLayer;
@end

@protocol AORObjectProtocol <NSObject>
/* How to draw the shape. MUST OVERRIDE */
- (void)defineShapePath;
/* How to draw the children. MUST OVERRIDE */
- (void)defineChildren;
@end

/* Utility function that returns a CGPathRef configured to draw from p1 to p2. */
CGMutablePathRef createPathFromPoints(CGPoint p1, CGPoint p2);
