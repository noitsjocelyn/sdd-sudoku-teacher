/* A quick main to run all of the methods of the Puzzle class. Does not check
 * for correctness, just makes sure everything compiles and nothing segfaults.
 */

#import <Foundation/Foundation.h>
#import "Puzzle.h"

int main ()
{
    NSLog(@"Testing all methods...");
    
    Puzzle *aPuzzle = [[Puzzle alloc] init];
    NSLog(@"Puzzle allocation successful");
    short *inputPuzzle = calloc(81, sizeof(short));
    short *inputPuzzle2 = calloc(81, sizeof(short));
    char *inputString = calloc(81, sizeof(char));
    char *inputString2 = calloc(81, sizeof(char));
    //inputString2 = "000105000140000670080002400063070010900000003010090520007200080026000035000409000"; //easy test for tutor 1
    inputString2 = "000004028406000005100030600000301000087000140000709000002010003900000507670400000";
    inputString = "000000000000000000000000000000000000000000000000000000000000000000000000000000000";
    NSLog(@"what is going on in here?");
    for (int i = 0; i < 81; i++)
    {
    	char c = inputString[i];
        char d = inputString2[i];
    	inputPuzzle[i] = (short)(c - '0');
        inputPuzzle2[i] = (short)(d - '0');
    }
    NSLog(@"Attempting initilization");
    for (int i = 0; i < 81; i++)
    {
        if (inputPuzzle2[i] != 0)
        {
            [aPuzzle putInValue:(i * 9 + inputPuzzle2[i])];
        }
    }
    //[aPuzzle putInValue:379];
    NSLog(@"Initilization successful");
    NSLog(@"First tutor successful");
    [aPuzzle findSquareInChunkWithRequiredValue];
    NSLog(@"Second tutor successful");
    //[aPuzzle putInValue:72];
    short *results = [aPuzzle findSquareWithOneAvailableValue];
    if (results[0] == 0)
    {
        results = [aPuzzle findSquareInChunkWithRequiredValue];
    }

    NSLog(@"%d %d %d %d\n", results[0], results[1], results[2], results[3]);

    short *results2 = [aPuzzle getAvail:26];

    NSLog(@"%d %d %d %d %d %d %d %d %d\n", results2[0], results2[1], results2[2], results2[3], results2[4], results2[5], results2[6], results2[7], results2[8]);

    NSLog(@"%d %d\n", [aPuzzle getLocAvail:18], [aPuzzle getLocAvail:16]);
    
    NSLog(@"\n%@", [aPuzzle toString]);
    
    NSLog(@"No methods failed.");
    return 0;
}
