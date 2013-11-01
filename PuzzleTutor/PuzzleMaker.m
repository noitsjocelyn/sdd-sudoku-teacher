#import <stdlib.h>
#import "PuzzleMaker.h"
#import "Puzzle.h"

#define CONSECUTIVE_FAIL_THRESHOLD 500

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
- (void)givePuzzle:(short *)thePuzzle
{
	for (short i = 0; i < 81; ++i)
	{
		givenPuzzle[i] = thePuzzle[i];
	}
}

- (short *)getWorkingPuzzle:(short *)outputArray
{
    for (short i = 0; i < 81; ++i)
    {
        outputArray[i] = workingPuzzle[i];
    }
	return outputArray;
}

- (short *)buildEasyPuzzle:(short *)outputArray
{
    [self makeEasyPuzzle];
    return [self getWorkingPuzzle:outputArray];
}

- (short *)buildMediumPuzzle:(short *)outputArray
{
    [self makeMediumPuzzle];
    return [self getWorkingPuzzle:outputArray];
}

/* The makeEasyPuzzle function. It uses count to track how many locations have
 * been filled, either by deduciton or by displaying the value. Inside of a
 * loop, it first looks to deduce a location's value by the
 * findSquareWithOneAvaiableValue algorithm. If that fails, it generates random
 * numbers between 0 and 40 until it finds one such that that location and 80
 * minus that location are both unfilled. It then makes those squares' values
 * part of the initial puzzle displayed to the user.
 */
- (void)makeEasyPuzzle
{
	short count = 0;
    short previousCount = 0;
    short consecutiveFails = 0;
	while (count < 81)
	{
        previousCount = count;
        short *results = calloc(4, sizeof(short));
		results = [basePuzzle findSquareWithOneAvailableValue:results];
		if (results[0] != 0)
		{
			[basePuzzle putInValue:(results[2] * 9 + results[3])];
			++count;
		}
		else
		{
            // Random number from 0-40
			int r = arc4random() % 41;
            // That number's mirror
			int r2 = 80 - r;
			BOOL alreadyCounted = NO;
			BOOL alreadyCounted2 = NO;
			if ([basePuzzle getPuzzleValueAtIndex: r] != 0)
			{
				alreadyCounted = YES;
			}
			[basePuzzle putInValue:(givenPuzzle[r] + r * 9)];
			if (workingPuzzle[r] != givenPuzzle[r])
			{
				workingPuzzle[r] = givenPuzzle[r];
				if (alreadyCounted == NO)
				{
					++count;
				}
			}
            // The mirror of the 40th square is itself, so don't do this
			if (r != 40)
			{
				if ([basePuzzle getPuzzleValueAtIndex: r2] != 0)
				{
					alreadyCounted2 = YES;
				}
				[basePuzzle putInValue:(givenPuzzle[r2] + r2 * 9)];
				if (workingPuzzle[r2] != givenPuzzle[r2])
				{
					workingPuzzle[r2] = givenPuzzle[r2];
					if (alreadyCounted == NO)
					{
						++count;
					}
				}
			}
		}
        free(results);
        if (previousCount == count)
        {
            ++consecutiveFails;
        }
        if (consecutiveFails > CONSECUTIVE_FAIL_THRESHOLD)
        {
            break;
        }
	}
}

/* The makeMediumPuzzle function. It uses count to track how many locations
 * have been filled, either by deduciton or by displaying the value. Inside of
 * a loop, it first looks to deduce a location's value by the
 * findSquareWithOneAvaiableValue algorithm.
 * Failing that, it moves on to the findSquareInChunkWithRequiredValue
 * algorithm. If that fails, it generates random numbers between 0 and 40 until
 * it finds one such that that location and 80 minus that location are both
 * unfilled. It then makes those squares' values part of the initial puzzle
 * displayed to the user.
 */
- (void)makeMediumPuzzle
{
	short count = 0;
    short previousCount = 0;
    short consecutiveFails = 0;
	while (count < 81)
	{
        previousCount = count;
        short *results = calloc(4, sizeof(short));
		results = [basePuzzle findSquareWithOneAvailableValue:results];
		if (results[0] != 0)
		{
			[basePuzzle putInValue:(results[2] * 9 + results[3])];
			++count;
		}
		else
		{
			results = [basePuzzle findSquareInChunkWithRequiredValue:results];
			if (results[0] != 0)
			{
				[basePuzzle putInValue:(results[2] * 9 + results[3])];
				++count;
			}
			else
			{
                // Random number from 0-40
				int r = arc4random() % 41;
                // That number's mirror
				int r2 = 80 - r;
				BOOL alreadyCounted = NO;
				BOOL alreadyCounted2 = NO;
				if ([basePuzzle getPuzzleValueAtIndex:r] != 0)
				{
					alreadyCounted = YES;
				}
				[basePuzzle putInValue:(givenPuzzle[r] + r * 9)];
				if (workingPuzzle[r] != givenPuzzle[r])
				{
					workingPuzzle[r] = givenPuzzle[r];
					if (alreadyCounted == NO)
					{
						++count;
					}
				}
                // The mirror of the 40th square is itself, so don't do this
				if (r != 40)
				{
					if ([basePuzzle getPuzzleValueAtIndex:r2] != 0)
					{
						alreadyCounted = YES;
					}
					[basePuzzle putInValue:(givenPuzzle[r2] + r2 * 9)];
					if (workingPuzzle[r2] != givenPuzzle[r2])
					{
						workingPuzzle[r2] = givenPuzzle[r2];
						if (alreadyCounted2 == NO)
						{
							++count;
						}
					}
				}
			}
		}
        free(results);
        if (previousCount == count)
        {
            ++consecutiveFails;
        }
        if (consecutiveFails > CONSECUTIVE_FAIL_THRESHOLD)
        {
            break;
        }
	}
}

@end
