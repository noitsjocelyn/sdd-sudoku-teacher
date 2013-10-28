//
//  PPMainMenuController.m
//  Sudoku Teacher
//
//  Created by Jonathan on 10/25/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import "PPMainMenuController.h"
#import "PPSudokuGameViewController.h"

#define CHECK_FADE_TIME 0.4

@interface PPMainMenuController ()

@end

@implementation PPMainMenuController

@synthesize difficulty;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Default to Easy mode, make interface reflect this
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PPSudokuGameViewController *controller = [segue destinationViewController];
    [controller setDifficulty:self.difficulty];
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
    // If if it wasn't already set to easy, change stuff
    if ([self difficulty] != 0)
    {
        [self setDifficulty:0];
        [self.easyModeButton setSelected:YES];
        [self.moderateModeButton setSelected:NO];
        [self moveElement:self.toggleCheck
                  toFrame:easyCheckPosition
             withFadeTime:CHECK_FADE_TIME];
    }
    NSLog(@"%d", [self difficulty]);
}

// Like above, set the difficulty to moderate
- (IBAction)toggleModerateMode:(id)sender
{
    // If if it wasn't already set to moderate, change stuff
    if ([self difficulty] != 1)
    {
        [self setDifficulty:1];
        [self.easyModeButton setSelected:NO];
        [self.moderateModeButton setSelected:YES];
        [self moveElement:self.toggleCheck
                  toFrame:moderateCheckPosition
             withFadeTime:CHECK_FADE_TIME];
    }
    NSLog(@"%d", [self difficulty]);
}

// Make a UI element invisible, move it to a given frame, then fade it in
- (void)moveElement:(id)anElement toFrame:(CGRect)aFrame withFadeTime:(NSTimeInterval)anInterval
{
    [anElement setAlpha:0.0];
    [anElement setFrame:aFrame];
    [UIView animateWithDuration:anInterval
                     animations:^(void){ [anElement setAlpha:1.0]; }];
}

@end
