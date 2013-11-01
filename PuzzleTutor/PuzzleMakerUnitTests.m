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
    short *inputPuz = calloc(81, sizeof(short));
    const char *cString = "672145398145983672389762451263574819958621743714398526597236184426817935831459267";
    BOOL didTestPass = YES;
    @try {
        for (short i = 0; i < 81; i++)
        {
            short numValue = (short)(cString[i] - '0');
            inputPuz[i] = numValue;
        }
        testPuzzleMaker = [[PuzzleMaker alloc] init];
        [testPuzzleMaker givePuzzle:inputPuz];
    }
    @catch (NSException *e)
    {
        NSLog(@"Failure:\n%@", e);
        didTestPass = NO;
    }
    @finally
    {
        free(inputPuz);
    }
    NSLog(@"Success.");
    return didTestPass;
}

/* Tests the buildEasyPuzzle method. It does this by creating an easy puzzle,
 * and feeding the workingPuzzle member to a new Puzzle object for
 * initilization. From there, the easy tutor algorithm is run, and the test is
 * successful as long as the tutor algorithm doesn't fail. A more strict test
 * may be written later.
 */
- (BOOL)testBuildEasyPuzzle
{
    NSLog(@"Testing buildEasyPuzzle...");
    short *aPuzzle = calloc(81, sizeof(short));
    aPuzzle = [testPuzzleMaker buildEasyPuzzle:aPuzzle];
    NSLog(@"   Puzzle built.");
	testHelper = [[Puzzle alloc] initWithShortArray:aPuzzle];
    free(aPuzzle);
    NSLog(@"   Checking findSquare method on it...");
    short *results = calloc(4, sizeof(short));
    results = [testHelper findSquareWithOneAvailableValue:results];
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
    short *aPuzzle = calloc(81, sizeof(short));
    aPuzzle = [testPuzzleMaker buildMediumPuzzle:aPuzzle];
    NSLog(@"   Puzzle built.");
	testHelper = [[Puzzle alloc] initWithShortArray:aPuzzle];
    free(aPuzzle);
    NSLog(@"   Checking findSquare methods on it...");
    short *results = calloc(4, sizeof(short));
    results = [testHelper findSquareInChunkWithRequiredValue:results];
    if (results[0] == 0)
    {
    	results = [testHelper findSquareWithOneAvailableValue:results];
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
    return didTestPass;
}

@end
