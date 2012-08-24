/**
 * benCoding.QuickLook 
 * Copyright (c) 2009-2012 by Ben Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiUIView.h"
#import <QuickLook/QuickLook.h>

@interface BencodingQuicklookView : TiUIView<QLPreviewControllerDataSource> {
@private
    //UIView *QLView;
    QLPreviewController *previewController;
    NSMutableArray *previewDocuments;
}
//@property(strong, nonatomic) QLPreviewController* previewController;
-(void) refreshCurrentPreviewItem;
-(void) reloadData;

-(NSInteger) numberOfPreviewItemsInPreviewController: (QLPreviewController *) controller;
- (id <QLPreviewItem>) previewController: (QLPreviewController *) controller previewItemAtIndex: (NSInteger) index;

@end
