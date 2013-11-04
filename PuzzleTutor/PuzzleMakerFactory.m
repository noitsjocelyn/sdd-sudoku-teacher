//
//  PuzzleMakerFactory.m
//  Sudoku Teacher
//
//  Created by Jonathan on 11/3/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import "PuzzleMakerFactory.h"
#import "SudokuBoard.h"
#import "SudokuBoardGenerator.h"

@implementation PuzzleMakerFactory

- (id)init
{
    if (self)
    {
        // Make semaphore
        genSemaphore = dispatch_semaphore_create(0);
    }
    return self;
}

+ (id)sharedInstance
{
    static dispatch_once_t pred;
    static PuzzleMakerFactory *sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[PuzzleMakerFactory alloc] init];
    });
    [sharedInstance generateBoard];
    return sharedInstance;
}

- (SudokuBoard *)getBoard
{
    // Wait until its done generating
    if (dispatch_semaphore_wait(genSemaphore, DISPATCH_TIME_FOREVER) == 0)
    {
        SudokuBoard *returnValue = currentBoard;
        [self generateBoard];
        return returnValue;
    }
    else
    {
        return nil;
    }
}

- (void)generateBoard
{
    // Get the dispatch queue
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0UL);
    // Signal the semaphore after currentBoard is generated
    dispatch_after(DISPATCH_TIME_NOW, queue, ^{
        if (!currentBoard)
        {
            currentBoard = [SudokuBoardGenerator generate];
        }
        dispatch_semaphore_signal(genSemaphore);
    });
    
}

@end
