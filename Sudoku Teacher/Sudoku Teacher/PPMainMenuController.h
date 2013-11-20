//
//  PPMainMenuController.h
//  Sudoku Teacher
//
//  Created by Jonathan on 10/25/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPGameDataProtocol.h"

@class Puzzle;

@interface PPMainMenuController : UIViewController <PPGameDataProtocol, UIAlertViewDelegate>
{
    CGRect easyCheckPosition;
    CGRect moderateCheckPosition;
    BOOL newGameConfirmed;
    UIAlertView *newGameAlert;
    Puzzle *puzzleInProgress;
    NSUInteger difficulty;
    NSUInteger progressSeconds;
}

@property (weak, nonatomic) IBOutlet UIButton *startNewGameButton;
@property (weak, nonatomic) IBOutlet UIButton *resumeGameButton;
@property (weak, nonatomic) IBOutlet UIButton *learnToPlayButton;
@property (weak, nonatomic) IBOutlet UIButton *easyModeButton;
@property (weak, nonatomic) IBOutlet UIButton *moderateModeButton;
@property (weak, nonatomic) IBOutlet UILabel *toggleCheck;

- (IBAction)toggleEasyMode:(id)sender;
- (IBAction)toggleModerateMode:(id)sender;

- (void)setupCheckPositions;

@end
