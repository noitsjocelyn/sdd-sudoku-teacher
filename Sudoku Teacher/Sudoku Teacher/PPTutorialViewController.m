//
//  PPTutorialViewController.m
//  Sudoku Teacher
//
//  Created by Jonathan on 11/20/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import "PPTutorialViewController.h"

#import "PPSudokuView.h"
#import "Puzzle.h"

@interface PPTutorialViewController ()

@end

@implementation PPTutorialViewController

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
    [self setupHintPuzzleLabels];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (short i = 0; i < 81; ++i)
    {
        [self.boardView.superview addSubview:labels[i]];
    }
    [self setupFromPuzzleData:puzzleData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupHintPuzzleLabels
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
            xPos += self.boardView.frame.origin.x;
            yPos += self.boardView.frame.origin.y;
            // Slight position adjustments for the last two rows/columns
            if (x == 7) xPos -= 0.5;
            if (y == 7) yPos -= 0.5;
            if (x == 8) xPos -= 1.5;
            if (y == 8) yPos -= 1.5;
            // Set up the value buttons
            float labelSize = 20.0;
            CGRect labelFrame = CGRectMake(xPos, yPos, labelSize, labelSize);
            // Make the labels and add them
            UILabel *aLabel = [[UILabel alloc] init];
            [self setupSinglePuzzleLabel:aLabel frame:labelFrame tag:i];
            labels[i] = aLabel;
        }
    }
}

- (void)setupSinglePuzzleLabel:(UILabel *)aLabel frame:(CGRect)aFrame tag:(NSUInteger)aTag
{
    [aLabel setFrame:aFrame];
    [aLabel setBackgroundColor:[UIColor clearColor]];
    [aLabel setTextColor:[UIColor blackColor]];
    [aLabel setText:@""];
    [aLabel setTextAlignment:NSTextAlignmentCenter];
    // Set the tag so we can highlight them later
    [aLabel setTag:aTag];
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
            [labels[i] setTextColor:[PPSudokuView userValueColor]];
        }
        
        [labels[i] setText:valString];
    }
}

@end
