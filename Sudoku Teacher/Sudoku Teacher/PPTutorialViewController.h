//
//  PPTutorialViewController.h
//  Sudoku Teacher
//
//  Created by Jonathan on 11/20/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Puzzle.h"

@interface PPTutorialViewController : UIViewController
{
    Puzzle *puzzleData;
    UILabel *labels[81];
}

@property (weak, nonatomic) IBOutlet UIView *boardView;

@end
