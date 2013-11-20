//
//  PPHintViewController.m
//  Sudoku Teacher
//
//  Created by Jonathan on 11/18/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import "PPHintViewController.h"
#import "Hint.h"
#import "HintsMaker.h"
#import "PPSudokuView.h"
#import "Puzzle.h"

@interface PPHintViewController ()

@end

@implementation PPHintViewController

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
    aHintMaker = [[HintsMaker alloc] init];
    [self makeHintFrames];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupHintInterfaces];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.delegate setGame:self.puzzleData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)makeHintFrames
{
    // Default to first hint
    shownHint = 1;
    CGFloat viewW = 320.0;
    CGFloat viewH = 320.0;
    CGFloat titleH = 64.0;
    CGFloat buttonH = 48.0;
    // Title bar has 0 height under iOS 6.1
    if ([[[UIDevice currentDevice] systemVersion] intValue] == 6)
    {
        titleH = 0.0;
    }
    hintTwoShownFrame = CGRectMake(0.0, titleH + buttonH, viewW, viewH);
    hintTwoHiddenFrame = CGRectMake(0.0, titleH + viewH, viewW, viewH);
    hintThreeShownFrame = CGRectMake(0.0, titleH + (2 * buttonH), viewW, viewH);
    hintThreeHiddenFrame = CGRectMake(0.0, titleH + viewH + buttonH, viewW, viewH);
}

- (void)setupHintInterfaces
{
    hints = [aHintMaker createHints:self.puzzleData];
    // Set hint labels
    [self.hintOneLabel setText:[[hints objectAtIndex:0] hintText]];
    [self.hintTwoLabel setText:[[hints objectAtIndex:1] hintText]];
    [self.hintThreeLabel setText:[[hints objectAtIndex:2] hintText]];
    // Add our buttons
    [self setupSquareButtons];
    for (short i = 0; i < 81; ++i)
    {
        [self.hintTwoView addSubview:squareButtonsTwo[i]];
        [self.hintThreeView addSubview:squareButtonsThree[i]];
    }
    // Figure out what we're highlighting
    NSArray *firstHighlights = [[hints objectAtIndex:1] firstLevelHighlights];
    for (int i = 0; i < [firstHighlights count]; ++i)
    {
        short loc = [[firstHighlights objectAtIndex:i] shortValue];
        [squareButtonsTwo[loc] setBackgroundColor:[UIColor grayColor]];
        [squareButtonsThree[loc] setBackgroundColor:[UIColor grayColor]];
    }
    short loc = [[[hints objectAtIndex:2] secondLevelHighlight] shortValue];
    [squareButtonsThree[loc] setBackgroundColor:[UIColor greenColor]];
    // Add all the numbers
    [self setupFromPuzzleData:self.puzzleData];
}

- (void)setupSquareButtons
{
    for (short x = 0; x < 9; ++x)
    {
        for (short y = 0; y < 9; ++y)
        {
            // Get the index out of 81
            short i = 9 * x + y;
            // Get the position offsets
            float xPos = 2 + 24.5 * x;
            float yPos = 2 + 24.5 * y;
            // Offset by the position of the board background
            xPos += self.boardBackgroundTwo.frame.origin.x;
            yPos += self.boardBackgroundTwo.frame.origin.y;
            // Slight position adjustments for the last two rows/columns
            if (x == 7) xPos -= 0.5;
            if (y == 7) yPos -= 0.5;
            if (x == 8) xPos -= 1.5;
            if (y == 8) yPos -= 1.5;
            // Set up the value buttons
            float buttonSize = 20.0;
            CGRect buttonFrame = CGRectMake(xPos, yPos, buttonSize, buttonSize);
            UIButton *valueButtonTwo = [[UIButton alloc] init];
            [self setupSingleSquareButton:valueButtonTwo frame:buttonFrame tag:i];
            UIButton *valueButtonThree = [[UIButton alloc] init];
            [self setupSingleSquareButton:valueButtonThree frame:buttonFrame tag:i];
            squareButtonsTwo[i] = valueButtonTwo;
            squareButtonsThree[i] = valueButtonThree;
        }
    }
}

- (void)setupSingleSquareButton:(UIButton *)theButton frame:(CGRect)aFrame tag:(NSUInteger)aTag
{
    [theButton setFrame:aFrame];
    [theButton setBackgroundColor:[UIColor clearColor]];
    [theButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [theButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [theButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [theButton setTitle:@"" forState:UIControlStateNormal];
    // Set the tag so we can highlight them later
    [theButton setTag:aTag];
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
            [squareButtonsTwo[i] setTitleColor:[PPSudokuView userValueColor] forState:UIControlStateNormal];
            [squareButtonsThree[i] setTitleColor:[PPSudokuView userValueColor] forState:UIControlStateNormal];
        }
        
        [squareButtonsTwo[i] setTitle:valString forState:UIControlStateNormal];
        [squareButtonsThree[i] setTitle:valString forState:UIControlStateNormal];
    }
}

- (IBAction)showHintOne:(id)sender {
    if (shownHint == 2)
    {
        [UIView animateWithDuration:ANIMATE_TIME animations:^(void) {
            [self.hintTwoView setFrame:hintTwoHiddenFrame];
        }];
    }
    else if (shownHint == 3)
    {
        [UIView animateWithDuration:ANIMATE_TIME animations:^(void) {
            [self.hintTwoView setFrame:hintTwoHiddenFrame];
            [self.hintThreeView setFrame:hintThreeHiddenFrame];
        }];
    }
    shownHint = 1;
}

- (IBAction)showHintTwo:(id)sender {
    if (shownHint == 1)
    {
        [UIView animateWithDuration:ANIMATE_TIME animations:^(void) {
            [self.hintTwoView setFrame:hintTwoShownFrame];
        }];
    }
    else if (shownHint == 3)
    {
        [UIView animateWithDuration:ANIMATE_TIME animations:^(void) {
            [self.hintThreeView setFrame:hintThreeHiddenFrame];
        }];
    }
    shownHint = 2;
}

- (IBAction)showHintThree:(id)sender {
    if (shownHint == 1)
    {
        [UIView animateWithDuration:ANIMATE_TIME animations:^(void) {
            [self.hintTwoView setFrame:hintTwoShownFrame];
            [self.hintThreeView setFrame:hintThreeShownFrame];
        }];
    }
    else if (shownHint == 2)
    {
        [UIView animateWithDuration:ANIMATE_TIME animations:^(void) {
            [self.hintThreeView setFrame:hintThreeShownFrame];
        }];
    }
    shownHint = 3;
}

@end
