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
        // Default to Easy mode
		difficulty = 0;
		[self.easyModeButton setSelected:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	// Get the starting position of the check, ie. the position next to the easy button
	easyCheckPosition = self.toggleCheck.frame;
	// Determine how far it is from the easy button
	float xDiff = self.easyModeButton.frame.origin.x - easyCheckPosition.origin.x;
	// Determine the X needed to position the check next to the moderate button
	float moderateX = self.moderateModeButton.frame.origin.x - xDiff;
	// Set up the check position for next to the moderate button
	moderateCheckPosition = easyCheckPosition;
	moderateCheckPosition.origin.x = moderateX;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toggleEasyMode:(id)sender
{
	difficulty = 0;
	[self.easyModeButton setSelected:YES];
	[self.moderateModeButton setSelected:NO];
	[self.toggleCheck setFrame:easyCheckPosition];
}

- (IBAction)toggleModerateMode:(id)sender
{
	difficulty = 1;
	[self.easyModeButton setSelected:NO];
	[self.moderateModeButton setSelected:YES];
	[self.toggleCheck setFrame:moderateCheckPosition];
}

@end
