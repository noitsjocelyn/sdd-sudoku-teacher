/* A main function to run all of the Puzzle unit tests.
 */

#import <Foundation/Foundation.h>
#import "Puzzle.h"
#import "PuzzleFactoryTests.h"
#import "PuzzleMakerFactory.h"
#import "../SudokuGenerator/SudokuBoard.h"

int main (int argc, char *argv[])
{   
    PuzzleFactoryTests *test = [[PuzzleFactoryTests alloc] init];
    [test run];
    
    return 0;
}
