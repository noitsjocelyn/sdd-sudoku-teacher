/* Implementation of the Puzzle class.
 */ 

#import "Puzzle.h"

@implementation Puzzle

- (id)init
{
    self = [super init];
    for (short i = 0; i < 81; ++i)
    {
        [self resetSquareAtIndex:i];
    }
    return self;
}

- (BOOL)checkIfSquareIsFilled:(short)loc
{
    if (puzzle[loc] != 0)
        return YES;
    return NO;
}

/* Method to initialize the Puzzle with a C-style array of 81 shorts.
 */
- (id)initWithShortArray:(short *)shortArray
{
    self = [self init];
    [self putInShortArray:shortArray];
    return self;
}

/* Method to initialize the Puzzle with an NSString of length 81.
 */
- (id)initWithString:(NSString *)stringRepresentation
{
    self = [self init];
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
    NSString *returnString = [NSString stringWithString:stringBuilder];
    
    #if !(__has_feature(objc_arc))
    [lineBreak release];
    [stringBuilder release];
    #endif
    
    return returnString;
}

- (short)getPuzzleValueAtIndex:(short)index
{
    return puzzle[index];
}

- (BOOL)isOriginalValueAtIndex:(short)index
{
    return isOriginalValue[index];
}

- (void)resetSquareAtIndex:(short)index
{
    puzzle[index] = 0;
    locAvail[index] = 9;
    blockNums[index] = NO;
    blockAvail[index] = 9;
    for (short j = 0; j < 9; ++j)
    {
        avail[index * 9 + j] = YES;
    }
}

/* The putInValue function takes in a single int that contains both the location
 * and number needed to put in the puzzle, and changes the puzzle arrays to
 * match the new number input. It is called repeatedly during the initilization
 * of the puzzle.
 * The formula is as follows:
 *   1dArrayLoc = 9 * x + y
 *   valueAndLoc = 9 * 1dArrayLoc + value
 */
- (void)putInValue:(int)valueAndLoc
{
    // The following location calculation works unless value == 9. In that case,
    // the loc is one greater than it should be.
    short loc = valueAndLoc / 9;
    // Therefore, we subtract one from value. If value == 9, the modulus will
    // give us 0, and subtracting gives us -1.
    short value = valueAndLoc % 9 - 1;
    // If we're -1 here, we know that our location needs to be decremented.
    // Additionally, set value to 8, so when we add 1 later, it becomes 9.
    if (value == -1)
    {
        value = 8;
        --loc;
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

/* Method to put a C-style array of 81 shorts into the Puzzle. This assumes that
 * non-zero values are original values.
 */
- (void)putInShortArray:(short *)shortArray
{
    for (int i = 0; i < 81; ++i)
    {
        if (shortArray[i] != 0)
        {
            [self putInValue:(i * 9 + shortArray[i])];
            isOriginalValue[i] = YES;
        }
        else
        {
            isOriginalValue[i] = NO;
        }
    }
}

/* Method to put a C-style array of 81 shorts into the Puzzle and mark the
 * original values.
 */
- (void)putInShortArray:(short *)shortArray withOriginals:(BOOL *)boolArray
{
    [self putInShortArray:shortArray];
    // Overwrite the isOriginalValue array
    for (int i = 0; i < 81; ++i)
    {
        isOriginalValue[i] = boolArray[i];
    }
}

/* Method to put an NSString of length 81 into the Puzzle. Since it uses
 * putInShortArray: it assumes that non-zero values are original values.
 */
- (void)putInString:(NSString *)stringRepresentation
{
    // Fail if our string isn't 81 characters.
    if ([stringRepresentation length] < 81)
    {
        [NSException raise:@"Invalid string length" format:@"String must be of at least length 81. %ld is invalid.", (unsigned long)[stringRepresentation length]];
        return;
    }
    const char *cString = [stringRepresentation UTF8String];
    short *shortArray = calloc(81, sizeof(short));
    for (int i = 0; i < 81; ++i)
    {
        // Subtracting the char '0' and casting to a short will give the
        // numeric value from the char.
        short numValue = (short)(cString[i] - '0');
        // Fail if it's outside of 0-9.
        if (numValue < 0 || numValue > 9)
        {
            [NSException raise:@"Invalid string representation" format:@"String must only contain characters '0' through '9'. '%c' is invalid.", cString[i]];
            free(shortArray);
            return;
        }
        shortArray[i] = numValue;
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
