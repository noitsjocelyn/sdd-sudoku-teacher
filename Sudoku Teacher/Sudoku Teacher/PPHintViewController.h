//
//  PPHintViewController.h
//  Sudoku Teacher
//
//  Created by Jonathan on 11/18/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPGameDataProtocol.h"

#define ANIMATE_TIME 0.25

@class HintsMaker;
@class PPSudokuView;
@class Puzzle;

@interface PPHintViewController : UIViewController <PPGameDataProtocol>
{
    HintsMaker *aHintMaker;
    NSArray *hints;
    NSUInteger shownHint;
    CGRect hintTwoShownFrame;
    CGRect hintTwoHiddenFrame;
    CGRect hintThreeShownFrame;
    CGRect hintThreeHiddenFrame;
    // Our labels for sudoku values
    UILabel *hintTwoNumberLabels[81];
    UILabel *hintThreeNumberLabels[81];
    // Colors to highlight squares
    UIColor *firstLevelHighlightColor;
    UIColor *secondLevelHighlightColor;
    // Data so we can rebuild the puzzle after hints
    Puzzle *puzzleData;
    NSUInteger progressSeconds;
    NSUInteger difficulty;
    // Values for hint penalties
    BOOL hintTwoUsed;
    BOOL hintThreeUsed;
    NSUInteger hintOnePenalty;
    NSUInteger hintTwoPenalty;
    NSUInteger hintThreePenalty;
}

@property (weak, nonatomic) id<PPGameDataProtocol> delegate;
@property (weak, nonatomic) IBOutlet UIView *hintOneView;
@property (weak, nonatomic) IBOutlet UIView *hintTwoView;
@property (weak, nonatomic) IBOutlet UIView *hintThreeView;
@property (weak, nonatomic) IBOutlet UIButton *hintThreeButton;
@property (weak, nonatomic) IBOutlet UILabel *hintOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *hintTwoLabel;
@property (weak, nonatomic) IBOutlet UILabel *hintThreeLabel;
@property (weak, nonatomic) IBOutlet PPSudokuView *boardBackgroundTwo;
@property (weak, nonatomic) IBOutlet PPSudokuView *boardBackgroundThree;

- (IBAction)showHintOne:(id)sender;
- (IBAction)showHintTwo:(id)sender;
- (IBAction)showHintThree:(id)sender;

- (void)setGameInProgress:(Puzzle *)thePuzzle;
- (void)setGameProgressTime:(NSUInteger)seconds;
- (void)setGameDifficulty:(NSUInteger)gameDifficulty;

@end
