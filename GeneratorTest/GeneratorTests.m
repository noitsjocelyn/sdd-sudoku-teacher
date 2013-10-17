/*
 * GeneratorTests.m so far
 */

#import "../PuzzleTutor/Puzzle.m"
#import "../SudokuGenerator/SudokuGenerator/JFRandom.m"
#import "../SudokuGenerator/SudokuGenerator/SudokuBoard.m"
#import "../SudokuGenerator/SudokuGenerator/SudokuBoardGenerator.m"
#import "../SudokuGenerator/SudokuGenerator/SudokuBoardSector.m"

int main()
{
    SudokuBoard *board = [SudokuBoardGenerator generate];
    short *shortArray = [board boardAsShortArray];
    Puzzle *aPuzzle = [[Puzzle alloc] initWithShortArray:shortArray];
    NSLog(@"\n%@", aPuzzle);
}
