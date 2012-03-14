//
//  KJViewController.h
//  KJGridLayoutDemo
//
//  Created by Kristopher Johnson on 3/14/12.
//  Copyright (c) 2012 Kristopher Johnson 
//

#import <UIKit/UIKit.h>
#import "KJGridLayout.h"

@interface KJViewController : UIViewController

@property (retain, nonatomic) IBOutlet UILabel *topLabel;
@property (retain, nonatomic) IBOutlet UISwitch *firstSwitch;
@property (retain, nonatomic) IBOutlet UILabel *firstSwitchLabel;
@property (retain, nonatomic) IBOutlet UISwitch *secondSwitch;
@property (retain, nonatomic) IBOutlet UILabel *secondSwitchLabel;
@property (retain, nonatomic) IBOutlet UIButton *button1;
@property (retain, nonatomic) IBOutlet UIButton *button2;
@property (retain, nonatomic) IBOutlet UIButton *button3;
@property (retain, nonatomic) IBOutlet UIButton *button4;
@property (retain, nonatomic) IBOutlet UIButton *switchesLeftButton;
@property (retain, nonatomic) IBOutlet UIButton *switchesRightButton;

@property (retain, nonatomic) KJGridLayout *gridLayout;

- (IBAction)switchesLeftButtonWasTapped:(id)sender;
- (IBAction)switchesRightButtonWasTapped:(id)sender;

@end
