/**
 * benCoding.QuickLook 
 * Copyright (c) 2009-2012 by Ben Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "BencodingQuicklookModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation BencodingQuicklookModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"dd0b3580-d441-4b06-be4b-17726b570d2a";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"bencoding.quicklook";
}


-(NSNumber*) isSupported 
{
	return NUMBOOL((nil != NSClassFromString(@"QLPreviewController")));
}

@end
