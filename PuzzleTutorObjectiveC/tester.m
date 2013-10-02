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
    [aPuzzle findSquareWithOneAvailableValue];
    [aPuzzle findSquareInChunkWithRequiredValue];
    
    NSLog(@"\n%@", [aPuzzle toString]);
    
    NSLog(@"No methods failed.");
    return 0;
}
