/**
 * benCoding.QuickLook 
 * Copyright (c) 2009-2012 by Ben Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "BencodingQuicklookView.h"

@implementation BencodingQuicklookView

-(void)dealloc
{
	// Release objects and memory allocated by the view
    RELEASE_TO_NIL(previewController);
	RELEASE_TO_NIL(QLView);
    RELEASE_TO_NIL(previewDocuments);
	[super dealloc];
}

-(void) initQuickLook
{
	if (QLView == nil) {
        previewController = [[QLPreviewController alloc] init];
        previewController.dataSource = self;
        //previewController.delegate = self;
        
        previewController.view.frame = CGRectMake(0, 0,self.frame.size.width, self.frame.size.height);
        [previewController reloadData];
        [[previewController view]setNeedsLayout];
        [[previewController view ]setNeedsDisplay];
        [previewController refreshCurrentPreviewItem];
        QLView = previewController.view;
        [self addSubview:QLView];     
	}    
}

-(UIView*)QLView
{
	if (QLView == nil) {
        [self initQuickLook];
	}
    
	return QLView;
}

-(void) refreshCurrentPreviewItem:(id)value
{
    if(previewController!=nil)
    {
        [previewController refreshCurrentPreviewItem];
    }    
}

-(void) reloadData :(id)value
{
    if(previewController!=nil)
    {
        [previewController reloadData];
    }
}

-(void)setDocuments_:(id)args
{
    ENSURE_TYPE_OR_NIL(args,NSArray);
    
    RELEASE_TO_NIL(previewDocuments);
    
    if(args!=nil)
    {
        previewDocuments = [args mutableCopy];    
    }
    
    if (previewController == nil) 
    {
        [self initQuickLook];
    }   
    
}
-(void)setIndex_:(id)indexValue
{
    if (previewController == nil) 
    {
        [self initQuickLook];
    }     
    
    if(previewDocuments!=nil)
    {
        NSInteger newIndex = [TiUtils intValue:indexValue def:0];
        //NSLog(@"setIndex_: %d", newIndex);
        //Check that we are within range
        if((newIndex>=0) && (newIndex<=([previewDocuments count]-1)))
        {
            //Check we are not trying to update the same value again
            if([previewController currentPreviewItemIndex]!=newIndex)
            {
                [previewController setCurrentPreviewItemIndex:newIndex];         
            }               
        }
        
    }    
}

-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{    
	if (QLView != nil) {
		[TiUtils setView:QLView positionRect:bounds];
	}
}

-(void)setColor_:(id)color
{
	// Use the TiUtils methods to get the values from the arguments
	TiColor *newColor = [TiUtils colorValue:color];
	UIColor *clr = [newColor _color];
	UIView *ql = [self QLView];
	ql.backgroundColor = clr;
}

/*---------------------------------------------------------------------------
 *  
 *--------------------------------------------------------------------------*/
- (NSInteger) numberOfPreviewItemsInPreviewController: (QLPreviewController *) controller 
{
    if(previewDocuments==nil)
    {
        return 0;
    }
    else
    {
        return [previewDocuments count];
    }
}

/*---------------------------------------------------------------------------
 *  
 *--------------------------------------------------------------------------*/
- (id <QLPreviewItem>)previewController: (QLPreviewController *)controller previewItemAtIndex:(NSInteger)index 
{    
    NSLog(@"Document Index Recieved: %d", index);
    if(previewDocuments==nil)
    {
        return nil;
    }
    if([previewDocuments count]==0)
    {
        return nil;
    }
    if((index<0) || (index>([previewDocuments count]-1)))
    {
        return nil;
    }
    
    NSString* providedPath = [previewDocuments objectAtIndex: index];    
    NSURL* filePath = [TiUtils toURL:providedPath proxy:self.proxy];
    //NSLog(@"Our file path %@", [filePath path]);
    
    if ([QLPreviewController canPreviewItem:[NSURL fileURLWithPath:[filePath path]]]) 
    {
        return [NSURL fileURLWithPath:[filePath path]]; 
        
    }else
    {
        return nil;
    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
/*---------------------------------------------------------------------------
 *  
 *--------------------------------------------------------------------------*/


@end
