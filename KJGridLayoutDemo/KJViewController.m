//
//  KJViewController.m
//  KJGridLayoutDemo
//
//  Created by Kristopher Johnson on 3/14/12.
//  Copyright (c) 2012 Capable Hands Technologies, Inc. All rights reserved.
//

#import "KJViewController.h"

@interface KJViewController ()

@end

@implementation KJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
