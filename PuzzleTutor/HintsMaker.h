/* The HintsMaker class.
 * Members:
 *   None.
 * Methods:
 *   The methods are described in the impelmentation, Hint.m.
 */

#import <Foundation/Foundation.h>

@class Puzzle;
 
@interface HintsMaker : NSObject

- (NSArray *)createHints:(Puzzle *)thePuzzle;

@end
