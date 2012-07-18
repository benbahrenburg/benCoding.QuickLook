/**
 * benCoding.QuickLook 
 * Copyright (c) 2009-2012 by Ben Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "BencodingQuicklookViewProxy.h"
#import "TiUtils.h"

@implementation BencodingQuicklookViewProxy

NSArray* QLKeySequence;

-(NSArray *)keySequence
{
	if (QLKeySequence == nil)
	{
		QLKeySequence = [[NSArray arrayWithObjects:@"documents",nil] retain];
	}
	return QLKeySequence;
}

@end
