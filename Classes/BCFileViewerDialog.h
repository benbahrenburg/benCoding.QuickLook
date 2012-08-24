/**
 * benCoding.QuickLook 
 * Copyright (c) 2009-2012 by Ben Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import <Foundation/Foundation.h>
#import <QuickLook/QuickLook.h>

@protocol BCFileViewerDialogDelegate <NSObject>
@required
- (void) BCFileViewerDialogClosed;
@end

@interface BCFileViewerDialog : QLPreviewController{
    id <BCFileViewerDialogDelegate> closeDelegate;    
@private 
    UIColor* navBarTintColor;
}

@property(readwrite, nonatomic) BOOL showActionButton;
@property (retain) id closeDelegate;

- (void)setTintColor:(UIColor*)Color;

@end
