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

/* The makeEasyPuzzle function. It uses count to track how many locations have
 * been filled, either by deduciton or by displaying the value. Inside of a
 * loop, it first looks to deduce a location's value by the
 * findSquareWithOneAvaiableValue algorithm. If that fails, it generates random
 * numbers between 0 and 40 until it finds one such that that location and 80
 * minus that location are both unfilled. It then makes those squares' values
 * part of the initial puzzle displayed to the user.
 */
- (void)buildEasyPuzzle
{
    Puzzle *basePuzzle = [[Puzzle alloc] init];
    short count = 0;
    while (count < 81)
    {
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
            int r1 = arc4random() % 41;
            BOOL alreadyCounted1 = NO;
            if ([basePuzzle getPuzzleValueAtIndex:r1] != 0)
            {
                alreadyCounted1 = YES;
            }
            [basePuzzle putInValue:(givenPuzzle[r1] + r1 * 9)];
            if (workingPuzzle[r1] != givenPuzzle[r1])
            {
                workingPuzzle[r1] = givenPuzzle[r1];
                if (!alreadyCounted1)
                {
                    ++count;
                }
            }
            // The mirror of the 40th square is itself, so don't do this
            if (r1 != 40)
            {
                // r1's mirror
                int r2 = 80 - r1;
                BOOL alreadyCounted2 = NO;
                if ([basePuzzle getPuzzleValueAtIndex:r2] != 0)
                {
                    alreadyCounted2 = YES;
                }
                [basePuzzle putInValue:(givenPuzzle[r2] + r2 * 9)];
                if (workingPuzzle[r2] != givenPuzzle[r2])
                {
                    workingPuzzle[r2] = givenPuzzle[r2];
                    if (!alreadyCounted2)
                    {
                        ++count;
                    }
                }
            }
        }
        free(results);
    }
    #if !(__has_feature(objc_arc))
    [basePuzzle release];
    #endif
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
- (void)buildMediumPuzzle
{
    Puzzle *basePuzzle = [[Puzzle alloc] init];
    short count = 0;
    while (count < 81)
    {
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
                int r1 = arc4random() % 41;
                BOOL alreadyCounted1 = NO;
                if ([basePuzzle getPuzzleValueAtIndex:r1] != 0)
                {
                    alreadyCounted1 = YES;
                }
                [basePuzzle putInValue:(givenPuzzle[r1] + r1 * 9)];
                if (workingPuzzle[r1] != givenPuzzle[r1])
                {
                    workingPuzzle[r1] = givenPuzzle[r1];
                    if (!alreadyCounted1)
                    {
                        ++count;
                    }
                }
                // The mirror of the 40th square is itself, so don't do this
                if (r1 != 40)
                {
                    // r1's mirror
                    int r2 = 80 - r1;
                    BOOL alreadyCounted2 = NO;
                    if ([basePuzzle getPuzzleValueAtIndex:r2] != 0)
                    {
                        alreadyCounted2 = YES;
                    }
                    [basePuzzle putInValue:(givenPuzzle[r2] + r2 * 9)];
                    if (workingPuzzle[r2] != givenPuzzle[r2])
                    {
                        workingPuzzle[r2] = givenPuzzle[r2];
                        if (!alreadyCounted2)
                        {
                            ++count;
                        }
                    }
                }
            }
        }
        free(results);
    }
    #if !(__has_feature(objc_arc))
    [basePuzzle release];
    #endif
}

@end
