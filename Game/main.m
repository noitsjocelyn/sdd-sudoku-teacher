#import <Foundation/Foundation.h>
#import "Game.h"
#import "Player.h"

int main (int argc,  const char *argv[])
{	
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	Game *aBoard = [Game new];
	NSInteger fullBoard[81] = {7, 9, 6, 8, 5, 4, 3, 2, 1, 2, 4, 3, 1, 7, 6, 9, 8, 5, 8, 5, 1, 2, 3, 9, 4, 7, 6, 1, 3, 7, 9, 6, 5, 8, 4, 2, 9, 2, 5, 4, 1, 8, 7, 6, 3, 4, 6, 8, 7, 2, 3, 5, 1, 9, 6, 1, 4, 5, 9, 7, 2, 3, 8, 5, 8, 2, 3, 4, 1, 6, 9, 7, 3, 7, 9, 6, 8, 2, 1, 5, 4};	
	NSInteger startBoard[81] = {7, 9, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 6, 9, 0, 0, 8, 0, 0, 0, 3, 0, 0, 7, 6, 0, 0, 0, 0, 0, 5, 0, 0, 2, 0, 0, 5, 4, 1, 8, 7, 0, 0, 4, 0, 0, 7, 0, 0, 0, 0, 0, 6, 1, 0, 0, 9, 0, 0, 0, 8, 0, 0, 2, 3, 0, 0, 0, 0, 0, 0, 0, 9, 0, 0, 0, 0, 5, 4};
    
	for(NSInteger ix = 0; ix < 81; ++ix)
	{	
		[aBoard->fullGrid addObject:[NSNumber numberWithInteger:fullBoard[ix]]];
		[aBoard->startGrid addObject:[NSNumber numberWithInteger:startBoard[ix]]];
		[aBoard->puzzle addObject:[NSNumber numberWithInteger:startBoard[ix]]];
	}
	
	Player *aPlayer = [Player new];
	
	while(1)
	{
		[aPlayer getPlayerInput:aBoard];
	}
	
	[pool drain];
    return 0;
}
