/*
 * GeneratorTests.m so far
 */

#import "../PuzzleTutor/Puzzle.h"
#import "../SudokuGenerator/SudokuGenerator/JFRandom.h"
#import "../SudokuGenerator/SudokuGenerator/SudokuBoard.h"
#import "../SudokuGenerator/SudokuGenerator/SudokuBoardGenerator.h"
#import "../SudokuGenerator/SudokuGenerator/SudokuBoardSector.h"

int main()
{
    SudokuBoard *board = [SudokuBoardGenerator generate];
    short *shortArray = [board boardAsShortArray];
    Puzzle *aPuzzle = [[Puzzle alloc] initWithShortArray:shortArray];
    NSLog(@"\n%@", aPuzzle);
}
