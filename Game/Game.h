/* The Game Class.
 * Members:
 *    puzzle:
 *        An array of 81 numbers that represents the current puzzle.
 *    fullGrid:
 *        An array of 81 numbers that represents the solution grid.
 *    startGrid:
 *        An array of 81 numbers that represents the initial start grid.
 * Methods:
 *    See Player.m
 */

#import <Foundation/Foundation.h>

@interface Game : NSObject
{
}

@property (assign) NSMutableArray *puzzle;
@property (assign) NSMutableArray *fullGrid;
@property (assign) NSMutableArray *startGrid;

- (id)init;
- (BOOL)checkPuzzle;
- (void)setValueX:(int)x y:(int)y;
- (void)displayPuzzle;

@end
