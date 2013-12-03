//
//  PPGameTimer.h
//  Sudoku Teacher
//
//  Created by Jonathan on 11/19/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPGameTimer : NSObject
{
    NSTimer *secondsTimer;
    unsigned long totalSeconds;
    unsigned long hours;
    unsigned long minutes;
    unsigned long seconds;
    NSString *zeroString;
    NSString *hourString;
}

@property (strong) UINavigationItem *navigationBar;

- (id)initWithSeconds:(NSUInteger)seconds;
- (void)startTimer;
- (void)pauseTimer;
- (void)stopTimer;
- (NSUInteger)getTime;

@end
