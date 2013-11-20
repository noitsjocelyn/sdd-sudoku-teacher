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
    NSTimer *secondTimer;
    NSUInteger seconds;
    NSUInteger hours;
    NSUInteger minutes;
    NSUInteger shownSeconds;
    NSString *zeroString;
    NSString *hourString;
}

@property (strong) UINavigationItem *navigationBar;

- (id)initWithSeconds:(NSUInteger)seconds;
- (void)startTimer;

@end
