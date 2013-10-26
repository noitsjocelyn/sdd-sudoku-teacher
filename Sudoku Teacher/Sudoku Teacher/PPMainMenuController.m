//
//  PPMainMenuController.m
//  Sudoku Teacher
//
//  Created by Jonathan on 10/25/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import "PPMainMenuController.h"

#define CHECK_FADE_TIME 0.4

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
	[self.easyModeButton setSelected:YES];
	[self.moderateModeButton setSelected:NO];
	// If we're changin our selection, move the check with fade
	if (difficulty != 0)
	{
		[self moveElement:self.toggleCheck toFrame:easyCheckPosition withFadeTime:CHECK_FADE_TIME];
	}
	difficulty = 0;
}

// Like above, set the difficulty to moderate
- (IBAction)toggleModerateMode:(id)sender
{
	[self.easyModeButton setSelected:NO];
	[self.moderateModeButton setSelected:YES];
	// If we're changin our selection, move the check with fade
	if (difficulty != 1)
	{
		[self moveElement:self.toggleCheck toFrame:moderateCheckPosition withFadeTime:CHECK_FADE_TIME];
	}
	difficulty = 1;
}

// Make a UI element invisible, move it to a given frame, then fade it in
- (void)moveElement:(id)anElement toFrame:(CGRect)aFrame withFadeTime:(NSTimeInterval)anInterval
{
	[anElement setAlpha:0.0];
	[anElement setFrame:aFrame];
	[UIView animateWithDuration:anInterval animations:^(void)
	 {
		 [anElement setAlpha:1.0];
	 }];
}

@end
