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
    UIButton *valueLabels[81];
    UIView *processingView;
    UIActivityIndicatorView *processingIndicator;
}

@property (weak, nonatomic) IBOutlet PPSudokuView *boardBackground;
@property (assign) NSUInteger difficulty;

- (void)setupLabels;
- (void)setupProcessingView;
- (void)setValuesFromShortArray:(short *)valuesArray;
- (void)generateAndDisplayBoard:(id)sender;

@end
