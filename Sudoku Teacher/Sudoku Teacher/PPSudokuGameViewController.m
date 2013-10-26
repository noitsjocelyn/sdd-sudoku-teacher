//
//  PPSudokuGameControllerViewController.m
//  Sudoku Teacher
//
//  Created by Jonathan on 10/25/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import "PPSudokuGameViewController.h"
#import "PPSudokuView.h"

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
			[aLabel setText:@"0"];
			valueLabels[i] = aLabel;
		}
	}
}

- (void)setValues:(short *)valuesArray
{
	for (short i = 0; i < 81; ++i)
	{
		short val = valuesArray[i];
		
		NSString *valString;
		if (val != 0)
		{
			valString = [NSString stringWithFormat:@"%d", val];
		}
		else
		{
			valString = @"";
		}
		[valueLabels[i] setText:valString];
	}
}

@end
