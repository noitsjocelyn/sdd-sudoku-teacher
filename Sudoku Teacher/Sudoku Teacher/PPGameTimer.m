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
    if (!secondsTimer)
    {
        secondsTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateSeconds:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:secondsTimer forMode:NSDefaultRunLoopMode];
        [self updateNavigationBar];
    }
}

- (void)stopTimer
{
    [secondsTimer invalidate];
    secondsTimer = nil;
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
