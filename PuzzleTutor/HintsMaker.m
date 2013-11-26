/* Implementation of the Hint class
 */

#import "HintsMaker.h"

#import "Hint.h"
#import "Puzzle.h"

@implementation HintsMaker

/* Method that calls all of the private methods for our app to use.
 */
- (NSArray *)createHints:(Puzzle *)thePuzzle
{
    short theResults[4];
    [thePuzzle findSquareWithOneAvailableValue:theResults];
    if (theResults[0] == 0)
    {
        [thePuzzle findSquareInChunkWithRequiredValue:theResults];
    }
    NSArray *hints = [self makeHints:theResults];
    return hints;
}

/* Method that returns an array of three hints when passed the results of a
 * tutor search.
 */
- (NSArray *)makeHints:(short *)hintResults
{
    Hint *hint1 = [self makeHintOne:hintResults];
    Hint *hint2 = [self makeHintTwo:hintResults];
    Hint *hint3 = [self makeHintThree:hintResults];
    NSArray *theHints = [NSArray arrayWithObjects:hint1, hint2, hint3, nil];
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
		newHint.hintText = @"Remember, a row, column, or block can only have one occurrence of a number. You can use this fact to eliminate possibilities from other squares. Once there is only one possibility remaining for a square, you know the number that has to go there!";
	}
	else if (hintResults[0] == 2)
	{
    	NSMutableString *stringBuilder = [[NSMutableString alloc] init];
    	NSString *theMethod;
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
		newHint.hintText = [NSString stringWithString:stringBuilder];
	}
    else
    {
        newHint.hintText = @"";
    }
	return newHint;
}

/* The method that generates the second hint when passed tutor results. This
 * hint will have put 9 numbers into highlightOne, which correspond to the
 * method used by the tutor. It also contains text describing what actions
 * should be taken next by the player.
 */
- (Hint *)makeHintTwo:(short *)hintResults
{
	Hint *newHint = [[Hint alloc] init];
	if (hintResults[0] == 1)
	{
        NSMutableArray *firstHighlights = [[NSMutableArray alloc] init];
		newHint.hintText = @"Examine the highlighted block. One sqaure in it has only one possibility!";
		short theBase = (hintResults[2] / 27) * 27 + ((hintResults[2] % 9) / 3) * 3;
		for (short i = 0; i < 9; ++i)
		{
            NSNumber *toAdd = [NSNumber numberWithInteger:(theBase + (i % 3) + (i / 3) * 9)];
			[firstHighlights addObject:toAdd];
		}
        newHint.firstLevelHighlights = [NSArray arrayWithArray:firstHighlights];
	}
	else if (hintResults[0] == 2)
	{
        NSMutableArray *firstHighlights = [[NSMutableArray alloc] init];
		NSMutableString *stringBuilder = [[NSMutableString alloc] init];
    	NSString *theMethod = [[NSString alloc] init];
    	if (hintResults[1] == 1)
    	{
    		theMethod = @"block";
    		short theBase = (hintResults[2] / 27) * 27 + ((hintResults[2] %  9) / 3) * 3;
    		for (short i = 0; i < 9; i++)
    		{
    			NSNumber *toAdd = [NSNumber numberWithInteger:(theBase + (i % 3) + (i / 3) * 9)];
    			[firstHighlights addObject:toAdd];
    		}
    	}
    	else if (hintResults[1] == 2)
    	{
    		theMethod = @"column";
    		short theBase = hintResults[2] % 9;
    		for (short i = 0; i < 9; i++)
    		{
    			NSNumber *toAdd = [NSNumber numberWithInteger:(theBase + 9 * i)];
    			[firstHighlights addObject:toAdd];
    		}
    	}
    	else if (hintResults[1] == 3)
    	{
    		theMethod = @"row";
    		short theBase = hintResults[2] - (hintResults[2] % 9);
    		for (short i = 0; i < 9; i++)
    		{
    			NSNumber *toAdd = [NSNumber numberWithInteger:(theBase + i)];
    			[firstHighlights addObject:toAdd];
    		}
    	}
    	[stringBuilder appendString:@"Examine the highlighted "];
    	[stringBuilder appendString:theMethod];
    	[stringBuilder appendString:@". There is a number that can only fit in one of the squares!"];
    	newHint.hintText = [NSString stringWithString:stringBuilder];
        newHint.firstLevelHighlights = [NSArray arrayWithArray:firstHighlights];
	}
    else
    {
        newHint.hintText = @"";
    }
	return newHint;
}

