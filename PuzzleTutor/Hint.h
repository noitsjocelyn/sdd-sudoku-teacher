/* The Hint class.
 * Members:
 *   theHint:
 *     The string containing the text of the hint.
 *   highlightOne:
 *		An array containing the squares that should be highlighted blue (color may change).
 *	 highlightTwo:
 *		A short that contains the location to be highlighted green, if any.
 * Methods:
 *   The methods are described in the impelmentation, Hint.m.
 */

#import <Foundation/Foundation.h>
#import "Puzzle.h"
 
@interface Hint : NSObject 
{
    NSString theHint;
    NSMutableArray highlightOne;
    short highlightTwo;
}

- (id) init;

- (NSMutableArray *)createHints:(Puzzle *)thePuzzle;
- (NSMutableArray *)makeHints:(short *)hintResult;
- (Hint *)makeHintOne:(short *)hintResult;
- (Hint *)makeHintTwo:(short *)hintResult;
- (Hint *)makeHintThree:(short *)hintResult;
