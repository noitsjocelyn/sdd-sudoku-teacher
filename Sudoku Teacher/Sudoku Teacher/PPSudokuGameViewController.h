//
//  PPSudokuGameControllerViewController.h
//  Sudoku Teacher
//
//  Created by Jonathan on 10/25/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPMainMenuController.h"

@class PPSudokuView;
@class Puzzle;

@protocol PPSudokuGameProtocol

- (void)setGame:(Puzzle *)thePuzzle;

@end

@interface PPSudokuGameViewController : UIViewController <PPSudokuGameProtocol>
{
    UIButton *squareButtons[81];
    UIView *processingView;
    UIActivityIndicatorView *processingIndicator;
    UIColor *userChosenValueColor;
}

@property (assign) NSUInteger difficulty;
@property (assign) NSUInteger buttonSelected;
@property (assign) Puzzle *puzzleData;

@property (weak, nonatomic) id<PPMainMenuProtocol> delegate;
@property (weak, nonatomic) IBOutlet PPSudokuView *boardBackground;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *setValueButtons;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *hintButton;

- (IBAction)setValue:(id)sender;
- (void)setupLabels;
- (void)setupProcessingView;
- (void)generateAndDisplayBoard:(id)sender;
- (void)setupFromPuzzleData:(Puzzle *)aPuzzle;

@end
