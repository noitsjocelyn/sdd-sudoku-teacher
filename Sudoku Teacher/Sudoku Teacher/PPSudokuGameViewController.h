//
//  PPSudokuGameControllerViewController.h
//  Sudoku Teacher
//
//  Created by Jonathan on 10/25/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PPSudokuView;

@interface PPSudokuGameViewController : UIViewController
{
	UILabel *valueLabels[81];
	UIView *processingView;
	UIActivityIndicatorView *processingIndicator;
}

@property (weak, nonatomic) IBOutlet PPSudokuView *boardBackground;

- (void)setupLabels;
- (void)setValuesFromShortArray:(short *)valuesArray;
- (void)generateAndDisplayBoardWithDifficulty:(NSNumber *)difficulty;

@end
