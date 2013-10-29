/* The Puzzle class.
 * Members:
 *   puzzle:
 *     An array of 81 numbers that represent the puzzle.
 *   avail:
 *     An array of 729 bools that represent the numbers available to be put in
 *     any square. Example: Square 13's available numbers are contained between
 *     spaces 13 * 9 = 107, which corresponds to 1, and 13 * 9 + 8 = 115, which
 *     corresponds to 9.
 *   locAvail:
 *     An array of 81 numbers which holds the count of available numbers to go
 *     in a square.
 *   blockNums:
 *     An array of 81 bools that represent the existance of a particular number
 *     in a particular 3x3 block. Example: Block 2 has a 1 in it iff
 *     blockNums[9] == YES, a 2 in it iff blockNums[10] == YES, a 3 in it iff
 *     blockNums[11] == YES, etc.
 *   blockAvail:
 *     Counts the number of times a number is available in a block. Example: If
 *     '3' can be put in 4 squares of block 2, blockAvail[11] = 3.
 *   originalVal:
 * Methods:
 *   The methods are described in the impelmentation, Puzzle.m.
 */

#import <Foundation/Foundation.h>
 
@interface Puzzle : NSObject 
{
    short puzzle[81];
    short locAvail[81];
    short blockAvail[81];
    BOOL avail[729];
    BOOL blockNums[81];
    BOOL isOriginalValue[81];
}

- (id)init;
- (id)initWithShortArray:(short *)shortArray;
- (id)initWithString:(NSString *)stringRepresentation;

- (short)getPuzzleValueAtIndex:(short)index;
- (BOOL)isOriginalValueAtIndex:(short)index;
- (void)resetSquareAtIndex:(short)index;
- (short *)findSquareWithOneAvailableValue;
- (short *)findSquareInChunkWithRequiredValue;
- (BOOL)checkIfSquareIsFilled:(short)loc;
- (void)putInValue:(int)valueAndLoc;
- (void)putInShortArray:(short *)shortArray;
- (void)putInShortArray:(short *)shortArray withOriginals:(BOOL *)boolArray;
- (void)putInString:(NSString *)stringRepresentation;

@end
