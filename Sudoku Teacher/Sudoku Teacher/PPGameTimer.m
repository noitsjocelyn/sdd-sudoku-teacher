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
        seconds = 0;
    }
    return self;
}

- (id)initWithSeconds:(NSUInteger)startSeconds
{
    self = [super init];
    if (self)
    {
        seconds = startSeconds;
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
    seconds = 0;
}

- (NSUInteger)getTime
{
    return seconds;
}

- (void)updateSeconds:(id)sender
{
    ++seconds;
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
    hours = seconds / 3600;
    minutes = seconds / 60;
    shownSeconds = seconds % 60;
    // Get our zero for in front of seconds (if needed)
    zeroString = seconds < 10 ? @"0" : @"";
    // Make our hour string (if needed)
    hourString = hours > 0 ? [NSString stringWithFormat:@"%d:", hours] : @"";
    // Put it all together
    return [NSString stringWithFormat:@"%@%d:%@%d", hourString, minutes, zeroString, shownSeconds];
}

@end
