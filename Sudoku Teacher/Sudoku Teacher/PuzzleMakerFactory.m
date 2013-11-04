//
//  PuzzleMakerFactory.m
//  Sudoku Teacher
//
//  Created by Jonathan on 11/3/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import "PuzzleMakerFactory.h"
#import "../SudokuGenerator/SudokuBoard.h"
#import "../SudokuGenerator/SudokuBoardGenerator.h"

@implementation PuzzleMakerFactory

- (id)init
{
    if (self)
    {
        currentBoard = calloc(81, sizeof(short));
        [self generateBoard];
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
    return sharedInstance;
}

- (void)getBoard:(short *)outputArray
{    @synchronized (self)
    {
        dispatch_semaphore_wait(self.genSemaphore, DISPATCH_TIME_FOREVER);
        for (NSUInteger i = 0; i < 81; ++i)
        {
            outputArray[i] = currentBoard[i];
        }
        [self generateBoard];
    }
}

- (void)generateBoard
{
    // Make semaphore
    _genSemaphore = dispatch_semaphore_create(0);
    // Signal the semaphore after currentBoard is generated
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        SudokuBoard *newBoard = [[SudokuBoard alloc] init];
        newBoard = [SudokuBoardGenerator generate];
        currentBoard = [newBoard boardAsShortArray:currentBoard];
        dispatch_semaphore_signal(_genSemaphore);
    });
}

@end
