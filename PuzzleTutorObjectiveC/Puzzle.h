/*
 *The puzzle class. It contains 5 member variables, and 3 member functions.
 *The variables are:
 *		-puzzle. Puzzle is an array of 81 numbers that represent the puzzle
 *		-avail. Avail is an array of 729 bools that represent the numbers available to be put in any square. Example: Square 13's available numbers are
 *			contained in spaces 13*9 = 107, which corresponds to 1, and 13*9 + 8 = 115, which corresponds to 9.
 *		-locAvail. An array of 81 integers which holds the count of available numbers to go in a square.
 *		-blockNums. An array of 81 bools that represent the existance of a particular number in a particular 3x3 block. Example: Block 2 has a 1 in it
 *			iff blockNums[9] = YES, a 2 in it iff blockNums[10] = YES, a 3 in it iff blockNums[11] = Yes, etc.
 *		-blockAvail. Counts the number of times a number is available in a block. Example: If '3' can be put in 4 squares of block 2, blockAvail[11] = 3.
 *The member functions are described in 'Puzzle.m'.
 */ 
@interface Puzzle : NSObject 
{
	int *puzzle[81];
	BOOL *avail[729];
	int *locAvail[81];
	BOOL *blockNums[81];
	int *blockAvail[81];
}

- int* onlyAvail;
- int* oneLoc;
- (void) setPuzzle: int input[81];

@end