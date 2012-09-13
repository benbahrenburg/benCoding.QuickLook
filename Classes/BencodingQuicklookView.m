/**
 * benCoding.QuickLook 
 * Copyright (c) 2009-2012 by Ben Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "BencodingQuicklookView.h"
#import "TiUtils.h"
@implementation BencodingQuicklookView
@synthesize previewDocuments;

bool enabledLogMode = NO;

-(QLPreviewController*) previewController
{
    if(enabledLogMode)
    {
        NSLog(@"previewController");
    }
    if(previewController==nil)
    {
        if(enabledLogMode)
        {
            NSLog(@"Creating controller instance");
        }
        previewController = [[[QLPreviewController alloc] init] retain];
        previewController.dataSource = self;
    }
    return previewController;
}

-(void)dealloc
{
	// Release objects and memory allocated by the view
    RELEASE_TO_NIL(previewController);
	RELEASE_TO_NIL(QLView);
    RELEASE_TO_NIL(previewDocuments);
	[super dealloc];
}

-(void) broadcastEventItem:(NSString*)eventToCall msg:(NSString*)msg
{
    if ([self.proxy _hasListeners:eventToCall]) {
        NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:
                               msg,@"message",
                               nil
                               ];
        
        [self.proxy fireEvent:eventToCall withObject:event];
    }
}

-(void) broadcastEventItemWithFile:(NSString*)eventToCall file:(NSString*)file msg:(NSString*)msg
{
    if ([self.proxy _hasListeners:eventToCall]) {
        NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:
                               msg,@"message",
                               file,@"file",
                               nil
                               ];
        
        [self.proxy fireEvent:eventToCall withObject:event];
    }
}

-(void)render
{
    if(enabledLogMode)
    {
        NSLog(@"render");
    }
    if(QLView==nil)
    {
        if(enabledLogMode)
        {
            NSLog(@"Creating view instance");
        }
        QLView = [[[self previewController] view] retain];
        [TiUtils setView:QLView positionRect:self.bounds];
        [self addSubview:QLView];
    }
}

-(UIView*) QLView
{
    if(enabledLogMode)
    {
        NSLog(@"in QLView");
    }
    [self render];
    return QLView;
}

-(void) pushDocuments:(NSArray*)value
{
    if(enabledLogMode)
    {
        NSLog(@"pushDocuments");
    }
    if(value!=nil)
    {
        RELEASE_TO_NIL(previewDocuments);
        if(enabledLogMode)
        {
            NSLog(@"pushDocuments copy");
        }
        previewDocuments = [[value mutableCopy] retain];
        if(enabledLogMode)
        {
            NSLog(@"pushDocuments reload");
        }
        [[self previewController] reloadData];
        if(enabledLogMode)
        {
            NSLog(@"pushDocuments Count: %d", [previewDocuments count]);
        }
        [self broadcastEventItem:@"dataChange"
                             msg:[NSMutableString stringWithFormat:@"%d documents loaded",[previewDocuments count]]];
    }
    
}

-(void) refreshCurrentPreviewItem
{
    if(enabledLogMode)
    {
        NSLog(@"refreshCurrentPreviewItem");
    }
    [[self previewController] refreshCurrentPreviewItem];
}


-(void) reloadData
{
    if(enabledLogMode)
    {
        NSLog(@"reloadData");
    }
    [[self previewController] reloadData];
}

-(void)setEnabled_:(id)value
{
    if(enabledLogMode)
    {
        NSLog(@"setEnabled_");
    }
    BOOL newValue = [TiUtils boolValue:value def:YES];
    [self QLView].userInteractionEnabled=newValue;

}   
    
-(void)setDocuments_:(id)args
{
    ENSURE_TYPE_OR_NIL(args,NSArray);
    ENSURE_UI_THREAD(setDocuments_,args)
    RELEASE_TO_NIL(previewDocuments);
    if(enabledLogMode)
    {
        NSLog(@"setDocuments_");
    }
    if(args!=nil)
    {
        if (previewDocuments==nil)
        {
            previewDocuments = [[[NSMutableArray alloc] initWithObjects:args,nil] retain];
        }

        [self render];
        
        if(enabledLogMode)
        {
            NSLog(@"setDocuments_ Count: %d", [previewDocuments count]);
        }
        [self broadcastEventItem:@"dataChange"
                             msg:[NSMutableString stringWithFormat:@"%d documents loaded",[previewDocuments count]]];
    }
}
-(void)setEnableLogging_:(id)value
{
    NSLog(@"setEnableLogging_");
    enabledLogMode = [TiUtils boolValue:value def:YES];
}
-(void)setIndex_:(id)indexValue
{
    if(enabledLogMode)
    {
        NSLog(@"setIndex_");
    }
    if(previewDocuments!=nil)
    {
        NSInteger newIndex = [TiUtils intValue:indexValue def:0];
        if(enabledLogMode)
        {
            NSLog(@"setIndex_: %d", newIndex);
        }
        //Check that we are within range
        if((newIndex>=0) && (newIndex<=([previewDocuments count]-1)))
        {
            //Check we are not trying to update the same value again
            if([[self previewController] currentPreviewItemIndex]!=newIndex)
            {
                //NSLog(@"new index set: %d", newIndex);
                [[self previewController] setCurrentPreviewItemIndex:newIndex];
            }               
        }
    }
}


-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
    if(enabledLogMode)
    {
        NSLog(@"frameSizeChanged");
    }
    [TiUtils setView:[self QLView] positionRect:bounds];
    [super frameSizeChanged:frame bounds:bounds];
}


/*---------------------------------------------------------------------------
 *  
 *--------------------------------------------------------------------------*/
