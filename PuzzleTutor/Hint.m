/* Implementation of the Hint class
 */

#import "Hint.h"
#import "Puzzle.h"

@implementation Hint

- (id)init
{

}

- (NSMutableArray *)createHints:(Puzzle *)thePuzzle
{
    short theResults[4];
    [thePuzzle findSquareWithOneAvailableValue:theResults];
    if (theResults[0] == 0)
    {
        [thePuzzle findSquareInChunkWithRequiredValue:theResults];
    }
    return [self makeHints:theResults];
}

/* Method that returns an array of three hints when passed the results of a tutor search.
 */
- (NSMutableArray *)makeHints:(short *)hintResults
{
	NSMutableArray *theHints = [[NSMutableArray alloc] init];
	[theHints addObject: [self makeHintOne:hintResults]];
	[theHints addObject: [self makeHintTwo:hintResults]];
	[theHints addObject: [self makeHintThree:hintResults]];
	return theHints;
}

/* Method that returns the first hint when passed the results of a tutor search.
 * This hint is only ever a text explaination of the method used by the tutor.
 */
- (Hint *)makeHintOne:(short *)hintResults
{
	Hint *newHint = [[Hint alloc] init];
	if (hintResults[0] == 1)
	{
		theHint = @"Remember, a row, column, or block can only have one occurrence of a number. \
					You can use this fact to eliminate possibilities from other squares. \
					Once there is only one possibility remaining for a square, you know the number that has to go there!";
	}
	if (hintResults[0] == 2)
	{
    	NSMutableString *stringBuilder = [[NSMutableString alloc] init];
    	NSString *theMethod = [[NSString alloc] init];
    	if (hintResults[1] == 1)
    	{
    		theMethod = @"block";
    	}
    	else if (hintResults[1] == 2)
    	{
    		theMethod = @"column";
    	}
    	else if (hintResults[1] == 3)
    	{
    		theMethod = @"row";
    	}
    	[stringBuilder appendString:@"Remember, a "];
    	[stringBuilder appendString:theMethod];
    	[stringBuilder appendString:@" must have an occurrence of every number. If you can eliminate a number from the possibilities of every square in a "];
    	[stringBuilder appendString:theMethod];
    	[stringBuilder appendString:@" except one, the number must go in the final square!"];
		theHint = [NSstring stringWithString:stringBuilder];
		[stringBuilder release];
		[theMethod release];
	}
	return newHint;
}

/* The method that generates the second hint when passed tutor results.
 * This hint will have put 9 numbers into highlightOne, which correspond to the method used by the tutor.
 * It also contains text describing what actions should be taken next by the player.
 */
- (Hint *)makeHintTwo:(short *)hintResults
{
	Hint *newHint = [[Hint alloc] init];
	if (hintResults[0] == 1)
	{
		theHint = @"Examine the highlighted block. One sqaure in it has only one possibility!"
		short theBase = (hintResults[2] / 27) * 27 + ((hintResults[2] % 9) / 3) * 3;
		for (short i = 0; i < 9; i++)
		{
			short toAdd = theBase + (i % 3) + (i / 3) * 9;
			[highlightOne addObject:toAdd];
		}
	}
	if (hintResults[0] == 2)
	{
		NSMutableString *stringBuilder = [[NSMutableString alloc] init];
    	NSString *theMethod = [[NSString alloc] init];
    	if (hintResults[1] == 1)
    	{
    		theMethod = @"block";
    		short theBase = (hintResults[2] / 27) * 27 + ((hintResults[2] %  9) / 3) * 3;
    		for (short i = 0; i < 9; i++)
    		{
    			short toAdd = theBase + (i % 3) + (i / 3) * 9;
    			[highlightOne addObject:toAdd];
    		}
    	}
    	else if (hintResults[1] == 2)
    	{
    		theMethod = @"column";
    		short theBase = hintResults[2] % 9;
    		for (short i = 0; i < 9; i++)
    		{
    			short toAdd = theBase + 9 * i;
    			[highlightOne addObject:toAdd];
    		}
    	}
    	else if (hintResults[1] == 3)
    	{
    		theMethod = @"row";
    		short theBase = hintResults[2] - (hintResults[2] % 9);
    		for (short i = 0; i < 9; i++)
    		{
    			short toAdd = theBase + i;
    			[highlightOne addObject:toAdd];
    		}
    	}
    	[stringBuilder appendString:@"Examine the highlighted "];
    	[stringBuilder appendString:theMethod];
    	[stringBuilder appendString:@". There is a number that can only fit in one of the squares!"];
    	theHint = [NSstring stringWithString:stringBuilder];
		[stringBuilder release];
		[theMethod release];
	}
	return newHint;
}

