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
	[processingView setFrame:CGRectMake(0.0, 64.0, self.view.frame.size.width, self.view.frame.size.height - 64.0)];
	[processingView setBackgroundColor:[UIColor blackColor]];
	[processingView setAlpha:0.6];
	// Place the spinner in the middle
	// Note: This frame is relative to processingView, not to self.view
	// Also, standard spinner size is 37 by 37
	processingIndicator = [[UIActivityIndicatorView alloc] init];
	[processingIndicator setFrame:CGRectMake(142.5, 142.5, 37.0, 37.0)];
	[processingView addSubview:processingIndicator];
	[processingIndicator startAnimating];
	// Add the view
	[self.view addSubview:processingView];
	// Spin off the process generation to its own thread
	[NSThread detachNewThreadSelector:@selector(generateAndDisplayBoardWithDifficulty:) toTarget:self withObject:[NSNumber numberWithInt:0]];
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
			float xPos = 4 + 1.5 * x + 34 * x;
			float yPos = 4 + 1.5 * y + 34 * y;
			// Offset by the position of the board background
			xPos += self.boardBackground.frame.origin.x;
			yPos += self.boardBackground.frame.origin.y;
			// Slight position adjustments for the last two rows/columns
			if (x == 8)
			{
				xPos -= 1.5;
			}
			if (y == 8)
			{
				yPos -= 1.5;
			}
			if (x == 7)
			{
				xPos -= 0.5;
			}
			if (y == 7)
			{
				yPos -= 0.5;
			}
			// Set up the label
			float labelSize = 31.0;
			UILabel *aLabel = [[UILabel alloc] initWithFrame:CGRectMake(xPos, yPos, labelSize, labelSize)];
			[aLabel setTextColor:[UIColor blackColor]];
			[aLabel setTextAlignment:NSTextAlignmentCenter];
			[aLabel setFont:[UIFont fontWithName:@"Helvetica Neu" size:35.0]];
			[aLabel setBackgroundColor:[UIColor clearColor]];
			[aLabel setText:@""];
			valueLabels[i] = aLabel;
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
		[valueLabels[i] setText:valString];
	}
}

- (void)generateAndDisplayBoardWithDifficulty:(NSNumber *)difficulty
{
	// Generate the puzzle
	SudokuBoard *aBoard = [SudokuBoardGenerator generate];
	[self setValuesFromShortArray:[aBoard boardAsShortArray]];
	aBoard = Nil;
	// Animate removing the processing view
	[UIView animateWithDuration:0.4
					 animations:^(void)
	 {
		 [processingView setAlpha:0.0];
	 }
					 completion:^(BOOL finished)
	 {
		 [processingView removeFromSuperview];
	 }
	 ];
	// Since we're running this in its own thread, exit it
	[NSThread exit];
}

@end
