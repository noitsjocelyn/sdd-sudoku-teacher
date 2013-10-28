//
//  PPSudokuGameControllerViewController.m
//  Sudoku Teacher
//
//  Created by Jonathan on 10/25/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import "PPSudokuGameViewController.h"
#import "PPSudokuView.h"
#import "SudokuBoardGenerator.h"
#import "SudokuBoard.h"
#import "PuzzleMaker.h"

@interface PPSudokuGameViewController ()

@end

@implementation PPSudokuGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupLabels];
    for (short i = 0; i < 81; ++i)
    {
        [self.view addSubview:valueLabels[i]];
    }
    // Make the processing view components
    processingView = [[UIView alloc] init];
    // Note: The navigation bar is 64 px tall
    CGRect processingFrame = CGRectMake(0.0, 64.0, self.view.frame.size.width, self.view.frame.size.height - 64.0);
    [processingView setFrame:processingFrame];
    [processingView setBackgroundColor:[UIColor blackColor]];
    [processingView setAlpha:0.6];
    // Place the spinner in the middle
    // Note: This frame is relative to processingView, not to self.view
    // Also, standard spinner size is 37 by 37
    processingIndicator = [[UIActivityIndicatorView alloc] init];
    CGRect spinnerFrame = CGRectMake(142.5, 142.5, 37.0, 37.0);
    [processingIndicator setFrame:spinnerFrame];
    [processingView addSubview:processingIndicator];
    [processingIndicator startAnimating];
    // Add the view
    [self.view addSubview:processingView];
    // Spin off the process generation to its own thread
    [NSThread detachNewThreadSelector:@selector(generateAndDisplayBoardWithDifficulty:)
                             toTarget:self
                           withObject:[NSNumber numberWithInt:0]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupLabels
{
    for (short x = 0; x < 9; ++x)
    {
        for (short y = 0; y < 9; ++y)
        {
            // Get the index out of 81
            short i = 9 * x + y;
            // Get the position offsets
            float xPos = 4 + 35.5 * x;
            float yPos = 4 + 35.5 * y;
            // Offset by the position of the board background
            xPos += self.boardBackground.frame.origin.x;
            yPos += self.boardBackground.frame.origin.y;
            // Slight position adjustments for the last two rows/columns
            if (x == 7) xPos -= 0.5;
            if (y == 7) yPos -= 0.5;
            if (x == 8) xPos -= 1.5;
            if (y == 8) yPos -= 1.5;
            // Set up the value buttons
            float buttonSize = 31.0;
            CGRect buttonFrame = CGRectMake(xPos, yPos, buttonSize, buttonSize);
            UIButton *aValueButton = [[UIButton alloc] initWithFrame:buttonFrame];
            [aValueButton setBackgroundColor:[UIColor clearColor]];
            [aValueButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [aValueButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
            [aValueButton setTitle:@"" forState:UIControlStateNormal];
            // Set the tag so we can figure out which is pressed later
            [aValueButton setTag:i];
            // Call the printButtonNumber: method when they are pressed
            [aValueButton addTarget:self
                             action:@selector(numberButtonPressed:)
                   forControlEvents:UIControlEventTouchUpInside];
            valueLabels[i] = aValueButton;
        }
    }
}

- (void)setValuesFromShortArray:(short *)valuesArray
{
    for (short i = 0; i < 81; ++i)
    {
        // Grab the value
        short val = valuesArray[i];
        NSString *valString;
        // If it's non-zero, set the string up
        if (val != 0)
        {
            valString = [NSString stringWithFormat:@"%d", val];
        }
        // If it's zero, make the string blank
        else
        {
            valString = @"";
        }
        [valueLabels[i] setTitle:valString forState:UIControlStateNormal];
    }
}

- (void)generateAndDisplayBoardWithDifficulty:(NSNumber *)difficulty
{
    // Generate the puzzle
    SudokuBoard *aBoard = [SudokuBoardGenerator generate];
    PuzzleMaker *aMaker = [[PuzzleMaker alloc] init];
    [aMaker givePuzzle:[aBoard boardAsShortArray]];
    short *puzzleArray;
    if ([difficulty intValue] == 0)
    {
        puzzleArray = [aMaker buildEasyPuzzle];
    }
    else
    {
        puzzleArray = [aMaker buildMediumPuzzle];
    }
    [self setValuesFromShortArray:puzzleArray];
    aBoard = Nil;
    aMaker = Nil;
    // I think this needs to be freed, but I'm getting warnings when I do, so leaving it for now
    //free(puzzleArray);
    
    // Animate removing the processing view
    [UIView animateWithDuration:0.4
                     animations:^(void)
                     {
                         [processingView setAlpha:0.0];
                     }
                     completion:^(BOOL finished)
                     {
                         [processingView removeFromSuperview];
                     }];
    // Exit the thread
    if (![NSThread isMainThread])
    {
        [NSThread exit];
    }
}

- (void)numberButtonPressed:(id)sender
{
    // Get the X and Y of the button from its tag
    short x = [sender tag] / 9;
    short y = [sender tag] % 9;
    // Get value of the title
    NSString *title = [sender titleForState:UIControlStateNormal];
    short value = 0;
    if (![title isEqualToString:@""])
    {
        // Gotta subtract '0' from the char value of the number
        char valueChar = [title characterAtIndex:0] - '0';
        value = [[NSNumber numberWithChar:valueChar] shortValue];
    }
    // Log the stuff
    NSLog(@"Button at (%d,%d) pressed! Its value is %d.", x, y, value);
}

@end
