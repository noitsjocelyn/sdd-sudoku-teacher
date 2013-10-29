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

@interface PPSudokuGameViewController : UIViewController
{
    UIButton *valueLabels[81];
    BOOL valueModifiable[81];
    UIView *processingView;
    UIActivityIndicatorView *processingIndicator;
}

@property (assign) NSUInteger difficulty;
@property (assign) BOOL shouldResumeGame;
@property (assign) NSUInteger buttonSelected;
@property (assign) Puzzle *puzzleData;

@property (weak, nonatomic) id<PPMainMenuProtocol> delegate;
@property (weak, nonatomic) IBOutlet PPSudokuView *boardBackground;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *setValueButtons;

- (IBAction)setValue:(id)sender;
- (void)setupLabels;
- (void)setupProcessingView;
- (void)setValuesFromShortArray:(short *)valuesArray;
- (void)generateAndDisplayBoard:(id)sender;
- (void)setupFromPuzzleData;

@end
