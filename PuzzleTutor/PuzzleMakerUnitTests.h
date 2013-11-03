/* The PuzzleMaker unit test class.
 * Members:
 *   testPuzzleMaker:
 *     A PuzzleMaker object to run tests on.
 *   testHelper:
 *     A Puzzle object to allow the use of tutor algorithms while testing the buildPuzzle methods.
 * Methods:
 *   The methods are described in the impelmentation, PuzzleMakerUnitTests.m.
 */

#import <Foundation/Foundation.h>

@class Puzzle;
@class PuzzleMaker;
 
@interface PuzzleMakerUnitTests : NSObject 
{
    PuzzleMaker *testPuzzleMaker;
    Puzzle *testHelper;
    short *puzzleArray;
}

- (int)runAllTests;
- (BOOL)testGivePuzzle;
- (BOOL)testBuildEasyPuzzle;
- (BOOL)testBuildMediumPuzzle;

@end
