//
//  PPSudokuGameControllerViewController.m
//  Sudoku Teacher
//
//  Created by Jonathan on 10/25/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import "PPHintViewController.h"
#import "PPMainMenuController.h"
#import "PPSudokuView.h"
#import "PPSudokuGameViewController.h"
#import "Puzzle.h"
#import "PuzzleMaker.h"
#import "PuzzleMakerFactory.h"

#define CLEAR_BUTTON_TAG 0

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
    // Setup all of our subviews
    [self setupSubviews];
    // Add our labels
    for (short i = 0; i < 81; ++i)
    {
        [self.view addSubview:squareButtons[i]];
    }
    // Default setter buttons to disabled
    for (UIButton *aButton in self.setValueButtons)
    {
        [aButton setEnabled:NO];
    }
    // Either make a new board...
    if (!self.puzzleData)
    {
        // Add the processing view
        [self.view addSubview:processingView];
        // Spin off the process generation to its own thread
        [NSThread detachNewThreadSelector:@selector(generateAndDisplayBoard:)
                                 toTarget:self
                               withObject:Nil];
    }
    // ...or resume a previous game
    else
    {
        [self setupFromPuzzleData:self.puzzleData];
        [self.hintButton setEnabled:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.delegate setGameInProgress:self.puzzleData];
}

- (IBAction)setValue:(id)sender
{
    short location = self.buttonSelected;
    // Don't allow modification of original values
    if ([self.puzzleData isOriginalValueAtIndex:location])
    {
        return;
    }
    // Grab the value we want to set it to
    short value = (short)[sender tag];
    // Grab the button that is selected
    UIButton *buttonToChange = squareButtons[location];
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
        // Change the Puzzle data
        [self.puzzleData putInValue:(location * 9 + value)];
    }
    // Otherwise, clear it
    else
    {
        for (UIButton *aButton in self.setValueButtons)
        {
            // Disable the clear button
            if ([aButton tag] == CLEAR_BUTTON_TAG)
            {
                [aButton setEnabled:NO];
            }
        }
        // Reset the square in Puzzle data
        [self.puzzleData resetSquareAtIndex:location];
    }
    // Set the new title
    [buttonToChange setTitle:newTitle forState:UIControlStateNormal];
}

// Setup our subviews in the correct order (since some depend on each other)
- (void)setupSubviews
{
    [self.hintButton setEnabled:NO];
    [self setupLabels];
    [self setupBoardBackground];
    if (!self.puzzleData)
    {
        [self setupProcessingView];
    }
}

- (void)setupBoardBackground
{
    // Set board size (it was being improperly layed out for R4 displays)
    CGRect boardFrame = self.boardBackground.frame;
    boardFrame.size.width = 320.0;
    boardFrame.size.height = 320.0;
    // Need to add 64 to the height under iOS 6.1
    if ([[[UIDevice currentDevice] systemVersion] intValue] == 6)
    {
        boardFrame.size.height = boardFrame.size.height + 64.0;
    }
    self.boardBackground.frame = boardFrame;
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
            [aValueButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [aValueButton setBackgroundImage:[UIImage imageNamed:@"HighlightCircle"] forState:UIControlStateSelected];
            [aValueButton setTitle:@"" forState:UIControlStateNormal];
            // Set the tag so we can figure out which is pressed later
            [aValueButton setTag:i];
            // Call the numberButtonPressed: method when they are pressed
            [aValueButton addTarget:self
                             action:@selector(numberButtonPressed:)
                   forControlEvents:UIControlEventTouchUpInside];
            squareButtons[i] = aValueButton;
        }
    }
}

