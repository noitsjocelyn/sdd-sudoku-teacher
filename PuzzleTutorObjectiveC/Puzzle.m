/* Implementation of the Puzzle class
 */ 

#import "Puzzle.h"

@implementation Puzzle

- (id)init
{
    for (short i = 0; i < 81; ++i)
    {
        puzzle[i] = 0;
        locAvail[i] = 9;
        blockNums[i] = NO;
        blockAvail[i] = 0;
        for (short j = 0; j < 9; ++j)
        {
            avail[i * 9 + j] = YES;
        }
    }
    return self;
}

/* Searches through the puzzle for a square with only 1 number that can go in
 * it. It then returns the menthod (1), submethod (1), square number, and
 * number to be input.
 */
- (short *)onlyAvail 
{
    for (short i = 0; i < 81; ++i)
    {
        if (locAvail[i] == 1)
        {
            for (short j = 0; j < 9; ++j)
            {
                if (avail[i * 81 + j])
                {
                    short *results = calloc(4, sizeof(short));
                    results[0] = 1;
                    results[1] = 1;
                    results[2] = i;
                    results[3] = j + 1;
                    return results;
                }

            }

        }

    }
    short *results = calloc(4, sizeof(short));
    results[0] = 0;
    return results;
}

/* Looks for a block, column or row that has only one sqaure a number can
 * appear. It returns an array of 4 values: 2 (method used), [1,2,3]
 * (corresponding to block, column, row), location, and number to be put in.
 */
- (short *)oneLoc
{
    for (short i = 0; i < 81; ++i)
    {
        if (!blockNums[i])
        {
            if (blockAvail[i] == 1)
            {
                short numBlock = i / 9;
                short numSearch = i % 9;
                for (short j = 0; j < 9; ++j)
                {
                    short preCompute =
                        27 * (numBlock % 3) + 243 * (numBlock / 3) + 9 *
                        (j % 3) + 81 * (j / 3) + numSearch;
                    if (avail[preCompute])
                    {
                        short *results = calloc(4, sizeof(short));
                        results[0] = 2;
                        results[1] = 1;
                        results[2] = preCompute / 9;
                        results[3] = preCompute % 9;
                        return results;
                    }
                }
            }
        }
    }
    for (short i = 0; i < 9; ++i)
    {
        short holder = 0;
        for (short j = 0; j < 9; ++j)
        {
            for (short k = 0; k < 9; ++k)
            {
                if (avail[k * 81 + j * 9 + i] == 1)
                {
                    if (holder != 0)
                    {
                        holder = -1;
                    }
                    else if (holder == 0)
                    {
                        holder = k * 81 + j * 9 + i;
                    }
                }
            }
            if (holder > 0)
            {
                short *results = calloc(4, sizeof(short));
                results[0] = 2;
                results[1] = 2;
                results[2] = holder / 9;
                results[3] = holder % 9;
                return results;
            }
        }
        for (short i = 0; i < 9; ++i)
        {
            short holder = 0;
            for (short k = 0; k < 9; ++k)
            {
                for (short j = 0; j < 9; ++j)
                {
                    if (avail[k * 81 + j * 9 + i] == 1)
                    {
                        if (holder != 0)
                        {
                            holder = -1;
                        }
                        else if (holder == 0)
                        {
                            holder = k * 81 + j * 9 + i;
                        }
                    }
                }
                if (holder > 0)
                {
                    short *results = calloc(4, sizeof(short));
                    results[0] = 2;
                    results[1] = 3;
                    results[2] = holder / 9;
                    results[3] = holder % 9;
                    return results;
                }
            }
        }
    }
    short *results = calloc(4, sizeof(short));
    return results;
}

/* Sets up a puzzle given an input array.
 * Params:
 *   puzzleInput:
 *     An array of 81 shorts that contains the puzzle values.
 */
- (void)setPuzzle:(short *)puzzleInput
{
    for (short i = 0; i < 81; ++i)
    {
        puzzle[i] = puzzleInput[i];
        if (puzzleInput[i] != 0)
        {
            locAvail[i] = 0;
            short numBlock = (i / 27) * 3 + (i / 3) % 3;
            for (short j = 0; j < 9; j++)
            {
                avail[i * 9 + j] = NO;
                blockNums[numBlock * 9 + puzzleInput[i]] = YES;
            }
        }
    }
    for (short i = 0; i < 81; ++i)
    {
        if (puzzle[i] == 0)
        {
            short numBlock = (i / 27) * 3 + (i / 3) % 3;
            bool found[9];
            for (short j = 0; j < 9; ++j)
            {
                found[j] = YES;
            }
            short loc;
            for (short j = 0; j < 9; ++j)
            {
                loc = (i / 9) * 9 + j;
                if (puzzle[loc] != 0)
                {
                    found[puzzle[loc] - 1] = NO;
                }
                loc = (i % 9) + 9 * j;
                if (puzzle[loc] != 0)
                {
                    found[puzzle[loc] - 1] = NO;
                }
                loc = (numBlock % 3) * 3 + (numBlock / 3) * 27 + j % 3 + j / 3;
                if (puzzle[loc] != 0)
                {
                    found[puzzle[loc] - 1] = NO;
                }
            }
            for (short j = 0; j < 9; ++j)
            {
                short sum = 0;
                avail[i * 9 + j] = found[j];
                if (found[j] == YES)
                {
                    ++sum;
                    blockAvail[numBlock * 9 + j] += 1;
                }
                locAvail[i] = sum;
            }
        }
    }
}

@end
