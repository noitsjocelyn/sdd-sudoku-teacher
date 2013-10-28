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
#import "PPMainMenuController.h"

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
    if (!self.shouldResumeGame)
    {
        [self setupLabels];
        for (short i = 0; i < 81; ++i)
        {
            [self.view addSubview:valueLabels[i]];
        }
        // Spin off the process generation to its own thread
        [NSThread detachNewThreadSelector:@selector(generateAndDisplayBoard:)
                                 toTarget:self
                               withObject:Nil];
    }
    // Default buttons to disabled
    for (UIButton *aButton in self.setValueButtons)
    {
        [aButton setEnabled:NO];
    }
    [self setupProcessingView];
    [self.view addSubview:processingView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.delegate setGameInProgress:YES];
}

- (IBAction)setValue:(id)sender
{
    // Don't allow anything for original values
    if (!valueModifiable[self.buttonSelected])
    {
        return;
    }
    // Grab the value we want to set it to
    NSUInteger value = [sender tag];
    // Grab the button that is selected
    UIButton *buttonToChange = valueLabels[self.buttonSelected];
    // Default the new value to blank
    NSString *newTitle = @"";
    // If we aren't clearing it, set the new value
    if (value != 0)
    {
        newTitle = [NSString stringWithFormat:@"%d", value];
        for (UIButton *aButton in self.setValueButtons)
        {
            [aButton setEnabled:YES];
        }
    }
    // Otherwise, clear it
    else
    {
        for (UIButton *aButton in self.setValueButtons)
        {
            // Disable the clear button
            if ([aButton tag] == 0)
            {
                [aButton setEnabled:NO];
            }
        }
    }
    // Set the new title
    [buttonToChange setTitle:newTitle forState:UIControlStateNormal];
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
            [aValueButton setBackgroundImage:[UIImage imageNamed:@"Highlight circle"] forState:UIControlStateSelected];
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

- (void)setupProcessingView
{
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
            valueModifiable[i] = NO;
            valString = [NSString stringWithFormat:@"%d", val];
        }
        // If it's zero, make the string blank
        else
        {
            valueModifiable[i] = YES;
            [valueLabels[i] setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            valString = @"";
        }
        [valueLabels[i] setTitle:valString forState:UIControlStateNormal];
    }
}

- (void)generateAndDisplayBoard:(id)sender
{
    // Generate the puzzle
    NSLog(@"Generating full puzzle");
    SudokuBoard *aBoard = [SudokuBoardGenerator generate];
    PuzzleMaker *aMaker = [[PuzzleMaker alloc] init];
    [aMaker givePuzzle:[aBoard boardAsShortArray]];
    short *puzzleArray;
    if (self.difficulty == 0)
    {
        NSLog(@"Making easy board");
        puzzleArray = [aMaker buildEasyPuzzle];
    }
    else
    {
        NSLog(@"Making moderate board");
        puzzleArray = [aMaker buildMediumPuzzle];
    }
    [self setValuesFromShortArray:puzzleArray];
    aBoard = Nil;
    aMaker = Nil;
    // I think this needs to be freed, but I'm getting warnings when I do, so leaving it for now
    //free(puzzleArray);
    
    // Animate removing the processing view
    [UIView animateWithDuration:0.4
                     animations:^(void){ [processingView setAlpha:0.0]; }
                     completion:^(BOOL finished){ [processingView removeFromSuperview]; }];
    // Exit the thread
    if (![NSThread isMainThread])
    {
        [NSThread exit];
    }
}

- (void)numberButtonPressed:(id)sender
{
    [self setSelectedValueButton:[sender tag]];
    self.buttonSelected = [sender tag];
    // Get the X and Y of the button from its tag
    short x = [sender tag] / 9;
    short y = [sender tag] % 9;
    // Get value of the title
    NSString *title = [sender titleForState:UIControlStateNormal];
    short value = 0;
    if (![title isEqualToString:@""])
    {
        // Need to subtract '0' from the char value of the number
        char valueChar = [title characterAtIndex:0] - '0';
        value = [[NSNumber numberWithChar:valueChar] shortValue];
    }
    // Log the stuff
    NSLog(@"Button at (%d,%d) pressed. Its value is %d.", x, y, value);
}

- (void)setSelectedValueButton:(NSUInteger)buttonTag
{
    for (short i = 0; i < 81; ++i)
    {
        // Deselect all the buttons that were not pressed
        if (i != buttonTag)
        {
            [valueLabels[i] setSelected:NO];
        }
        // We need to do stuff if we're on the button that IS pressed
        else
        {
            // If it was already selected, deselect it
            if ([valueLabels[i] isSelected])
            {
                [valueLabels[i] setSelected:NO];
                self.buttonSelected = -1;
                // Also disable the setters
                for (UIButton *aButton in self.setValueButtons)
                {
                    [aButton setEnabled:NO];
                }
            }
            else
            {
                [valueLabels[i] setSelected:YES];
                // If it's an original value, we can't change it
                if (!valueModifiable[buttonTag])
                {
                    for (UIButton *aButton in self.setValueButtons)
                    {
                        [aButton setEnabled:NO];
                    }
                }
                else
                {
                    for (UIButton *aButton in self.setValueButtons)
                    {
                        // Disable the "Clear" button if the square is blank
                        if ([aButton tag] == 0)
                        {
                            BOOL valueIsBlank = [[valueLabels[buttonTag] titleForState:UIControlStateNormal] isEqualToString:@""];
                            [aButton setEnabled:!valueIsBlank];
                        }
                        // Otherwise, enable the setter
                        else
                        {
                            [aButton setEnabled:YES];
                        }
                    }
                }
            }
        }
    }
}

@end