#pragma mark - delegate methods

- (NSInteger) numberOfPreviewItemsInPreviewController: (QLPreviewController *) controller 
{
    if(enabledLogMode)
    {
        NSLog(@"numberOfPreviewItemsInPreviewController");
    }
    if(previewDocuments==nil)
    {
        if(enabledLogMode)
        {
            NSLog(@"documents nil returning 1");
        }
        
        [self broadcastEventItem:@"error"
                             msg:@"Document source is nil"];
        return 1;
    }
    else
    {
        if([previewDocuments count]==0)
        {
            if(enabledLogMode)
            {
                NSLog(@"documents 0 returning 1");
            }
            [self broadcastEventItem:@"error"
                                  msg:@"Document source is empty"];
            return 1;
        }
        else
        {
            if(enabledLogMode)
            {
                NSLog(@"returning document count of : %d", [previewDocuments count]);
            }

            [self broadcastEventItem:@"previewItems"
                                 msg:[NSMutableString stringWithFormat:@"%d items to preview",
                                      [previewDocuments count]]];
            return [previewDocuments count];
        }
    }
}

/*---------------------------------------------------------------------------
 *  
 *--------------------------------------------------------------------------*/
- (id <QLPreviewItem>)previewController: (QLPreviewController *)controller previewItemAtIndex:(NSInteger)index 
{
    if(enabledLogMode)
    {
        NSLog(@"Document Index Recieved: %d", index);
    }
    if(previewDocuments==nil)
    {
        if(enabledLogMode)
        {
            NSLog(@"No documents provided for display");
        }
        [self broadcastEventItem:@"error"
                             msg:@"Document source is nil"];
        return nil;
    }
    if([previewDocuments count]==0)
    {
        if(enabledLogMode)
        {
            NSLog(@"No documents available to display");
        }
        [self broadcastEventItem:@"error"
                             msg:@"Document source is empty"];
        return nil;
    }
    if((index<0) || (index>([previewDocuments count]-1)))
    {
        if(enabledLogMode)
        {
            NSLog(@"Index provided not in range");
        }
        [self broadcastEventItem:@"error"
                             msg:@"Index provided not in range nil provided instead"];
        return nil;
    }
    
    NSString* providedPath = [previewDocuments objectAtIndex: index];
    NSURL* filePath = [TiUtils toURL:providedPath proxy:self.proxy];
  
    if ([QLPreviewController canPreviewItem:[NSURL fileURLWithPath:[filePath path]]]) 
    {
        if(enabledLogMode)
        {
            NSLog(@"Our file path %@", [filePath path]);
        }
        
        [self broadcastEventItemWithFile:@"docChanged"
                             file:[filePath path]
                             msg:[NSMutableString stringWithFormat:@"Viewing file %@",
                                  [filePath path]]];
        
        return [NSURL fileURLWithPath:[filePath path]];
        
    }else
    {
        if(enabledLogMode)
        {
            NSLog(@"Can't read file path %@", [filePath path]);
        }
        [self broadcastEventItemWithFile:@"error"
                             file:[filePath path]
                             msg:[NSMutableString stringWithFormat:@"Unable to read file at path %@",
                                  [filePath path]]];
        return nil;
    }
}

/*---------------------------------------------------------------------------
 *  
 *--------------------------------------------------------------------------*/

@end
