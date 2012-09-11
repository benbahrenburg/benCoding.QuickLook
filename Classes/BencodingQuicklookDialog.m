///**
// * benCoding.QuickLook 
// * Copyright (c) 2009-2012 by Ben Bahrenburg. All Rights Reserved.
// * Licensed under the terms of the Apache Public License
// * Please see the LICENSE included with this distribution for details.
// */
//
//#import "BencodingQuicklookDialog.h"
//#import "TiApp.h"
//
//BOOL statusBarHiddenOldValue = NO;
//BOOL allowRotate = NO;
//
//@implementation QLPreviewController (AutoRotation)
//
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//    if(allowRotate==NO)
//    {
//        return NO;
//    }
//    else
//    {
//        //Check if the orientation is supported in the Tiapp.xml settings
//        BOOL canRotate = [[[TiApp app] controller] shouldAutorotateToInterfaceOrientation:interfaceOrientation];
//        //If it is supported, we need to move the entire app. 
//        //Without doing this, our keyboard wont reposition itself
//        if(canRotate==YES)
//        {
//            [[UIApplication sharedApplication] setStatusBarOrientation:interfaceOrientation animated:NO];
//        }
//        //We tell the app if we can rotate, ie is this a support orientation
//        return canRotate;        
//    }
//}
//
//@end
//
//@implementation BencodingQuicklookDialog
//
//-(void)setAllowRotate:(id)args
//{
//    allowRotate=[TiUtils boolValue:[self valueForUndefinedKey:@"allowRotate"] def:NO];
//}
//
//-(void)open:(id)args
//{    
//    showAnimated=YES; //Force reset in case dev wants to toggle
//    
//    //Check the QuickLook class exists
//    if(NSClassFromString(@"QLPreviewController")==nil)
//    {
//        return;
//    }
//
//	//We need to do a few checks here to figure out what to do
//    //This check is due to some side effects
//    if((args ==nil)||([args count] == 0))
//    {
//        //If no arguments are passed we need to take a different action
//        ENSURE_TYPE_OR_NIL(args,NSDictionary);
//    }
//    else        
//    {
//        //If there are agruments we need to do this
//        //Get the user's animated option if provided
//        ENSURE_SINGLE_ARG(args,NSDictionary);
//        showAnimated = [TiUtils boolValue:@"animated" properties:args def:YES];
//    }
//    
//	//Class arrayClass = [NSArray class];
//	//NSArray * toArray = [self valueForUndefinedKey:@"toRecipients"];
//    //ENSURE_CLASS_OR_NIL(toArray,arrayClass);
//    
//    //Make sure we're on the UI thread, this stops bad things
//	ENSURE_UI_THREAD(open,args);
//    
//    previewController = [[BCFileViewerDialog alloc] init];
//    
//    //Check if we need to hide the statusbar
//    BOOL statusBarHidden = [TiUtils boolValue:[self valueForUndefinedKey:@"statusBarHidden"] def:NO];
//    
//    //If we are hiding the statusbar we perform the below
//    if(statusBarHidden==YES)
//    {
//        //Set our dialog to full screen 
//        previewController.wantsFullScreenLayout = NO;  
//        //Get the existing statusbar value so we can reset it later on
//        statusBarHiddenOldValue = [UIApplication sharedApplication].statusBarHidden;
//    }
//    
//    //See if we need to do anything with the barColor
//    UIColor * barColor = [[TiUtils colorValue:[self valueForUndefinedKey:@"barColor"]] _color];
//    if (barColor != nil)
//    {
//        [previewController setTintColor:barColor]; 
//    }
//    
//    BOOL displayActionButton = [TiUtils boolValue:[self valueForUndefinedKey:@"showActionButton"] def:YES];
//    previewController.showActionButton=displayActionButton; 
//    
//    [self retain];
//    
//    //We call into core TiApp module this handles the controller magic for us        
//    [[TiApp app] showModalController:previewController animated:showAnimated]; 
//    
//    //If we are hiding the statusbar we need to do it after it is presented
//    if(statusBarHidden==YES)
//    {
//        //We need to hide the statusbar for the full app
//        [[UIApplication sharedApplication] setStatusBarHidden:YES];
//        [[[TiApp app] controller] resizeViewForStatusBarHidden:YES];
//    }
//    
//}
//
//- (void) BCFileViewerDialogClosed
//{
//    RELEASE_TO_NIL(previewController);
//}
///*---------------------------------------------------------------------------
// *  
// *--------------------------------------------------------------------------*/
//- (NSInteger) numberOfPreviewItemsInPreviewController: (QLPreviewController *) controller 
//{
//    if(previewDocuments==nil)
//    {
//        return 0;
//    }
//    else
//    {
//        return [previewDocuments count];
//    }
//}
//
///*---------------------------------------------------------------------------
// *  
// *--------------------------------------------------------------------------*/
//- (id <QLPreviewItem>)previewController: (QLPreviewController *)controller previewItemAtIndex:(NSInteger)index 
//{    
//    NSLog(@"Document Index Recieved: %d", index);
//    if(previewDocuments==nil)
//    {
//        return nil;
//    }
//    if([previewDocuments count]==0)
//    {
//        return nil;
//    }
//    if((index<0) || (index>([previewDocuments count]-1)))
//    {
//        return nil;
//    }
//    
//    NSString* providedPath = [previewDocuments objectAtIndex: index];    
//    NSURL* filePath = [TiUtils toURL:providedPath proxy:self];
//    //NSLog(@"Our file path %@", [filePath path]);
//    
//    if ([QLPreviewController canPreviewItem:[NSURL fileURLWithPath:[filePath path]]]) 
//    {
//        return [NSURL fileURLWithPath:[filePath path]]; 
//        
//    }else
//    {
//        return nil;
//    }
//    
//}
//
///*---------------------------------------------------------------------------
// *  
// *--------------------------------------------------------------------------*/
//@end
