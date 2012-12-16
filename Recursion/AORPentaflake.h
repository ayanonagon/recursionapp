//
//  AORPentaflake.h
//  Recursion
//
//  Created by Elissa Wolf on 12/16/12.
//  Copyright (c) 2012 CIS 399 Project. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "AORObject.h"

#define PENTAFLAKE_MAX_DEPTH 3

@interface AORPentaflake : AORObject <AORObjectProtocol>
-(id)init;
- (id)drawWithPoints:(NSArray *)points;
- (id)drawWithPoints:(NSArray *)points depth:(int)depth;
@end