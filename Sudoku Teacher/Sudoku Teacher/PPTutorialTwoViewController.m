//
//  PPTutorialTwoViewController.m
//  Sudoku Teacher
//
//  Created by Jonathan on 11/20/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import "PPTutorialTwoViewController.h"

@interface PPTutorialTwoViewController ()

@end

@implementation PPTutorialTwoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    puzzleData = [[Puzzle alloc] initWithString:@"654300890902058001103690254860100700031825640005009083327084906500930402096001538"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
