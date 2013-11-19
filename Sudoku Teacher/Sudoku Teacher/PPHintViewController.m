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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    hints = [aHintMaker createHints:self.puzzleData];
    [self.hintOneLabel setText:[[hints objectAtIndex:0] hintText]];
    NSLog(@"%@", hints);
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

@end
