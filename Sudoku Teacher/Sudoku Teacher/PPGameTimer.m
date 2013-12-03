//
//  PPGameTimer.m
//  Sudoku Teacher
//
//  Created by Jonathan on 11/19/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import "PPGameTimer.h"

@implementation PPGameTimer

- (id)init
{
    self = [super init];
    if (self)
    {
        totalSeconds = 0;
    }
    return self;
}

- (id)initWithSeconds:(NSUInteger)startSeconds
{
    self = [super init];
    if (self)
    {
        totalSeconds = startSeconds;
    }
    return self;
}

- (void)startTimer
{
    // Only start if we don't already have one
    if (!secondsTimer)
    {
        secondsTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateSeconds:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:secondsTimer forMode:NSDefaultRunLoopMode];
        [self updateNavigationBar];
    }
}

- (void)pauseTimer
{
    // Only do this if we have a timer
    if (secondsTimer)
    {
        // Remove the timer, but don't reset the seconds count
        [secondsTimer invalidate];
        secondsTimer = nil;
    }
}

- (void)stopTimer
{
    // Pause the timer...
    [self pauseTimer];
    // ...then reset the seconds count
    totalSeconds = 0;
}

- (NSUInteger)getTime
{
    return totalSeconds;
}

- (void)updateSeconds:(id)sender
{
    ++totalSeconds;
    [self updateNavigationBar];
}

- (void)updateNavigationBar
{
    if (self.navigationBar)
    {
        [self.navigationBar setTitle:[self timeStringFromSeconds]];
    }
}

- (NSString *)timeStringFromSeconds
{
    // Calculate our values
    hours = totalSeconds / 3600;
    minutes = totalSeconds / 60;
    seconds = totalSeconds % 60;
    // Get our zero for in front of seconds (if needed)
    zeroString = seconds < 10 ? @"0" : @"";
    // Make our hour string (if needed)
    hourString = hours > 0 ? [NSString stringWithFormat:@"%lu:", hours] : @"";
    // Put it all together
    return [NSString stringWithFormat:@"%@%lu:%@%lu", hourString, minutes, zeroString, seconds];
}

@end
