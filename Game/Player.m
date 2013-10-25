#import "Player.h"
#import "Game.h"

@implementation Player

/* Method to take in input from command line.
 * Execute input commands to display the puzzle, set a value in the puzzle,
 * check the puzzle for correctness, or exit the program.
 */
- (void)getPlayerInput:(Game *)Board
{
	char str[10];
	printf("Enter command (Display, Set, Check, Exit): ");
	scanf("%s",str);
	NSString* playerInput = [NSString stringWithUTF8String:str];

	if ([playerInput isEqualToString:@"Exit"] == 1)
	{
		exit(0);
	}
	
	else if ([playerInput isEqualToString:@"Set"] == 1)
	{
		printf("Enter Location and Value: ");
		int x, y;
		scanf("%d %d", &x, &y);
		[Board setValueX:x y:y];
	}
	
	else if ([playerInput isEqualToString:@"Check"])
	{
		if([Board checkPuzzle] == NO)
		{
			NSLog(@"Incorrect puzzle: Incorrect values have been removed.");
		}
		else if([Board checkPuzzle] == YES)
		{
			NSLog(@"Correct puzzle!");
		}
	}
	
	else if([playerInput isEqualToString:@"Display"])
	{
		[Board  displayPuzzle];
	}	
}

@end


