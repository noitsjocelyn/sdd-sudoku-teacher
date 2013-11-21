//
//  PPSudokuGameControllerViewController.m
//  Sudoku Teacher
//
//  Created by Jonathan on 10/25/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import "PPGameTimer.h"
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

#pragma mark UIViewController methods

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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Set up the timer
    timer = [[PPGameTimer alloc] initWithSeconds:progressSeconds];
    [timer setNavigationBar:self.navigationItem];
    // Either make a new board...
    if (!puzzleData)
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
        if (isTutorial)
        {
            if ([self isMovingToParentViewController])
            {
                UIAlertView *tutorialAlert = [[UIAlertView alloc] initWithTitle:@"Complete This Puzzle"
                                                                        message:@"To enter a value, select a square then tap a number at the bottom of the screen. If you get stuck, press the Hint button in the top right."
                                                                       delegate:self
                                                              cancelButtonTitle:@"Start Puzzle"
                                                              otherButtonTitles:nil];
                [tutorialAlert show];
            }
        }
        [self setupFromPuzzleData:puzzleData];
        [self.hintButton setEnabled:YES];
        [timer startTimer];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Segue methods

// Fires when we are leaving the view, ie. seguing back
- (void)viewWillDisappear:(BOOL)animated
{
    [self.delegate setGameInProgress:puzzleData];
    puzzleData = nil;
    [self.delegate setGameProgressTime:[timer getTime]];
    [timer stopTimer];
    [self.delegate setGameDifficulty:difficulty];
}

// Do stuff that needs to be done before a segue, like sending values ahead.
// Fires only if shouldPerformSegueWithIdentifier:sender: returned YES.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue destinationViewController] class] == [PPHintViewController class])
    {
        PPHintViewController *controller = [segue destinationViewController];
        controller.delegate = self;
        [controller setGameInProgress:puzzleData];
        puzzleData = nil;
        [controller setGameProgressTime:[timer getTime]];
        [timer stopTimer];
        [controller setGameDifficulty:difficulty];
        [controller setIsGameTutorial:isTutorial];
    }
}

#pragma mark IBAction methods

- (IBAction)setValue:(id)sender
{
    short location = self.buttonSelected;
    // Don't allow modification of original values
    if ([puzzleData isOriginalValueAtIndex:location])
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
        [puzzleData putInValue:(location * 9 + value)];
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
        [puzzleData resetSquareAtIndex:location];
    }
    // Set the new title
    [buttonToChange setTitle:newTitle forState:UIControlStateNormal];
    // Check puzzle for completion
    [self checkPuzzleCompletion];
}

- (IBAction)numberButtonPressed:(id)sender
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
                if ([puzzleData isOriginalValueAtIndex:buttonTag])
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

#pragma mark Puzzle completion and correctness

- (void)checkPuzzleCompletion
{
    if ([puzzleData isFinished])
    {
        [timer stopTimer];
        if (!isTutorial)
        {
            completeAlert = [[UIAlertView alloc] initWithTitle:@"Puzzle Complete"
                                                       message:[self randomCongratulatoryPhrase]
                                                      delegate:self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        }
        else
        {
            completeAlert = [[UIAlertView alloc] initWithTitle:@"Tutorial Complete"
                                                       message:@"Congratulations! You have finished the tutorial. Now try some other puzzles! Don't forget the Hint button if you get stuck."
                                                      delegate:self
                                             cancelButtonTitle:@"Go to Start Menu"
                                             otherButtonTitles:nil];
        }
        [completeAlert show];
    }
}

- (NSString *)randomCongratulatoryPhrase
{
    NSArray *phrases = [NSArray arrayWithObjects:
                        @"Way to go!",
                        @"You rock!",
                        @"Go you!",
                        @"Excellent!",
                        @"Nicely done!",
                        @"You're the best!",
                        @"Fantastic!",
                        @"Awesome!",
                        @"Wooo!",
                        @"Gold star!",
                        nil];
    NSUInteger randomIndex = arc4random_uniform((u_int32_t)[phrases count]);
    return [phrases objectAtIndex:randomIndex];
}

#pragma mark Setup helper methods

// Setup our subviews in the correct order (since some depend on each other)
- (void)setupSubviews
{
    [self.hintButton setEnabled:NO];
    [self setupLabels];
    [self setupBoardBackground];
    if (!puzzleData)
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
    if (difficulty == 0)
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
                         [timer startTimer];
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

- (void)setupFromPuzzleData:(Puzzle *)aPuzzle
{
    puzzleData = aPuzzle;
    for (short i = 0; i < 81; ++i)
    {
        // Grab the value
        short value = [puzzleData getPuzzleValueAtIndex:i];
        BOOL isOriginal = [puzzleData isOriginalValueAtIndex:i];
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

#pragma mark UIAlertViewDelegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // See if we're coming from the new game alert
    if (alertView == completeAlert)
    {
        if (isTutorial)
        {
            [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
        }
    }
}

#pragma mark PPGameDataProtocol methods

- (void)setGameInProgress:(Puzzle *)thePuzzle
{
    puzzleData = thePuzzle;
}

- (void)setGameProgressTime:(NSUInteger)seconds
{
    progressSeconds = seconds;
}

- (void)setGameDifficulty:(NSUInteger)gameDifficulty
{
    difficulty = gameDifficulty;
}

- (void)setIsGameTutorial:(BOOL)isGameTutorial
{
    isTutorial = isGameTutorial;
}

@end
