//
//  KJViewController.m
//  KJGridLayoutViewDemo
//
// Copyright (C) 2012 Kristopher Johnson
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "KJViewController.h"

@implementation KJViewController

@synthesize gridLayoutView;

- (void)dealloc {
    [gridLayoutView release];
    [super dealloc];
}

- (UIButton *)buttonWithTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:title forState:UIControlStateNormal];
    return button;
}

- (void)addKeypadButtonsToGridLayoutView {
    UIButton *button;
    
    // Create 1-9 keys in 3x3 grid
    for (NSUInteger i = 0; i < 9; ++i) {
        NSString *title = [NSString stringWithFormat:@"%u", (unsigned) i + 1];
        button = [self buttonWithTitle:title];
        
        NSUInteger rowIndex = 3 - (i / 3);
        NSUInteger columnIndex = i % 3;
        [gridLayoutView addSubview:button row:rowIndex column:columnIndex];
    }

    // 0 key
    button = [self buttonWithTitle:@"0"];
    [gridLayoutView addSubview:button row:4 column:0 columnSpan:2];
    
    // Decimal
    button = [self buttonWithTitle:@"."];
    [gridLayoutView addSubview:button row:4 column:2];
    
    // Enter
    button = [self buttonWithTitle:@"Enter"];
    [gridLayoutView addSubview:button row:3 rowSpan:2 column:3];
    
    // +
    button = [self buttonWithTitle:@"+"];
    [gridLayoutView addSubview:button row:2 column:3];
    
    // -
    button = [self buttonWithTitle:@"-"];
    [gridLayoutView addSubview:button row:1 column:3];
    
    // *
    button = [self buttonWithTitle:@"*"];
    [gridLayoutView addSubview:button row:0 column:3];
    
    // /
    button = [self buttonWithTitle:@"/"];
    [gridLayoutView addSubview:button row:0 column:2];
    
    // Info text
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = @"This app demonstrates use of KJGridLayoutView";
    label.numberOfLines = 0;
    label.lineBreakMode = UILineBreakModeWordWrap;
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label];
    [gridLayoutView addSubview:label row:0 column:0 columnSpan:2];
    [label release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // The KJGridLayoutView class is in a library, so we have to have some direct
    // reference to it or the linker won't include it in the executable.
    // (Alternatively, we could add "-all_load -ObjC" to the linker settings.)
    NSLog(@"Using class %@", [KJGridLayoutView description]);
    
#if 0 
    // If we wanted to create the gridLayoutView programmatically, rather than
    // loading from the NIB, here's how we'd do it
    CGRect gridLayoutViewBounds = CGRectInset(self.view.bounds, 8, 8);
    gridLayoutView = [[KJGridLayoutView alloc] initWithFrame:gridLayoutViewBounds];
    
    // Give the layout view a distinctive background color so we can see it
    gridLayoutView.backgroundColor = [UIColor greenColor];
    
    // Let the view take care of resizing itself upon autorotation
    gridLayoutView.autoresizingMask = UIViewAutoresizingFlexibleWidth |
                                      UIViewAutoresizingFlexibleHeight;
#endif
    
    // Put some empty space between the subviews
    [gridLayoutView setRowSpacing:4];
    [gridLayoutView setColumnSpacing:4];
    
    [self.view addSubview:gridLayoutView];
    
    [self addKeypadButtonsToGridLayoutView];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.gridLayoutView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
