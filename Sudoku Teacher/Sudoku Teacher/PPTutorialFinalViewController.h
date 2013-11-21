//
//  PPTutorialFinalViewController.h
//  Sudoku Teacher
//
//  Created by Jonathan on 11/20/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPGameDataProtocol.h"

@class Puzzle;

@interface PPTutorialFinalViewController : UIViewController <PPGameDataProtocol>
{
    NSString *defaultBasicPuzzle;
    Puzzle *puzzleData;
}

@end
