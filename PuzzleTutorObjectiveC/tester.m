/* A quick main to run all of the methods of the Puzzle class. Does not check
 * for correctness, just makes sure everything compiles and nothing segfaults.
 */

#import <Foundation/Foundation.h>
#import "Puzzle.h"

int main ()
{
    NSLog(@"Testing all methods...");
    
    Puzzle *aPuzzle = [[Puzzle alloc] init];
    short *startPuzzle = calloc(81, sizeof(short));
    [aPuzzle setPuzzle:startPuzzle];
<<<<<<< HEAD
    [aPuzzle onlyAvail];
    [aPuzzle oneLoc];
=======
    [aPuzzle findSquareWithOneAvailableValue];
    [aPuzzle findSquareInChunkWithRequiredValue];
    
>>>>>>> 861fe4b7c16ac3f214c9ce7b1bbc9c0e626547f7
    NSLog(@"\n%@", [aPuzzle toString]);
    
    NSLog(@"No methods failed.");
    return 0;
}
