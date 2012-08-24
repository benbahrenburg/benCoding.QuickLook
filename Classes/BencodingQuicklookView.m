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
//	RELEASE_TO_NIL(QLView);
    RELEASE_TO_NIL(previewDocuments);
	[super dealloc];
}

-(void) initQuickLook
{
	if (previewController == nil) {
        //previewDocuments = [NSArray arrayWithObject:@"test.pdf"];
        previewController = [[[QLPreviewController alloc] init] retain];
        previewController.dataSource = self;
        //previewController.delegate = self;
      
        [TiUtils setView:[previewController view] positionRect:self.bounds];
        
        [self addSubview:[previewController view]];
        
        [previewController reloadData];
	}    
}


-(void) refreshCurrentPreviewItem
{
    if(previewController!=nil)
    {
        [previewController refreshCurrentPreviewItem];
    }    
}


-(void) reloadData
{
    if(previewController!=nil)
    {
        [previewController reloadData];
    }
}

-(void)setEnabled_:(id)value
{
    BOOL newValue = [TiUtils boolValue:value def:YES];

    if (previewController == nil) 
    {
        [self initQuickLook];
    }

    [previewController view].userInteractionEnabled=newValue;

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
    else
    {
        //NSLog(@"Load called X ");
       [previewController reloadData]; 
    }
    
   // NSLog(@"X Document Count: %d", [previewDocuments count]);
    
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
                //NSLog(@"new index set: %d", newIndex);
                [previewController setCurrentPreviewItemIndex:newIndex];         
            }               
        }
        
    }    
}

-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{   
    if (previewController != nil) 
    {
        self.frame = CGRectIntegral(self.frame);
        [TiUtils setView:[previewController view] positionRect:bounds];
        [super frameSizeChanged:frame bounds:bounds];
    } 
}


/*---------------------------------------------------------------------------
 *  
 *--------------------------------------------------------------------------*/
#pragma mark - delegate methods


//- (BOOL)previewController:(QLPreviewController *)controller shouldOpenURL:(NSURL *)url forPreviewItem:(id <QLPreviewItem>)item
//{
//    return YES;
//}
//
//- (CGRect)previewController:(QLPreviewController *)controller frameForPreviewItem:(id <QLPreviewItem>)item inSourceView:(UIView **)view
//{
//    
//    //Rectangle of the button which has been pressed by the user
//    //Zoom in and out effect appears to happen from the button which is pressed.
//    //UIView *view1 = [[previewController view] viewWithTag:currentPreviewIndex+1];
//    return [previewController view].frame; 
//}
- (NSInteger) numberOfPreviewItemsInPreviewController: (QLPreviewController *) controller 
{

    if(previewDocuments==nil)
    {
        //NSLog(@"documents nil returning zero");
        return 0;
    }
    else
    {
        //NSLog(@"returning document count of : %d", [previewDocuments count]);
        return [previewDocuments count];
    }
}

/*---------------------------------------------------------------------------
 *  
 *--------------------------------------------------------------------------*/
- (id <QLPreviewItem>)previewController: (QLPreviewController *)controller previewItemAtIndex:(NSInteger)index 
{    
   // NSLog(@"Document Index Recieved: %d", index);
    if(previewDocuments==nil)
    {
        NSLog(@"No documents provided for display");
        return nil;
    }
    if([previewDocuments count]==0)
    {
        NSLog(@"No documents available to display");
        return nil;
    }
    if((index<0) || (index>([previewDocuments count]-1)))
    {
        NSLog(@"Index provided not in range");
        return nil;
    }
    
    NSString* providedPath = [previewDocuments objectAtIndex: index];    
    NSURL* filePath = [TiUtils toURL:providedPath proxy:self.proxy];
  
    if ([QLPreviewController canPreviewItem:[NSURL fileURLWithPath:[filePath path]]]) 
    {
         //NSLog(@"Our file path %@", [filePath path]);
        return [NSURL fileURLWithPath:[filePath path]]; 
        
    }else
    {
        NSLog(@"Can't read file path %@", [filePath path]);
        return nil;
    }
    
}

/*---------------------------------------------------------------------------
 *  
 *--------------------------------------------------------------------------*/

@end
