#import <Foundation/Foundation.h>

@class Puzzle;

@interface PuzzleMaker : NSObject
{
	Puzzle basePuzzle;
	short givenPuzzle[81];
	short workingPuzzle[81];
}

- (short *)buildEasyPuzzle;
- (short *)buildMediumPuzzle;
- (void)givePuzzle:(short *)thePuzzle;
