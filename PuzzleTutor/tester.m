/* A main function to run all of the Puzzle unit tests.
 */

#import <Foundation/Foundation.h>
#import "Puzzle.h"
#import "PuzzleUnitTests.h"
#import "PuzzleMakerUnitTests.h"

int main (int argc, char *argv[])
{   
    PuzzleUnitTests *puzzleUnitTests = [[PuzzleUnitTests alloc] init];
    int returnValue = [puzzleUnitTests runAllTests];
    
    PuzzleMakerUnitTests *makerUnitTests = [[PuzzleMakerUnitTests alloc] init];
    returnValue = returnValue & [makerUnitTests runAllTests];
    
    #if !(__has_feature(objc_arc))
    [puzzleUnitTests release];
    [makerUnitTests release];
    #endif
    
    return returnValue;
}
