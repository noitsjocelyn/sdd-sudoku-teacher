//
//  PPMainMenuController.m
//  Sudoku Teacher
//
//  Created by Jonathan on 10/25/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import "PPMainMenuController.h"

@interface PPMainMenuController ()

@end

@implementation PPMainMenuController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Default to Easy mode, make interface reflect this
		difficulty = 0;
		[self.easyModeButton setSelected:YES];
		[self.moderateModeButton setSelected:NO];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	[self setupCheckPositions];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Set up the various positions of the check mark
- (void)setupCheckPositions
{
	// Get the starting position of the check, ie. next to the easy button
	easyCheckPosition = self.toggleCheck.frame;
	// Determine how far it is from the easy button
	float xDiff = self.easyModeButton.frame.origin.x - easyCheckPosition.origin.x;
	// Determine the X needed to position the check next to the moderate button
	float moderateX = self.moderateModeButton.frame.origin.x - xDiff;
	// Set up the check position for next to the moderate button
	moderateCheckPosition = easyCheckPosition;
	moderateCheckPosition.origin.x = moderateX;
}

// Set the difficulty to easy and modify the interface to reflect this
- (IBAction)toggleEasyMode:(id)sender
{
	difficulty = 0;
	[self.easyModeButton setSelected:YES];
	[self.moderateModeButton setSelected:NO];
	[self.toggleCheck setFrame:easyCheckPosition];
}

// Like above, set the difficulty to moderate
- (IBAction)toggleModerateMode:(id)sender
{
	difficulty = 1;
	[self.easyModeButton setSelected:NO];
	[self.moderateModeButton setSelected:YES];
	[self.toggleCheck setFrame:moderateCheckPosition];
}

@end
