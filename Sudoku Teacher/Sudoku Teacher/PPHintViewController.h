//
//  PPHintViewController.h
//  Sudoku Teacher
//
//  Created by Jonathan on 11/18/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPSudokuGameViewController.h"

@class HintsMaker;
@class Puzzle;

@interface PPHintViewController : UIViewController
{
    HintsMaker *aHintMaker;
    NSArray *hints;
}

@property (strong) Puzzle *puzzleData;
@property (weak, nonatomic) id<PPSudokuGameProtocol> delegate;
@property (weak, nonatomic) IBOutlet UILabel *hintOneLabel;
@property (weak, nonatomic) IBOutlet UIButton *hintOneButton;

@end
