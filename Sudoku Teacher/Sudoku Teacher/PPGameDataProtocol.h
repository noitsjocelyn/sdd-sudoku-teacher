//
//  PPGameDataProtocol.h
//  Sudoku Teacher
//
//  Created by Jonathan on 11/20/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Puzzle;

@protocol PPGameDataProtocol <NSObject>

- (void)setGameInProgress:(Puzzle *)thePuzzle;
- (void)setGameDifficulty:(NSUInteger)difficulty;
- (void)setGameProgressTime:(NSUInteger)seconds;

@end
