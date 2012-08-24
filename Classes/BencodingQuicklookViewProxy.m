/**
 * benCoding.QuickLook 
 * Copyright (c) 2009-2012 by Ben Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "BencodingQuicklookViewProxy.h"
#import "TiUtils.h"

@implementation BencodingQuicklookViewProxy

-(void)reloadData:(id)args
{
    if ([self viewAttached]) {
        TiThreadPerformOnMainThread(^{[(BencodingQuicklookView*)[self view] reloadData];}, NO);
	}
}

-(void)refreshCurrentPreviewItem:(id)args
{
    if ([self viewAttached]) {
        TiThreadPerformOnMainThread(^{[(BencodingQuicklookView*)[self view] refreshCurrentPreviewItem];}, NO);
	}
}

@end
