//
//  PPHintViewController.h
//  Sudoku Teacher
//
//  Created by Jonathan on 11/18/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Puzzle;

@interface PPHintViewController : UIViewController
{
    NSArray *hints;
}

@property (assign) Puzzle *puzzleData;

@end