- (void)setupProcessingView
{
    // Make the processing view components
    processingView = [[UIView alloc] init];
    // Set position and size based on the board -- it's different between iOS 6.1 and 7
    CGFloat yPos = self.boardBackground.frame.origin.y;
    CGRect processingFrame = CGRectMake(0.0, yPos, self.view.frame.size.width, self.view.frame.size.height - yPos);
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

- (void)generateAndDisplayBoard:(id)sender
{
    // Get an instance of the puzzle factory
    PuzzleMakerFactory *factory = [PuzzleMakerFactory sharedInstance];
    short *fullPuzzleArray = calloc(81, sizeof(short));
    // Generate the puzzle
    [factory getBoard:fullPuzzleArray];
    PuzzleMaker *aMaker = [[PuzzleMaker alloc] init];
    [aMaker givePuzzle:fullPuzzleArray];
    // Make our puzzle data
    short *puzzleArray = calloc(81, sizeof(short));
    if (self.difficulty == 0)
    {
        [aMaker buildEasyPuzzle];
        puzzleArray = [aMaker getWorkingPuzzle:puzzleArray];
    }
    else
    {
        [aMaker buildEasyPuzzle];
        puzzleArray = [aMaker getWorkingPuzzle:puzzleArray];
    }
    Puzzle *newPuzzleData = [[Puzzle alloc] initWithShortArray:puzzleArray];
    // Setup the board
    [self setupFromPuzzleData:newPuzzleData];
    // Animate removing the processing view
    [UIView animateWithDuration:0.4
                     animations:^(void){ [processingView setAlpha:0.0]; }
                     completion:^(BOOL finished){
                         [processingView removeFromSuperview];
                         [self.hintButton setEnabled:YES];
                     }];
    // Free and null things
    free(fullPuzzleArray);
    free(puzzleArray);
    aMaker = nil;
    // Exit the thread
    if (![NSThread isMainThread])
    {
        [NSThread exit];
    }
}

- (void)numberButtonPressed:(id)sender
{
    [self setSelectedValueButton:[sender tag]];
}

- (void)setSelectedValueButton:(NSUInteger)buttonTag
{
    self.buttonSelected = buttonTag;
    for (short i = 0; i < 81; ++i)
    {
        // Deselect all the buttons that were not pressed
        if (i != buttonTag)
        {
            [squareButtons[i] setSelected:NO];
        }
        // We need to do stuff if we're on the button that IS pressed
        else
        {
            // If it was already selected, deselect it
            if ([squareButtons[i] isSelected])
            {
                [squareButtons[i] setSelected:NO];
                self.buttonSelected = -1;
                // Also disable the setters
                for (UIButton *aButton in self.setValueButtons)
                {
                    [aButton setEnabled:NO];
                }
            }
            else
            {
                [squareButtons[i] setSelected:YES];
                // If it's an original value, we can't change it
                if ([self.puzzleData isOriginalValueAtIndex:buttonTag])
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
                            BOOL valueIsBlank = [[squareButtons[buttonTag] titleForState:UIControlStateNormal] isEqualToString:@""];
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

- (void)setupFromPuzzleData:(Puzzle *)aPuzzle
{
    self.puzzleData = aPuzzle;
    for (short i = 0; i < 81; ++i)
    {
        // Grab the value
        short value = [self.puzzleData getPuzzleValueAtIndex:i];
        BOOL isOriginal = [self.puzzleData isOriginalValueAtIndex:i];
        NSString *valString;
        // If it's non-zero, set the string up
        if (value != 0)
        {
            valString = [NSString stringWithFormat:@"%d", value];
        }
        // If it's zero, make the string blank
        else
        {
            valString = @"";
        }
        // Change the text color accordingly
        if (!isOriginal)
        {
            [squareButtons[i] setTitleColor:[PPSudokuView userValueColor] forState:UIControlStateNormal];
        }
        
        [squareButtons[i] setTitle:valString forState:UIControlStateNormal];
    }
}

- (void)setGame:(Puzzle *)thePuzzle
{
    self.puzzleData = thePuzzle;
}

// Do stuff that needs to be done before a segue, like sending values ahead.
// Fires only if shouldPerformSegueWithIdentifier:sender: returned YES.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue destinationViewController] class] == [PPHintViewController class])
    {
        PPHintViewController *controller = [segue destinationViewController];
        controller.delegate = self;
        [controller setPuzzleData:self.puzzleData];
        self.puzzleData = nil;
    }
}

@end
