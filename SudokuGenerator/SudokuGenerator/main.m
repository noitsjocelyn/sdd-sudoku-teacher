//
//  main.m
//  SudokuGenerator
//
//  Created by Aaron Nellis on 9/29/13.
//  Copyright (c) 2013 Aaron Nellis. All rights reserved.
//

#import "JFRandom.m"
#import "SudokuBoard.m"
#import "SudokuBoardGenerator.m"
#import "SudokuBoardSector.m"

int main(int argc, const char * argv[])
{
    SudokuBoard *board = [SudokuBoardGenerator generate];
    
    printf("\n");
    NSLog(@"%@", board);
}

