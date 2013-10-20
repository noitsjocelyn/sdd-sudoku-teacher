/* The PuzzleGenerator unit test class.
 * Members:
 *   testBoard:
 *     A SudokuBoard object to run tests on.
 * Methods:
 *   The methods are described in the impelmentation, GeneratorTests.m.
 */

#import <Foundation/Foundation.h>

@class SudokuBoard;

@interface GeneratorTests : NSObject 
{
    SudokuBoard *testBoard;
}

- (int)runAllTests;
- (BOOL)testInitialization;
- (BOOL)testCorrectness;
+ (BOOL)isValidBoard:(SudokuBoard *)aBoard;

@end
