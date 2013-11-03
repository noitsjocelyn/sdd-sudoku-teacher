#import <Foundation/Foundation.h>

@class Puzzle;

@interface PuzzleMaker : NSObject
{
	Puzzle *basePuzzle;
	short givenPuzzle[81];
	short workingPuzzle[81];
}

- (void)givePuzzle:(short *)thePuzzle;
- (short *)getWorkingPuzzle:(short *)outputArray;
- (void)buildEasyPuzzle;
- (void)buildMediumPuzzle;

@end
