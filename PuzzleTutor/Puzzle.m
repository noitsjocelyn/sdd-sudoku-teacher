/* Implementation of the Puzzle class.
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
        blockAvail[i] = 9;
        for (short j = 0; j < 9; ++j)
        {
            avail[i * 9 + j] = YES;
        }
    }
    return self;
}

- (id)initWithShortArray:(short *)shortArray
{
    [self init];
    [self putInShortArray:shortArray];
    return self;
}

- (id)initWithString:(NSString *)stringRepresentation
{
    [self init];
    [self putInString:stringRepresentation];
    return self;
}

/*
 * The description function creates a string representation of the puzzle for
 * printing with NSLog.
 */
- (NSString *)description
{
    NSString *lineBreak = @"-------------------------\n";
    NSMutableString *stringBuilder = [[NSMutableString alloc] init];
    
    for (unsigned short y = 0; y < 9; ++y)
    {
        if (y % 3 == 0)
        {
            [stringBuilder appendString:lineBreak];
        }
        for (unsigned short x = 0; x < 9; ++x)
        {
            if (x % 3 == 0)
            {
                [stringBuilder appendString:@"| "];
            }
            [stringBuilder appendFormat:@"%d ", puzzle[9 * x + y]];
            if (x == 8)
            {
                [stringBuilder appendString:@"|\n"];
            }
        }
    }
    [stringBuilder appendString:lineBreak];
    
    return [NSString stringWithString:stringBuilder];
}


/* 
 * The putInValue function takes in a single int that contains both the location
 * and number needed to put in the puzzle, and changes the puzzle arrays to
 * match the new number input. It is called repeatedly during the initilization
 * of the puzzle.
 * The formula is as follows:
 *   1-d array location = loc = 9 * x + y
 *   valueAndLoc = 9 * loc + value
 */
- (void)putInValue:(int)valueAndLoc
{
    short value = valueAndLoc % 9 - 1;
    short loc = valueAndLoc / 9;
    if (value < 0)
    {
        value = 8;
        loc -= 1;
    }
    short block = (loc / 27) * 3 + (loc % 9) / 3;

    puzzle[loc] = value + 1;
    locAvail[loc] = 0;
    for (int i = 0; i < 9; i++)
    {
        if (avail[loc * 9 + i] == YES)
        {
            avail[loc * 9 + i] = NO;
            blockAvail[block * 9 + i] -= 1;
        }
    }
    blockNums[block * 9 + value] = YES;
    for (int i = 0; i < 9; i++)
    {
        short currentLoc = loc % 9 + i * 9;
        short currentBlock = (currentLoc / 27) * 3 + (currentLoc % 9) / 3;
        if (avail[currentLoc * 9 + value] == YES)
        {
            //NSLog(@"%d", currentLoc);
            avail[currentLoc * 9 + value] = NO;
            locAvail[currentLoc] -= 1;
            blockAvail[currentBlock * 9 + value] -= 1;
        }
        currentLoc = (loc / 9) * 9 + i;
        currentBlock = (currentLoc / 27) * 3 + (currentLoc % 9) / 3;
        if (avail[currentLoc * 9 + value] == YES)
        {
            //NSLog(@"%d", currentLoc);
            avail[currentLoc * 9 + value] = NO;
            locAvail[currentLoc] -= 1;
            blockAvail[currentBlock * 9 + value] -= 1;
        }
        currentLoc = (block / 3) * 27 + (block % 3) * 3 + (i / 3) * 9 + i % 3;
        currentBlock = (currentLoc / 27) * 3 + (currentLoc % 9) / 3;
        if (avail[currentLoc * 9 + value] == YES)
        {
            //NSLog(@"%d", currentLoc);
            avail[currentLoc * 9 + value] = NO;
            locAvail[currentLoc] -= 1;
            blockAvail[currentBlock * 9 + value] -= 1;
        }
    }
}

- (void)putInShortArray:(short *)shortArray
{
    for (int i = 0; i < 81; ++i)
    {
        if (shortArray[i] != 0)
        {
            [self putInValue:(i * 9 + shortArray[i])];
        }
    }
}

- (void)putInString:(NSString *)stringRepresentation
{
    const char *cString = [stringRepresentation UTF8String];
    short *shortArray = calloc(81, sizeof(short));
    for (int i = 0; i < 81; ++i)
    {
        char c = cString[i];
        shortArray[i] = (short)(c - '0');
    }
    [self putInShortArray:shortArray];
    free(shortArray);
}

/* Searches through the puzzle for a square with only 1 number that can go in
 * it. It then returns the method (1), submethod (1), square number, and
 * number to be input.
 */

- (short *)findSquareWithOneAvailableValue
{
    short *results = calloc(4, sizeof(short));
    for (short i = 0; i < 81; ++i)
    {
        if (locAvail[i] == 1)
        {
            for (short j = 0; j < 9; ++j)
            {
                if (avail[i * 9 + j])
                {
                    results[0] = 1;
                    results[1] = 1;
                    results[2] = i;
                    results[3] = j + 1;
                    return results;
                }

            }

        }
    }
    results[0] = 0;
    return results;
}

/* Looks for a block, column or row that has only one sqaure a number can
 * appear. It returns an array of 4 values: 2 (method used), [1,2,3]
 * (corresponding to block, column, row), location, and number to be put in.
 */
- (short *)findSquareInChunkWithRequiredValue
{
    short *results = calloc(4, sizeof(short));
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
                        results[0] = 2;
                        results[1] = 1;
                        results[2] = preCompute / 9;
                        results[3] = preCompute % 9 + 1;
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
                if (avail[k * 81 + j * 9 + i])
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
                results[0] = 2;
                results[1] = 2;
                results[2] = holder / 9;
                results[3] = holder % 9 + 1;
                return results;
            }
        }
    }
    for (short i = 0; i < 9; ++i)
    {
        short holder = 0;
        for (short k = 0; k < 9; ++k)
        {
            for (short j = 0; j < 9; ++j)
            {
                if (avail[k * 81 + j * 9 + i])
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
                results[0] = 2;
                results[1] = 3;
                results[2] = holder / 9;
                results[3] = holder % 9 + 1;
                return results;
            }
        }
    }
    return results;
}

@end
