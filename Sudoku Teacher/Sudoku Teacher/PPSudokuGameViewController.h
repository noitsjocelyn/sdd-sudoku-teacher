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
    BOOL valueModifiable[81];
    UIView *processingView;
    UIActivityIndicatorView *processingIndicator;
}

@property (weak, nonatomic) IBOutlet PPSudokuView *boardBackground;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *setValueButtons;
@property (assign) NSUInteger difficulty;
@property (assign) NSUInteger buttonSelected;

- (IBAction)setValue:(id)sender;
- (void)setupLabels;
- (void)setupProcessingView;
- (void)setValuesFromShortArray:(short *)valuesArray;
- (void)generateAndDisplayBoard:(id)sender;

@end
