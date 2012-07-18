/**
 * benCoding.QuickLook 
 * Copyright (c) 2009-2012 by Ben Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "BCFileViewerDialog.h"
#import "TiUtils.h"
@implementation BCFileViewerDialog
@synthesize showActionButton,closeDelegate;
- (id)init
{
    showActionButton=YES;
    return [super initWithNibName:@"BCFileViewerDialog" bundle:nil];
}


- (id)initWithNibName:(NSString *)name bundle:(NSBundle *)bundle
{
    showActionButton=YES;
    return [self init];
}

- (void)didReceiveMemoryWarning
{

    [super didReceiveMemoryWarning];

    RELEASE_TO_NIL(navBarTintColor);
    RELEASE_TO_NIL(closeDelegate);   
}

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSAssert(self.navigationController, @"BCFileViewerDialog must be in a nav controller.");
    
    if (navBarTintColor !=nil)
    {
        self.navigationController.navigationBar.tintColor = navBarTintColor;
    }
}

- (void)setTintColor:(UIColor*)Color
{
    navBarTintColor=Color;
}

-(void) viewWillDisappear:(BOOL)animated
{
    [[self closeDelegate] BCFileViewerDialogClosed];
    [super viewWillDisappear:animated];
    
}
- (void)viewDidUnload {
    RELEASE_TO_NIL(navBarTintColor);
    RELEASE_TO_NIL(closeDelegate);
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.showActionButton==NO)
    {
        [self.navigationItem setRightBarButtonItem:nil 
                                          animated:NO];    
    }
}

@end
