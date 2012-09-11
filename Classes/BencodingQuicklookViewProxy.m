/**
 * benCoding.QuickLook 
 * Copyright (c) 2009-2012 by Ben Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "BencodingQuicklookView.h"
#import "BencodingQuicklookViewProxy.h"
#import "TiUtils.h"

@implementation BencodingQuicklookViewProxy

-(NSArray *)keySequence
{
    return [NSArray arrayWithObjects:
            @"documents",
            @"index",
            nil];
}

-(void)_destroy
{
	RELEASE_TO_NIL(documentsToAdd);    
	[super _destroy];
}
-(void)viewDidAttach
{
    NSLog(@"in viewDidAttach");
    
    ENSURE_UI_THREAD_0_ARGS;
    BencodingQuicklookView * ourView = (BencodingQuicklookView *)[self view];
    
    //[ourView render];
    if(documentsToAdd!=nil)
    {
        [ourView pushDocuments:documentsToAdd];
    }
    
    RELEASE_TO_NIL(documentsToAdd);
    [super viewDidAttach];
}

-(void)setDocuments:(id)args
{
    ENSURE_TYPE(args,NSArray)

    NSLog(@"setDocuments Proxy");
    
    if(args!=nil)
    {
        BOOL attached = [self viewAttached];
        if (attached)
        {
            NSLog(@"setDocuments attached YES");
            TiThreadPerformOnMainThread(^{
                [(BencodingQuicklookView*)[self view] pushDocuments:args];
            }, YES);
            if(documentsToAdd!=nil)
            {
                RELEASE_TO_NIL(documentsToAdd);
            }
        }
        else {
            NSLog(@"setDocuments attached NO");
            documentsToAdd = [args mutableCopy];
            NSLog(@"setDocuments attached NO Count: %d", [documentsToAdd count]);
        }
    }
}

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
