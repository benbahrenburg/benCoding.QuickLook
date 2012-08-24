/**
 * benCoding.QuickLook 
 * Copyright (c) 2009-2012 by Ben Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiProxy.h"
#import <QuickLook/QuickLook.h>
#import "BCFileViewerDialog.h"
@interface BencodingQuicklookDialog : TiProxy<QLPreviewControllerDataSource>  {
@private
    BOOL showAnimated;
    NSMutableArray *previewDocuments;
    BCFileViewerDialog *previewController;
}

@end
