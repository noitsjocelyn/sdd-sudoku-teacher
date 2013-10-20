/* A main function to run all of the Puzzle unit tests.
 */

#import <Foundation/Foundation.h>
#import "Puzzle.h"
#import "PuzzleUnitTests.h"

int main (int argc, char *argv[])
{   
    PuzzleUnitTests *unitTests = [[PuzzleUnitTests alloc] init];
    int returnValue = [unitTests runAllTests];
    
    #if !(__has_feature(objc_arc))
    [unitTests release];
    #endif
    
    return returnValue;
}
