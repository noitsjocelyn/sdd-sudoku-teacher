#import "PuzzleMaker.h"
#import <stdlib.h>

@implementation PuzzleMaker

- (id)init
{
    for (short i = 0; i < 81; ++i)
    {
        workingPuzzle[i] = 0;
    }
    basePuzzle = [[Puzzle alloc] init];
    return self;
}

- (void)givePuzzle:(short *)thePuzzle
{
	for (short i = 0; i < 81; i++)
	{
		givenPuzzle[i] = thePuzzle[i];
	}
}

- (short *)buildMediumPuzzle
{
	short count = 0;
	while (count < 81)
	{
		short *results = [basePuzzle findSquareWithOneAvailableValue];
		if (results[0] != 0)
		{
			[basePuzzle putInValue: (results[2] * 9 + results[3])];
			count += 1;
		}
		else
		{
			results = [basePuzzle findSquareInChunkWithRequiredValue];
			if (results[0] != 0)
			{
				[basePuzzle putInValue: (results[2] * 9 + results[3])];
				count += 1;
			}
			else
			{
				int r = arc4random() % 41;
				int r2 = 80 - r;
				while ([basePuzzle checkIfSquareIsFilled:r] == YES || [basePuzzle checkIfSquareIsFilled:r2] == YES)
				{
					r = arc4random() % 41;
					r2 = 80 - r;
				}
				[basePuzzle putInValue: (givenPuzzle[r] + r * 9)];
				workingPuzzle[r] = givenPuzzle[r];
				count += 1;
				if (r != 40)
				{
					[basePuzzle putInValue: (givenPuzzle[r2] + r2 * 9)];
					workingPuzzle[r2] = givenPuzzle[r2];
					count += 1;
				}
			}
		}
	}
	return workingPuzzle;
}

- (short *) buildEasyPuzzle
{
	short count = 0;
	while (count < 81)
	{
		short *results = [basePuzzle findSquareWithOneAvailableValue];
		if (results[0] != 0)
		{
			[basePuzzle putInValue: (results[2] * 9 + results[3])];
			count += 1;
		}	
		else
		{
			int r = arc4random() % 41;
			int r2 = 80 - r;
			while ([basePuzzle checkIfSquareIsFilled:r] == YES || [basePuzzle checkIfSquareIsFilled:r2] == YES)
			{
				r = arc4random() % 41;
				r2 = 80 - r;
			}
			[basePuzzle putInValue: (givenPuzzle[r] + r * 9)];
			workingPuzzle[r] = givenPuzzle[r];
			count += 1;
			if (r != 40)
			{
				[basePuzzle putInValue: (givenPuzzle[r2] + r2 * 9)];
				workingPuzzle[r2] = givenPuzzle[r2];
				count += 1;
			}
		}
	}
	return workingPuzzle;
}