//
//  KJViewController.m
//  KJGridLayoutDemo
//
//  Created by Kristopher Johnson on 3/14/12.
//  Copyright (c) 2012 Kristopher Johnson 
//

#import "KJViewController.h"

@implementation KJViewController

@synthesize topLabel;
@synthesize firstSwitch;
@synthesize firstSwitchLabel;
@synthesize secondSwitch;
@synthesize secondSwitchLabel;
@synthesize button1;
@synthesize button2;
@synthesize button3;
@synthesize button4;
@synthesize switchesLeftButton;
@synthesize switchesRightButton;

@synthesize gridLayout;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    gridLayout = [[KJGridLayout alloc] init];
    
    [gridLayout addView:topLabel row:0 column:0 columnSpan:4];
    
    [gridLayout addView:firstSwitch row:1 column:0];
    [gridLayout addView:firstSwitchLabel row:1 column:1 columnSpan:3];
    
    [gridLayout addView:secondSwitch row:2 column:0];
    [gridLayout addView:secondSwitchLabel row:2 column:1 columnSpan:3];
    
    [gridLayout addView:button1 row:3 column:0];
    [gridLayout addView:button2 row:3 column:1];
    [gridLayout addView:button3 row:3 column:2];
    [gridLayout addView:button4 row:3 column:3];
    
    [gridLayout addView:switchesLeftButton row:4 column:0];
    [gridLayout addView:switchesRightButton row:4 column:1];
    
    [gridLayout setBounds:[self.view bounds]];
    [gridLayout layoutViews];
}

- (void)viewDidUnload {
    [self setGridLayout:nil];
    
    [self setTopLabel:nil];
    [self setFirstSwitch:nil];
    [self setFirstSwitchLabel:nil];
    [self setSecondSwitch:nil];
    [self setSecondSwitchLabel:nil];
    [self setButton1:nil];
    [self setButton2:nil];
    [self setButton3:nil];
    [self setButton4:nil];
    [self setSwitchesLeftButton:nil];
    [self setSwitchesRightButton:nil];
    
    [super viewDidUnload];
}

- (void)animateLayout {
    [UIView animateWithDuration:0.2f animations:^{
        [gridLayout setBounds:[self.view bounds]];
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

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    
    [self animateLayout];
}

- (void)dealloc {
    [gridLayout release];
    
    [topLabel release];
    [firstSwitch release];
    [firstSwitchLabel release];
    [secondSwitch release];
    [secondSwitchLabel release];
    [button1 release];
    [button2 release];
    [button3 release];
    [button4 release];
    [switchesLeftButton release];
    [switchesRightButton release];
    
    [super dealloc];
}

- (IBAction)switchesLeftButtonWasTapped:(id)sender {
    [gridLayout removeView:firstSwitch];
    [gridLayout removeView:firstSwitchLabel];
    [gridLayout removeView:secondSwitch];
    [gridLayout removeView:secondSwitchLabel];
    
    [gridLayout addView:firstSwitch row:1 column:0];
    [gridLayout addView:firstSwitchLabel row:1 column:1 columnSpan:3];
    firstSwitchLabel.textAlignment = UITextAlignmentLeft;
    
    [gridLayout addView:secondSwitch row:2 column:0];
    [gridLayout addView:secondSwitchLabel row:2 column:1 columnSpan:3];
    secondSwitchLabel.textAlignment = UITextAlignmentLeft;

    [self animateLayout];
}

- (IBAction)switchesRightButtonWasTapped:(id)sender {
    [gridLayout removeView:firstSwitch];
    [gridLayout removeView:firstSwitchLabel];
    [gridLayout removeView:secondSwitch];
    [gridLayout removeView:secondSwitchLabel];
    
    [gridLayout addView:firstSwitch row:1 column:3];
    [gridLayout addView:firstSwitchLabel row:1 column:0 columnSpan:3];
    firstSwitchLabel.textAlignment = UITextAlignmentRight;
    
    [gridLayout addView:secondSwitch row:2 column:3];
    [gridLayout addView:secondSwitchLabel row:2 column:0 columnSpan:3];
    secondSwitchLabel.textAlignment = UITextAlignmentRight;
    
    [self animateLayout];
}

@end
