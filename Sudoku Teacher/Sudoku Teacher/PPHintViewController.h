//
//  PPHintViewController.h
//  Sudoku Teacher
//
//  Created by Jonathan on 11/18/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPSudokuGameViewController.h"

#define ANIMATE_TIME 0.25

@class HintsMaker;
@class Puzzle;

@interface PPHintViewController : UIViewController
{
    HintsMaker *aHintMaker;
    NSArray *hints;
    CGRect hintTwoShownFrame;
    CGRect hintThreeShownFrame;
    CGRect hintTwoHiddenFrame;
    CGRect hintThreeHiddenFrame;
    NSUInteger shownHint;
}

@property (strong) Puzzle *puzzleData;
@property (weak, nonatomic) id<PPSudokuGameProtocol> delegate;
@property (weak, nonatomic) IBOutlet UIView *hintOneView;
@property (weak, nonatomic) IBOutlet UIView *hintTwoView;
@property (weak, nonatomic) IBOutlet UIView *hintThreeView;
@property (weak, nonatomic) IBOutlet UILabel *hintOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *hintTwoLabel;
@property (weak, nonatomic) IBOutlet UILabel *hintThreeLabel;

- (IBAction)showHintOne:(id)sender;
- (IBAction)showHintTwo:(id)sender;
- (IBAction)showHintThree:(id)sender;


@end
