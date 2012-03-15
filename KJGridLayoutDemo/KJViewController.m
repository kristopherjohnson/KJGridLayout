//
//  KJViewController.m
//  KJGridLayoutDemo
//
//  Created by Kristopher Johnson on 3/14/12.
//  Copyright (c) 2012 Kristopher Johnson 
//

#import "KJViewController.h"

@implementation KJViewController

@synthesize gridLayout;

- (void)dealloc {
    [gridLayout release];
    [super dealloc];
}

- (UIButton *)buttonInViewWithTitle:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:title forState:UIControlStateNormal];
    [self.view addSubview:button];
    return button;
}

- (void)makeKeypad {
    UIButton *button;
    
    // Create 1-9 keys in 3x3 grid
    for (NSUInteger i = 0; i < 9; ++i) {
        NSString *title = [NSString stringWithFormat:@"%u", (unsigned) i + 1];
        button = [self buttonInViewWithTitle:title];
        
        NSUInteger rowIndex = 3 - (i / 3);
        NSUInteger columnIndex = i % 3;
        [gridLayout addView:button row:rowIndex column:columnIndex];
    }
    
    // 0 key
    button = [self buttonInViewWithTitle:@"0"];
    [gridLayout addView:button row:4 column:0 columnSpan:2];
    
    // Decimal
    button = [self buttonInViewWithTitle:@"."];
    [gridLayout addView:button row:4 column:2];
    
    // Enter
    button = [self buttonInViewWithTitle:@"Enter"];
    [gridLayout addView:button row:3 rowSpan:2 column:3];
    
    // +
    button = [self buttonInViewWithTitle:@"+"];
    [gridLayout addView:button row:2 column:3];
    
    // -
    button = [self buttonInViewWithTitle:@"-"];
    [gridLayout addView:button row:1 column:3];
    
    // *
    button = [self buttonInViewWithTitle:@"*"];
    [gridLayout addView:button row:0 column:3];
    
    // /
    button = [self buttonInViewWithTitle:@"/"];
    [gridLayout addView:button row:0 column:2];
    
    // Info text
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = @"This app demonstrates use of KJGridLayout";
    label.numberOfLines = 0;
    label.lineBreakMode = UILineBreakModeWordWrap;
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label];
    [gridLayout addView:label row:0 column:0 columnSpan:2];
    [label release];
}

- (CGRect)layoutBounds {
    CGRect layoutBounds = self.view.bounds;
    layoutBounds = CGRectInset(layoutBounds, 8, 8);
    return layoutBounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    gridLayout = [[KJGridLayout alloc] init];
    
    [self makeKeypad];
    
    [gridLayout setBounds:[self layoutBounds]];
    [gridLayout layoutViews];
}

- (void)viewDidUnload {
    // Release the grid layout to release the retained subviews
    [self setGridLayout:nil];
    [super viewDidUnload];
}

- (void)animateLayoutWithDuration:(NSTimeInterval)duration {
    [UIView animateWithDuration:duration animations:^{
        [gridLayout setBounds:[self layoutBounds]];
        [gridLayout layoutViews];        
    }];    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self animateLayoutWithDuration:duration];
}

@end
