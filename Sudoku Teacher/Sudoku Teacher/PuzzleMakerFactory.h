//
//  PuzzleMakerFactory.h
//  Sudoku Teacher
//
//  Created by Jonathan on 11/3/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SudokuBoard;

@interface PuzzleMakerFactory : NSObject
{
    short *currentBoard;
}

@property (strong, readonly) dispatch_semaphore_t genSemaphore;

+ (id)sharedInstance;
- (void)getBoard:(short *)outputArray;

@end
