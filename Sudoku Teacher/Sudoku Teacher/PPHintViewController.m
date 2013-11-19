//
//  PPHintViewController.m
//  Sudoku Teacher
//
//  Created by Jonathan on 11/18/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import "PPHintViewController.h"
#import "Hint.h"
#import "HintsMaker.h"
#import "Puzzle.h"

@interface PPHintViewController ()

@end

@implementation PPHintViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    aHintMaker = [[HintsMaker alloc] init];
    [self setUpHintPositions];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    hints = [aHintMaker createHints:self.puzzleData];
    [self.hintOneLabel setText:[[hints objectAtIndex:0] hintText]];
    [self.hintTwoLabel setText:[[hints objectAtIndex:1] hintText]];
    [self.hintThreeLabel setText:[[hints objectAtIndex:2] hintText]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.delegate setGame:self.puzzleData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpHintPositions
{
    shownHint = 1;
    CGFloat viewW = 320.0;
    CGFloat viewH = 320.0;
    CGFloat titleH = 64.0;
    CGFloat buttonH = 48.0;
    // Title bar has 0 height under iOS 6.1
    if ([[[UIDevice currentDevice] systemVersion] intValue] == 6)
    {
        titleH = 0.0;
    }
    hintTwoShownFrame = CGRectMake(0.0, titleH + buttonH, viewW, viewH);
    hintTwoHiddenFrame = CGRectMake(0.0, titleH + viewH, viewW, viewH);
    hintThreeShownFrame = CGRectMake(0.0, titleH + (2 * buttonH), viewW, viewH);
    hintThreeHiddenFrame = CGRectMake(0.0, titleH + viewH + buttonH, viewW, viewH);
}

- (IBAction)showHintOne:(id)sender {
    if (shownHint == 2)
    {
        [UIView animateWithDuration:ANIMATE_TIME animations:^(void) {
            [self.hintTwoView setFrame:hintTwoHiddenFrame];
        }];
    }
    else if (shownHint == 3)
    {
        [UIView animateWithDuration:ANIMATE_TIME animations:^(void) {
            [self.hintTwoView setFrame:hintTwoHiddenFrame];
            [self.hintThreeView setFrame:hintThreeHiddenFrame];
        }];
    }
    shownHint = 1;
}

- (IBAction)showHintTwo:(id)sender {
    if (shownHint == 1)
    {
        [UIView animateWithDuration:ANIMATE_TIME animations:^(void) {
            [self.hintTwoView setFrame:hintTwoShownFrame];
        }];
    }
    else if (shownHint == 3)
    {
        [UIView animateWithDuration:ANIMATE_TIME animations:^(void) {
            [self.hintThreeView setFrame:hintThreeHiddenFrame];
        }];
    }
    shownHint = 2;
}

- (IBAction)showHintThree:(id)sender {
    if (shownHint == 1)
    {
        [UIView animateWithDuration:ANIMATE_TIME animations:^(void) {
            [self.hintTwoView setFrame:hintTwoShownFrame];
            [self.hintThreeView setFrame:hintThreeShownFrame];
        }];
    }
    else if (shownHint == 2)
    {
        [UIView animateWithDuration:ANIMATE_TIME animations:^(void) {
            [self.hintThreeView setFrame:hintThreeShownFrame];
        }];
    }
    shownHint = 3;
}

@end
