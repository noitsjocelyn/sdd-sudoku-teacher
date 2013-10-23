/* Implementation of the PuzzleMakerUnitTests class.
 */ 

#import "PuzzleMakerUnitTests.h"
#import "PuzzleMaker.h"
#import "Puzzle.h"

@implementation PuzzleMakerUnitTests

- (id)init
{
    testPuzzleMaker = nil;
    return self;
}

- (void)dealloc
{
    #if !(__has_feature(objc_arc))
    [testPuzzleMaker release];
    [super dealloc];
    #endif
}

/* Method which runs all of the tests. If any fail, it returns a failure
 * constant. Otherwise, returns a success constant.
 */
- (int)runAllTests
{
    if (![self testGivePuzzle])
    {
        return EXIT_FAILURE;
    }
    if (![self testBuildEasyPuzzle])
    {
        return EXIT_FAILURE;
    }
    if (![self testBuildMediumPuzzle])
    {
        return EXIT_FAILURE;
    }
    
    NSLog(@"All methods successful.");
    return EXIT_SUCCESS;
}

/* Tests the givePuzzle method.
 */
- (BOOL)testGivePuzzle
{
    NSLog(@"Testing givePuzzle...");
    NSString *inputString = nil;
    BOOL didTestPass = YES;
    @try {
        // Allocation
        inputString = @"672145398145983672389762451263574819958621743714398526597236184426817935831459267"; 
        testPuzzle = [[PuzzleMaker alloc] init];
        [testPuzzle givePuzzle:inputString]
    }
    @catch (NSException *e)
    {
        NSLog(@"Failure:\n%@", e);
        didTestPass = NO;
    }
    @finally
    {
        #if !(__has_feature(objc_arc))
        [inputString release];
        #endif
    }
    NSLog(@"Success.");
    return didTestPass;
}

/* Tests the buildEasyPuzzle method. It does this by creating an easy puzzle, and feeding the workingPuzzle member
 * to a new Puzzle object for initilization. From there, the easy tutor algorithm is run, and the test is successful
 * as long as the tutor algorithm doesn't fail. A more strict test may be written later.
 */
- (BOOL)testBuildEasyPuzzle
{
    NSLog(@"Testing buildEasyPuzzle...");
    [testPuzzleMaker buildEasyPuzzle];
	testHelper = [[Puzzle alloc] initWithShortArray:[testPuzzleMaker workingPuzzle]];
    short *results = [testHelper findSquareWithOneAvailableValue];
    BOOL didTestPass = YES;
    if (results[0] != 0)
    {
        NSLog(@"Success.");
    }
    else
    {
        NSLog(@"Failure.");
        didTestPass = NO;
    }
    free(results);
    free(testHelper);
    return didTestPass;
}

/* Tests the buildMediumPuzzle method. It does this by creating an medium puzzle, and feeding the workingPuzzle member
 * to a new Puzzle object for initilization. From there, the medium tutor algorithm is run. If this algorithm isn't successful,
 * the easy tutor algorithm is run. The test is successful if at least one of the tutor algorithms was successful. 
 * A more strict test may be written in the future.
 */
- (BOOL)testBuildMediumPuzzle
{
    NSLog(@"Testing buildMediumPuzzle...");
    [testPuzzleMaker buildEasyPuzzle];
	testHelper = [[Puzzle alloc] initWithShortArray:[testPuzzleMaker workingPuzzle]];
    short *results = [testHelper findSquareInChunkWithRequiredValue];
    if (results[0] == 0)
    {
    	results = [testHelper findSquareWithOneAvailableValue];
    }
    BOOL didTestPass = YES;
    if (results[0] != 0)
    {
        NSLog(@"Success.");
    }
    else
    {
        NSLog(@"Failure.");
        didTestPass = NO;
    }
    free(results);
    free(testHelper);
    return didTestPass;
}