/* The method that creates the third hint when passed tutor results. This hint
 * fills highlightTwo with the square the user will be told about, highlightOne
 * with the squares you can use to deduce the contents of highlightTwo, and a
 * string explaining how the deduction happens.
 */
- (Hint *)makeHintThree:(short *)hintResults
{
	Hint *newHint = [[Hint alloc] init];
	NSMutableString *stringBuilder = [[NSMutableString alloc] init];
    NSString *theMethod;
	if (hintResults[0] == 1)
	{
        NSMutableArray *firstHighlights = [[NSMutableArray alloc] init];
		[stringBuilder appendString:@"Because of numbers in the highlighted areas, the green square can only hold the number "];
		[stringBuilder appendFormat:@"%d", hintResults[3]];
		[stringBuilder appendString:@"."];
		short theBase = (hintResults[2] / 27) * 27 + ((hintResults[2] % 9) / 3) * 3;
		for (short i = 0; i < 9; i++)
		{
			NSNumber *toAdd = [NSNumber numberWithInteger:(theBase + (i % 3) + (i / 3) * 9)];
			if ([toAdd shortValue] != hintResults[2])
			{
				[firstHighlights addObject:toAdd];
			}
		}
		theBase = hintResults[2] % 9;
		for (short i = 0; i < 9; i++)
		{
			NSNumber *toAdd = [NSNumber numberWithInteger:(theBase + 9 * i)];
			if ([toAdd shortValue] % 27 != hintResults[2] % 27)
			{
				[firstHighlights addObject:toAdd];
			}
		}
		theBase = hintResults[2] - (hintResults[2] % 9);
		for (short i = 0; i < 9; i++)
		{
			NSNumber *toAdd = [NSNumber numberWithInteger:(theBase + i)];
			if (([toAdd shortValue] % 9) / 3 != (hintResults[2] % 9) / 3)
			{
				[firstHighlights addObject:toAdd];
			}
		}
	}
	else if (hintResults[0] == 2)
	{
        NSMutableArray *firstHighlights = [[NSMutableArray alloc] init];
		if (hintResults[1] == 1)
    	{
    		theMethod = @"block";
    		short theBase = (hintResults[2] / 27) * 27 + ((hintResults[2] %  9) / 3) * 3;
    		for (short i = 0; i < 9; i++)
    		{
    			NSNumber *toAdd = [NSNumber numberWithInteger:(theBase + (i % 3) + (i / 3) * 9)];
    			if ([toAdd shortValue] != hintResults[2])
    			{
    				[firstHighlights addObject:toAdd];
    			}
    		}
    	}
    	else if (hintResults[1] == 2)
    	{
    		theMethod = @"column";
    		short theBase = hintResults[2] % 9;
    		for (short i = 0; i < 9; i++)
    		{
    			NSNumber *toAdd = [NSNumber numberWithInteger:(theBase + 9 * i)];
    			if ([toAdd shortValue] != hintResults[2])
    			{
    				[firstHighlights addObject:toAdd];
    			}
    		}
    	}
    	else if (hintResults[1] == 3)
    	{
    		theMethod = @"row";
    		short theBase = hintResults[2] - (hintResults[2] % 9);
    		for (short i = 0; i < 9; i++)
    		{
    			NSNumber *toAdd = [NSNumber numberWithInteger:(theBase + i)];
    			if ([toAdd shortValue] != hintResults[2])
    			{
    				[firstHighlights addObject:toAdd];
    			}
    		}
    	}
    	[stringBuilder appendString:@"As the number "];
    	[stringBuilder appendFormat:@"%d", hintResults[3]];
    	[stringBuilder appendString:@" cannot go in any of the highlighted "];
    	[stringBuilder appendString:theMethod];
    	[stringBuilder appendString:@"'s sqaures save one, it must go in the green sqaure!"];
	}
	newHint.secondLevelHighlight = [NSNumber numberWithShort:hintResults[2]];
	newHint.hintText = [NSString stringWithString:stringBuilder];
	return newHint;
}

@end
