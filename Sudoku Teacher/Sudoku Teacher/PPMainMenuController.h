//
//  PPMainMenuController.h
//  Sudoku Teacher
//
//  Created by Jonathan on 10/25/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPMainMenuController : UIViewController
{
    CGRect easyCheckPosition;
    CGRect moderateCheckPosition;
}

@property (assign) NSUInteger difficulty;
@property (assign) BOOL hasGameInProgress;

@property (weak, nonatomic) IBOutlet UIButton *startGameButton;
@property (weak, nonatomic) IBOutlet UIButton *easyModeButton;
@property (weak, nonatomic) IBOutlet UIButton *moderateModeButton;
@property (weak, nonatomic) IBOutlet UIButton *learnToPlayButton;
@property (weak, nonatomic) IBOutlet UILabel *toggleCheck;

- (IBAction)toggleEasyMode:(id)sender;
- (IBAction)toggleModerateMode:(id)sender;

@end
