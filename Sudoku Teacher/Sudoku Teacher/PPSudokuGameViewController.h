//
//  PPSudokuGameControllerViewController.h
//  Sudoku Teacher
//
//  Created by Jonathan on 10/25/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPGameDataProtocol.h"

@class PPGameTimer;
@class PPSudokuView;
@class Puzzle;

@interface PPSudokuGameViewController : UIViewController <PPGameDataProtocol, UIAlertViewDelegate>
{
    UIButton *squareButtons[81];
    UIView *processingView;
    UIActivityIndicatorView *processingIndicator;
    PPGameTimer *timer;
    Puzzle *puzzleData;
    NSUInteger difficulty;
    NSUInteger progressSeconds;
    UIAlertView *completeAlert;
    BOOL isTutorial;
}

@property (assign) NSUInteger buttonSelected;

@property (weak, nonatomic) id<PPGameDataProtocol> delegate;
@property (weak, nonatomic) IBOutlet PPSudokuView *boardBackground;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *hintButton;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *setValueButtons;

- (IBAction)setValue:(id)sender;
- (IBAction)numberButtonPressed:(id)sender;

- (void)setGameInProgress:(Puzzle *)thePuzzle;
- (void)setGameProgressTime:(NSUInteger)seconds;
- (void)setGameDifficulty:(NSUInteger)difficulty;
- (void)setIsGameTutorial:(BOOL)isGameTutorial;

@end
