//
//  PPTutorialFinalViewController.m
//  Sudoku Teacher
//
//  Created by Jonathan on 11/20/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import "PPTutorialFinalViewController.h"
#import "PPSudokuGameViewController.h"
#import "Puzzle.h"

@interface PPTutorialFinalViewController ()

@end

@implementation PPTutorialFinalViewController

#pragma mark UIViewController methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    defaultBasicPuzzle = @"261897543874315296395604871149276385752438619638159427910582034427963150583741962";
    // 2 8 3 | 1 7 6 | 9 4 5
    // 6 7 9 | 4 5 3 | 1 2 8
    // 1 4 5 | 9 2 8 |   7 3
    // ---------------------
    // 8 3 6 | 2 4 1 | 5 9 7
    // 9 1   | 7 3 5 | 8 6 4
    // 7 5 4 | 6 8 9 | 2 3 1
    // ---------------------
    // 5 2 8 | 3 6 4 |   1 9
    // 4 9 7 | 8 1 2 | 3 5 6
    // 3 6 1 | 5 9 7 | 4   2
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Segue methods

// Do stuff that needs to be done before a segue, like sending values ahead.
// Fires only if shouldPerformSegueWithIdentifier:sender: returned YES.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue destinationViewController] class] == [PPSudokuGameViewController class])
    {
        PPSudokuGameViewController *controller = [segue destinationViewController];
        if (!puzzleData)
        {
            puzzleData = [[Puzzle alloc] initWithString:defaultBasicPuzzle];
        }
        [controller setDelegate:self];
        [controller setGameInProgress:puzzleData];
        [controller setGameProgressTime:0];
        [controller setGameDifficulty:0];
        [controller setIsGameTutorial:YES];
        puzzleData = nil;
    }
}

- (void)setGameInProgress:(Puzzle *)thePuzzle
{
    puzzleData = thePuzzle;
}

- (void)setGameProgressTime:(NSUInteger)seconds
{
    // We don't care!
}

- (void)setGameDifficulty:(NSUInteger)gameDifficulty
{
    // We don't care!
}

- (void)setIsGameTutorial:(BOOL)isGameTutorial
{
    // It is, no matter what
}

@end
