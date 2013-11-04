//
//  PPMainMenuController.m
//  Sudoku Teacher
//
//  Created by Jonathan on 10/25/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import "PPMainMenuController.h"
#import "PPSudokuGameViewController.h"
#import "Puzzle.h"
#import "SudokuBoard.h"
#import "SudokuBoardGenerator.h"

#define CHECK_FADE_TIME 0.4

@interface PPMainMenuController ()

@end

@implementation PPMainMenuController

//@synthesize preGeneratedPuzzle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Default to Easy mode, make interface reflect this
        self.difficulty = 0;
        [self.easyModeButton setSelected:YES];
        [self.moderateModeButton setSelected:NO];
        // Default to no game in progress. This may change with resuming from
        // the closed app later, but should be good for now.
        self.puzzleInProgress = Nil;
        preGeneratedPuzzle = NULL;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupCheckPositions];
    [self preGeneratePuzzle];
}

// viewDidLayoutSubviews is the last place to modify UI elements before they appear
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    // Move the check to its correct place before displaying UI elements
    if (self.difficulty == 0)
    {
        [self.toggleCheck setFrame:easyCheckPosition];
    }
    else
    {
        [self.toggleCheck setFrame:moderateCheckPosition];
    }
    // Enable "Resume" if we have a puzzle we can resume
    if (!self.puzzleInProgress)
    {
        [self.resumeGameButton setEnabled:NO];
    }
    else
    {
        [self.resumeGameButton setEnabled:YES];
    }
    // Default back to unconfirmed new games
    newGameConfirmed = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)preGeneratePuzzle
{
    // Spin off the puzzle pre-generation to its own thread
    [NSThread detachNewThreadSelector:@selector(makePuzzle)
                             toTarget:self
                           withObject:Nil];
}

- (void)makePuzzle
{
    preGeneratedPuzzle = nil;
    #ifdef DEBUG
    NSUInteger attempts = 0;
    #endif
    // The generate method returns nil if there is a failure, so loop it
    while (!preGeneratedPuzzle)
    {
        #ifdef DEBUG
        ++attempts;
        NSLog(@"Pre-generating puzzle, attempt %d...", attempts);
        #endif
        preGeneratedPuzzle = [SudokuBoardGenerator generate];
    }
    #ifdef DEBUG
    NSLog(@"Pre-generated.");
    #endif
    UIAlertView *preGenAlert = [[UIAlertView alloc] initWithTitle:@"Pre-generation complete"
                                                          message:nil
                                                         delegate:self
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
    [preGenAlert show];
    // Exit the thread
    if (![NSThread isMainThread])
    {
        [NSThread exit];
    }
}

// Do stuff that needs to be done before a segue, like sending values ahead.
// Fires only if shouldPerformSegueWithIdentifier:sender: returned YES.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue destinationViewController] class] == [PPSudokuGameViewController class])
    {
        PPSudokuGameViewController *controller = [segue destinationViewController];
        [controller setDifficulty:self.difficulty];
        controller.delegate = self;
        if (sender == self.startNewGameButton)
        {
            [controller setPuzzleData:nil];
            self.puzzleInProgress = nil;
            [controller setPreGeneratedPuzzle:preGeneratedPuzzle];
        }
        else
        {
            [controller setPuzzleData:self.puzzleInProgress];
            self.puzzleInProgress = nil;
        }
    }
}

// Allows you to cancel segues if needed.
// Fires before prepareForSegue:sender:
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    // If they want to start a new game, we need to do some checks
    if (sender == self.startNewGameButton)
    {
        // If we don't have a game in progress, start without question
        if (self.puzzleInProgress == Nil)
        {
            newGameConfirmed = NO;
            return YES;
        }
        // Otherwise, check if we want to overwrite our current game
        else
        {
            // If they already confirmed on a previous press, go ahead
            if (newGameConfirmed)
            {
                newGameConfirmed = NO;
                return YES;
            }
            // Otherwise, pop up an alert
            else
            {
                newGameAlert = [[UIAlertView alloc] initWithTitle:@"You have a game in progress"
                                                          message:@"Are you sure you want to start a new game? This will overwrite your existing game."
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:@"New game", nil];
                [newGameAlert show];
                // Cancel the segue until we have a response
                return NO;
            }
        }
    }
    // Other segues happen automatically
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // See if we're coming from the new game alert
    if (alertView == newGameAlert)
    {
        // Do stuff if they didn't press Cancel
        if (buttonIndex != [newGameAlert cancelButtonIndex])
        {
            // Say that they confirmed the new game
            newGameConfirmed = YES;
            // Redo the segue
            [self performSegueWithIdentifier:@"NewGame" sender:self.startNewGameButton];
        }
    }
}

- (void)setGameInProgress:(Puzzle *)thePuzzle
{
    self.puzzleInProgress = thePuzzle;
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
