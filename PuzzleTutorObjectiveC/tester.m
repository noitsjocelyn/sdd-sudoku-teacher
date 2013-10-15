/* A quick main to run all of the methods of the Puzzle class. Does not check
 * for correctness, just makes sure everything compiles and nothing segfaults.
 */

#import <Foundation/Foundation.h>
#import "Puzzle.h"

int main ()
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    Puzzle *aPuzzle = [[Puzzle alloc] init];
    NSLog(@"Puzzle allocation successful.");
	
    char *inputString = "000105000140000670080002400063070010900000003010090520007200080026000035000409000"; 
    short *inputPuzzle = calloc(81, sizeof(short));
    for (int i = 0; i < 81; ++i)
    {
        char c = inputString[i];
        inputPuzzle[i] = (short)(c - '0');
    }
	
    NSLog(@"Attempting initialization.");
    for (int i = 0; i < 81; ++i)
    {
        if (inputPuzzle[i] != 0)
        {
            [aPuzzle putInValue:(i * 9 + inputPuzzle[i])];
        }
    }
    NSLog(@"Initialization successful.");
	
    short *results = [aPuzzle findSquareWithOneAvailableValue];
    if (results[0] == 1 && results[1] == 1 && results[2] == 7 && results[3] == 9)
    {
        NSLog(@"First tutor successful.");
        results = [aPuzzle findSquareInChunkWithRequiredValue];
        if (results[0] == 2 && results[1] == 1 && results[2] == 4 && results[3] == 4)
        {
            NSLog(@"Second tutor successful.");
        }
        else
        {
            NSLog(@"ERROR WITH SECOND TUTOR.");
            return -1;
        }
    }
    else
    {
        NSLog(@"ERROR WITH FIRST TUTOR.");
        return -1;
    }
    
	NSLog(@"No methods failed.");
	[pool release];
    return 0;
}
