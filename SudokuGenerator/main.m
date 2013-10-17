//
//  main.m
//  SudokuGenerator
//
//  Created by Aaron Nellis on 9/29/13.
//  Copyright (c) 2013 Aaron Nellis. All rights reserved.
//

#import "SudokuBoard.h"
#import "SudokuBoardGenerator.h"

int main(int argc, const char * argv[])
{
    SudokuBoard *board = [SudokuBoardGenerator generate];
    
    NSLog(@"\n%@", board);
}

