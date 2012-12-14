//
//  AORStar.h
//  Recursion
//
//  Created by Elissa Wolf on 12/8/12.
//  Copyright (c) 2012 CIS 399 Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AORObject.h"

#define STAR_MAX_DEPTH 5

@interface AORStar : AORObject <AORObjectProtocol>
- (id)init;
- (id)drawWithPoints:(NSArray *)points;
@end
