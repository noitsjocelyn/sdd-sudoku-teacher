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
- (void)setGameProgressTime:(NSUInteger)seconds;
- (void)setGameDifficulty:(NSUInteger)gameDifficulty;
- (void)setIsGameTutorial:(BOOL)isGameTutorial;

@end
