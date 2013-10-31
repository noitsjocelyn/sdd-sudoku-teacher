#import <stdlib.h>
#import "PuzzleMaker.h"
#import "Puzzle.h"

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

/* The givePuzzle function. When given a short array representation of a puzzle,
 * it sets the givenPuzzle member to the given puzzle.
 */
- (short *)getWorkingPuzzle
{
	return workingPuzzle;
}

- (void)givePuzzle:(short *)thePuzzle
{
	for (short i = 0; i < 81; ++i)
	{
		givenPuzzle[i] = thePuzzle[i];
	}
}

/* The buildMediumPuzzle function. It uses count to track how many locations
 * have been filled, either by deduciton or by displaying the value. Inside of
 * a loop, it first looks to deduce a location's value by the
 * findSquareWithOneAvaiableValue algorithm.
 * Failing that, it moves on to the findSquareInChunkWithRequiredValue
 * algorithm. If that fails, it generates random numbers between 0 and 40 until
 * it finds one such that that location and 80 minus that location are both
 * unfilled. It then makes those squares' values part of the initial puzzle
 * displayed to the user.
 */
- (short *)buildMediumPuzzle
{
	short count = 0;
	while (count < 81)
	{
		short *results = [basePuzzle findSquareWithOneAvailableValue];
		if (results[0] != 0)
		{
			[basePuzzle putInValue:(results[2] * 9 + results[3])];
			count += 1;
		}
		else
		{
			results = [basePuzzle findSquareInChunkWithRequiredValue];
			if (results[0] != 0)
			{
				[basePuzzle putInValue:(results[2] * 9 + results[3])];
				count += 1;
			}
			else
			{
				int r = arc4random() % 41;
				int r2 = 80 - r;
				[basePuzzle putInValue:(givenPuzzle[r] + r * 9)];
				if (workingPuzzle[r] != givenPuzzle[r])
				{
					workingPuzzle[r] = givenPuzzle[r];
					count += 1;
				}
				if (r != 40)
				{
					[basePuzzle putInValue:(givenPuzzle[r2] + r2 * 9)];
					if (workingPuzzle[r] != givenPuzzle[r])
					{
						workingPuzzle[r2] = givenPuzzle[r2];
						count += 1;
					}
				}
			}
		}
        free(results);
	}
	return workingPuzzle;
}

/* The buildEasyPuzzle function. It uses count to track how many locations have
 * been filled, either by deduciton or by displaying the value. Inside of a
 * loop, it first looks to deduce a location's value by the
 * findSquareWithOneAvaiableValue algorithm. If that fails, it generates random
 * numbers between 0 and 40 until it finds one such that that location and 80
 * minus that location are both unfilled. It then makes those squares' values
 * part of the initial puzzle displayed to the user.
 */
- (short *) buildEasyPuzzle
{
	short count = 0;
	while (count < 81)
	{
		short *results = [basePuzzle findSquareWithOneAvailableValue];
		if (results[0] != 0)
		{
			[basePuzzle putInValue:(results[2] * 9 + results[3])];
			count += 1;
		}	
		else
		{
			int r = arc4random() % 41;
			int r2 = 80 - r;
			[basePuzzle putInValue:(givenPuzzle[r] + r * 9)];
			if (workingPuzzle[r] != givenPuzzle[r])
			{
				workingPuzzle[r] = givenPuzzle[r];
				count += 1;
			}
			if (r != 40)
			{
				[basePuzzle putInValue:(givenPuzzle[r2] + r2 * 9)];
				if (workingPuzzle[r2] != givenPuzzle[r2])
				{
					workingPuzzle[r2] = givenPuzzle[r2];
					count += 1;
				}
			}
		}
        free(results);
	}
	return workingPuzzle;
}

@end
