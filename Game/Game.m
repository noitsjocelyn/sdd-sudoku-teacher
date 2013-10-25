#import "Game.h"

@implementation Game

@synthesize puzzle, fullGrid, startGrid;

- (id)init
{
	puzzle = [NSMutableArray arrayWithCapacity:81];
	fullGrid = [NSMutableArray arrayWithCapacity:81];
	startGrid = [NSMutableArray arrayWithCapacity:81]; 
	return self;
}

/* Method to check puzzle correctness against solution grid.  
 * If incorrect entries are encountered, they are reset to 0.
 */
- (BOOL)checkPuzzle
{
	BOOL z = YES;
	for (int i = 0; i < 81; ++i)
	{
		int puzzleSquareValue = [[puzzle objectAtIndex:i] integerValue];
		int fullGridSquareValue = [[fullGrid objectAtIndex:i] integerValue];
		if (puzzleSquareValue != 0 )
		{
			if (puzzleSquareValue != fullGridSquareValue)
			{
				z = NO;
				[puzzle replaceObjectAtIndex:i withObject:[startGrid objectAtIndex:i]];
			}	
		}
	}
	return z;
}

/* Method to set values in the puzzle according to x-location, and y-value.
 * Prevents overwriting of initial grid values.
 */
- (void)setValueX:(int)x y:(int)y  
{
	NSInteger inputs[2] = {x, y};
	NSMutableArray *toReplace = [NSMutableArray arrayWithCapacity:2];
	[toReplace addObject:[NSNumber numberWithInteger:inputs[0]]];
	[toReplace addObject:[NSNumber numberWithInteger:inputs[1]]];
	
	int puzzleSquareValue = [[startGrid objectAtIndex:inputs[0]] integerValue];
	if (puzzleSquareValue == 0)
	{
		[puzzle replaceObjectAtIndex:inputs[0] withObject:[toReplace objectAtIndex:1]];
	} 
	else 
	{
		NSLog(@"ERROR: Square value set in initial Puzzle.");
	}
}


- (void)displayPuzzle
{
	for (int i = 0; i < 9; ++i)
	{
		NSLog(@"%@ %@ %@ %@ %@ %@ %@ %@ %@", [puzzle objectAtIndex:(0 + (9 * i))], [puzzle objectAtIndex:(1 + (9 * i))], [puzzle objectAtIndex:(2 + (9 * i))], [puzzle objectAtIndex:(3 + (9 * i))], [puzzle objectAtIndex:(4 + (9 * i))], [puzzle objectAtIndex:(5 + (9 * i))], [puzzle objectAtIndex:(6 + (9 * i))], [puzzle objectAtIndex:(7 + (9 * i))], [puzzle objectAtIndex:(8 + (9 * i))]);

	}
}

@end
