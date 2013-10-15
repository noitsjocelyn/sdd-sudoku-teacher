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
		testPuzzle = [[Puzzle alloc] init];
		
		// Make the correct array
	    char *inputString = "000105000140000670080002400063070010900000003010090520007200080026000035000409000"; 
	    short *inputPuzzle = calloc(81, sizeof(short));
	    for (int i = 0; i < 81; ++i)
	    {
	        char c = inputString[i];
	        inputPuzzle[i] = (short)(c - '0');
	    }
		
		// Put all the values in
	    for (int i = 0; i < 81; ++i)
	    {
	        if (inputPuzzle[i] != 0)
	        {
	            [testPuzzle putInValue:(i * 9 + inputPuzzle[i])];
	        }
	    }
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
