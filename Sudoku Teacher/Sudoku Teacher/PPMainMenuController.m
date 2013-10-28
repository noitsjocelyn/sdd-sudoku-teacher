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
    if (self)
    {
        // Default to Easy mode, make interface reflect this
        self.difficulty = 0;
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

// Move the check to its correct place before displaying UI elements
// viewDidLayoutSubviews is the last place to do this before elements appear
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if (self.difficulty == 0)
    {
        [self.toggleCheck setFrame:easyCheckPosition];
    }
    else
    {
        [self.toggleCheck setFrame:moderateCheckPosition];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue destinationViewController] class] == [PPSudokuGameViewController class])
    {
        PPSudokuGameViewController *controller = [segue destinationViewController];
        [controller setDifficulty:self.difficulty];
    }
}

// Set up the positions of the check mark
- (void)setupCheckPositions
{
    CGFloat xDiff = 22.0;
    CGFloat easyCheckX = self.easyModeButton.frame.origin.x - xDiff;
    CGFloat moderateCheckX = self.moderateModeButton.frame.origin.x - xDiff;
    CGFloat checkY = self.easyModeButton.frame.origin.y;
    CGSize checkSize = self.toggleCheck.frame.size;
    easyCheckPosition = CGRectMake(easyCheckX, checkY, checkSize.width, checkSize.height);
    moderateCheckPosition = CGRectMake(moderateCheckX, checkY, checkSize.width, checkSize.height);
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
    NSLog(@"Changed difficulty to %lu", (unsigned long)self.difficulty);
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
    NSLog(@"Changed difficulty to %lu", (unsigned long)self.difficulty);
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
