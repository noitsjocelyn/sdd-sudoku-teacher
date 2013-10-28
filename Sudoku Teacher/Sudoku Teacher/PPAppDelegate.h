//
//  PPAppDelegate.h
//  Sudoku Teacher
//
//  Created by Jonathan on 9/18/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Puzzle;

@interface PPAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (assign) Puzzle *gameBoard;
@property (assign) NSNumber *difficulty;

@end
