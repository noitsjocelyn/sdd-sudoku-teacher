//
//  PPAppDelegate.h
//  Sudoku Teacher
//
//  Created by Jonathan on 9/18/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PPMainMenuController;

@interface PPAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) PPMainMenuController *viewController;

@end
