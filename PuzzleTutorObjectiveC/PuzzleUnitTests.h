/* The Puzzle unit test class.
 * Members:
 *   testPuzzle:
 *     A Puzzle object to run tests on.
 * Methods:
 *   The methods are described in the impelmentation, PuzzleUnitTests.m.
 */

#import <Foundation/Foundation.h>

@class Puzzle;
 
@interface PuzzleUnitTests : NSObject 
{
    Puzzle *testPuzzle;
}

- (int)runAllTests;
- (BOOL)testInitialization;
- (BOOL)testFindSquareWithOneAvailableValue;
- (BOOL)testFindSquareInChunkWithRequiredValue;

@end
