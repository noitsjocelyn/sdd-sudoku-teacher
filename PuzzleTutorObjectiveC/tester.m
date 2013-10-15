/* A main function to run all of the Puzzle unit tests.
 */

#import <Foundation/Foundation.h>
#import "Puzzle.h"
#import "PuzzleUnitTests.h"

int main (int argc, char *argv[])
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    PuzzleUnitTests *unitTests = [[PuzzleUnitTests alloc] init];
	int returnValue = [unitTests runAllTests];
	
	[pool release];
    return returnValue;
}
