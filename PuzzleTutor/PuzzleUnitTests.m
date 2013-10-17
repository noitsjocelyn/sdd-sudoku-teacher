/* Implementation of the PuzzleUnitTests class.
 */ 

#import "PuzzleUnitTests.h"
#import "Puzzle.h"

@implementation PuzzleUnitTests

- (id)init
{
    testPuzzle = nil;
    return self;
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
    if (![self testFindSquareWithOneAvailableValue])
    {
        return EXIT_FAILURE;
    }
    if (![self testFindSquareInChunkWithRequiredValue])
    {
        return EXIT_FAILURE;
    }
    
    NSLog(@"All methods successful.");
    return EXIT_SUCCESS;
}

/* Test allocation and initialization procedure for the Puzzle.
 */
- (BOOL)testInitialization
{
    NSLog(@"Testing Puzzle initialization...");
    @try {
        // Allocation
        NSString *inputString = @"000105000140000670080002400063070010900000003010090520007200080026000035000409000"; 
        testPuzzle = [[Puzzle alloc] initWithString:inputString];
    }
    @catch (NSException *e)
    {
        NSLog(@"Failure:\n%@", e);
        return NO;
    }
    NSLog(@"Success.");
    return YES;
}

/* Tests the first tutor method.
 */
- (BOOL)testFindSquareWithOneAvailableValue
{
    NSLog(@"Testing findSquareWithOneAvailableValue...");
    short *results = [testPuzzle findSquareWithOneAvailableValue];
    if (results[0] == 1 && results[1] == 1 && results[2] == 7 && results[3] == 9)
    {
        NSLog(@"Success.");
        return YES;
    }
    else
    {
        NSLog(@"Failure.");
        return NO;
    }
}

/* Tests the second tutor method.
 */
- (BOOL)testFindSquareInChunkWithRequiredValue
{
    NSLog(@"Testing findSquareInChunkWithRequiredValue...");
    short *results = [testPuzzle findSquareInChunkWithRequiredValue];
    if (results[0] == 2 && results[1] == 1 && results[2] == 4 && results[3] == 4)
    {
        NSLog(@"Success.");
        return YES;
    }
    else
    {
        NSLog(@"Failure.");
        return NO;
    }
}

@end
