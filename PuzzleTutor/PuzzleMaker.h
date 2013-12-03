#import <Foundation/Foundation.h>

@interface PuzzleMaker : NSObject
{
    short givenPuzzle[81];
    short workingPuzzle[81];
}

- (void)givePuzzle:(short *)thePuzzle;
- (void)buildEasyPuzzle;
- (void)buildMediumPuzzle;
- (short *)getWorkingPuzzle:(short *)outputArray;

@end
