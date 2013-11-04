/* A main function to run all of the Puzzle unit tests.
 */

#import <Foundation/Foundation.h>
#import "Puzzle.h"
#import "PuzzleFactoryTests.h"
#import "PuzzleMakerFactory.h"

@implementation PuzzleFactoryTests

- (id)init
{
    times = 0;
    return self;
}

- (void)run
{
    PuzzleMakerFactory *factory = [PuzzleMakerFactory sharedInstance];
    sleep(5);
    NSLog(@"Done sleeping");
    
    short iterations = 2;
    for (short i = 0; i < iterations; ++i)
    {
        [NSThread detachNewThreadSelector:@selector(useFactory)
                                 toTarget:self
                               withObject:nil];
        // [self useFactory];
    }
    
    while (times < iterations)
    {
        NSLog(@"Times = %d", times);
        sleep(1);
    }
    
    NSLog(@"Done");
}

- (void)useFactory
{
    PuzzleMakerFactory *factory = [PuzzleMakerFactory sharedInstance];
    
    short *puzzleArray = calloc(81, sizeof(short));
    [factory getBoard:puzzleArray];
    NSLog(@"Got a board!");
    
    Puzzle *aPuzzle = [[Puzzle alloc] initWithShortArray:puzzleArray];
    NSLog(@"Made a puzzle!");
    free(puzzleArray);
    NSLog(@"\n%@", aPuzzle);
    
    ++times;
    if (![NSThread isMainThread])
    {
        // [NSThread exit];
    }
}

@end
