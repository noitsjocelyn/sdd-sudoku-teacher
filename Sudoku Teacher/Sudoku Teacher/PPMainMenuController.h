//
//  PPMainMenuController.h
//  Sudoku Teacher
//
//  Created by Jonathan on 10/25/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Puzzle;

@protocol PPMainMenuProtocol

- (void)setGameInProgress:(Puzzle *)thePuzzle;
- (void)setProgressTime:(NSUInteger)seconds;

@end

@interface PPMainMenuController : UIViewController <PPMainMenuProtocol, UIAlertViewDelegate>
{
    CGRect easyCheckPosition;
    CGRect moderateCheckPosition;
    BOOL newGameConfirmed;
    UIAlertView *newGameAlert;
    NSUInteger progressSeconds;
}

@property (assign) NSUInteger difficulty;
@property (strong) Puzzle *puzzleInProgress;

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