/* The method that creates the third hint when passed tutor results. 
 * This hint fills highlightTwo with the square the user will be told about,
 * highlightOne with the squares you can use to deduce the contents of highlightTwo,
 * and a string explaining how the deduction happens.
 */
- (Hint *)makeHintThree:(short *)hintResults
{
	Hint *newHint = [[Hint alloc] init];
	NSMutableString *stringBuilder = [[NSMutableString alloc] init];
    NSString *theMethod = [[NSString alloc] init];
	if (hintResults[0] == 1)
	{
		[stringBuilder appendString:@"Because of numbers in the highlighted areas, the green square can only hold the number "];
		[stringBuilder appendFormat:@"%d", hintResults[3]];
		[stringBuilder appendString:@"."];
		short theBase = (hintResults[2] / 27) * 27 + ((hintResults[2] % 9) / 3) * 3;
		for (short i = 0; i < 9; i++)
		{
			short toAdd = theBase + (i % 3) + (i / 3) * 9;
			if (toAdd != hintResults[2])
			{
				[highlightOne addObject:toAdd];
			}
		}
		short theBase = hintResults[2] % 9;
		for (short i = 0; i < 9; i++)
		{
			short toAdd = theBase + 9 * i;
			if (toAdd % 27 != hintResults[2] % 27)
			{
				[highlightOne addObject:toAdd];
			}
		}
		short theBase = hintResults[2] - (hintResults[2] % 9);
		for (short i = 0; i < 9; i++)
		{
			short toAdd = theBase + i;
			if ((toAdd % 9) / 3 != (hintResults[2] % 9) / 3)
			{
				[highlightOne addObject:toAdd];
			}
		}
	}
	if (hintResults[0] == 2)
	{
		if (hintResults[1] == 1)
    	{
    		theMethod = @"block";
    		short theBase = (hintResults[2] / 27) * 27 + ((hintResults[2] %  9) / 3) * 3;
    		for (short i = 0; i < 9; i++)
    		{
    			short toAdd = theBase + (i % 3) + (i / 3) * 9;
    			if (toAdd != theResults[2])
    			{
    				[highlightOne addObject:toAdd];
    			}
    		}
    	}
    	else if (hintResults[1] == 2)
    	{
    		theMethod = @"column";
    		short theBase = hintResults[2] % 9;
    		for (short i = 0; i < 9; i++)
    		{
    			short toAdd = theBase + 9 * i;
    			if (toAdd != theResults[2])
    			{
    				[highlightOne addObject:toAdd];
    			}
    		}
    	}
    	else if (hintResults[1] == 3)
    	{
    		theMethod = @"row";
    		short theBase = hintResults[2] - (hintResults[2] % 9);
    		for (short i = 0; i < 9; i++)
    		{
    			short toAdd = theBase + i;
    			if (toAdd != theResults[2])
    			{
    				[highlightOne addObject:toAdd];
    			}
    		}
    	}
    	[stringBuilder appendString:@"As the number "];
    	[stirngBuilder appendFormat:@"%d", hintResults[3]];
    	[stringBuilder appendString:@" cannot go in any of the highlighted "];
    	[stringBuilder appendString:theMethod];
    	[stringBuilder appendString:@"'s sqaures save one, it must go in the green sqaure!"];
	}
	highlightTwo = hintResults[2];
	theHint = [NSstring stringWithString:stringBuilder];
	[stringBuilder release];
	[theMethod release];
	return newHint;
}
