/* Implementation of the GeneratorTests class.
 */ 

#import "GeneratorTests.h"
#import "../SudokuGenerator/SudokuBoard.h"
#import "../SudokuGenerator/SudokuBoardGenerator.h"

@implementation GeneratorTests

- (void)dealloc
{
    #if !(__has_feature(objc_arc))
    [testBoard release];
    [super dealloc];
    #endif
}

/* Method which runs all of the tests. If any fail, it returns a failure
 * constant. Otherwise, returns a success constant.
 */
- (int)runAllTests
{
    if (![self testInitialization])
    {
        return EXIT_FAILURE;
    }
    if (![self testCorrectness])
    {
        return EXIT_FAILURE;
    }
    
    NSLog(@"All methods successful.");
    return EXIT_SUCCESS;
}

/* Test allocation, initialization, and generation of the puzzle.
 */
- (BOOL)testInitialization
{
    NSLog(@"Testing generation initialization...");
    @try
    {
        testBoard = [SudokuBoardGenerator generate];
    }
    @catch (NSException *e)
    {
        NSLog(@"Failure:\n%@", e);
        return NO;
    }
    NSLog(@"Success.\n%@", testBoard);
    return TRUE;
}

/* Test correctness of the puzzle.
 * We may have this run multiple times in the future, just for certainty.
 */
- (BOOL)testCorrectness
{
    NSLog(@"Testing board for correctness...");
    if ([GeneratorTests isValidBoard:testBoard])
    {
        NSLog(@"Board correctness succeeds.");
        return YES;
    }
    else
    {
        NSLog(@"Board correctness fails.");
        return NO;
    }
}

void makeBoolArrayFalse (BOOL *array, NSUInteger size);
BOOL allBoolArrayValuesTrue(BOOL *array, NSUInteger size);

/* Checks if the rows, columns, and blocks of a SudokuBoard contain the numbers
 * 1 through 9.
 */
+ (BOOL)isValidBoard:(SudokuBoard *)aBoard
{
    short *testBoard = calloc(81, sizeof(short));
    testBoard = [aBoard boardAsShortArray:testBoard];
    BOOL *validityArray = calloc(9, sizeof(BOOL));
    BOOL boardIsValid = YES;
    
    // Test rows for all numbers 1 to 9
    NSLog(@"    Testing rows of board...");
    for (NSUInteger row = 0; row < 81; row += 9)
    {
        makeBoolArrayFalse(validityArray, 9);
        for (NSUInteger i = 0; i < 9; ++i)
        {
            validityArray[testBoard[row + i] - 1] = YES;
        }
        if (!allBoolArrayValuesTrue(validityArray, 9))
        {
            NSLog(@"    Rows failed.");
            boardIsValid = NO;
            break;
        }
    }
    NSLog(@"    Rows succeeded.");
    
    // Test columns
    NSLog(@"    Testing columns of board...");
    for (NSUInteger col = 0; col < 9; ++col)
    {
        makeBoolArrayFalse(validityArray, 9);
        for (NSUInteger i = 0; i < 81; i += 9)
        {
            validityArray[testBoard[i + col] - 1] = YES;
        }
        if (!allBoolArrayValuesTrue(validityArray, 9))
        {
            NSLog(@"    Columns failed.");
            boardIsValid = NO;
            break;
        }
    }
    NSLog(@"    Columns succeeded.");
    
    // Test blocks
    NSLog(@"    Testing blocks of board...");
    for (NSUInteger sec = 0; sec < 9; ++sec)
    {
        // Note: sectors are positioned as follows:
        // 0 1 2
        // 3 4 5
        // 6 7 8
        makeBoolArrayFalse(validityArray, 9);
        for (NSUInteger x = 0; x < 3; ++x) {
            for (NSUInteger y = 0; y < 3; ++y) {
                short xOffset = 3 * (sec % 3);
                short locX = xOffset + x;
                short yOffset = 0;
                if (sec >= 3 && sec < 6) yOffset = 3;
                if (sec >= 6 && sec < 9) yOffset = 6;
                short locY = yOffset + y;
                NSUInteger loc = 9 * locX + locY;
                validityArray[testBoard[loc] - 1] = YES;
            }
        }
        if (!allBoolArrayValuesTrue(validityArray, 9))
        {
            NSLog(@"    Blocks failed.");
            boardIsValid = NO;
            break;
        }
    }
    NSLog(@"    Blocks succeeded.");

    free(testBoard);
    free(validityArray);
    return boardIsValid;
}

/* Function to set all of the values of a boolean array to false.
 */
void makeBoolArrayFalse (BOOL *array, NSUInteger size)
{
    for (NSUInteger i = 0; i < size; ++i)
    {
        array[i] = NO;
    }
}

/* Function to check if all of the values of a boolean array are true.
 */
BOOL allBoolArrayValuesTrue(BOOL *array, NSUInteger size)
{
    for (NSUInteger i = 0; i < size; ++i)
    {
        if (array[i] == NO)
        {
            return NO;
        }
    }
    return YES;
}

@end
