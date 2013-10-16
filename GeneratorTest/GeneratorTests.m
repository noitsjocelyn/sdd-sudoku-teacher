//
// GeneratorTests.m so far
//

#import "../SudokuGenerator/SudokuGenerator/JFRandom.m"
#import "../SudokuGenerator/SudokuGenerator/SudokuBoard.m"
#import "../SudokuGenerator/SudokuGenerator/SudokuBoardGenerator.m"
#import "../SudokuGenerator/SudokuGenerator/SudokuBoardSector.m"

int main()
{
    SudokuBoard *board = [SudokuBoardGenerator generate];
    
    // Prints normally
    NSLog(@"\n%@", board);
    
    /*
    // Attempted fast enumeration
    for (id object in board)
    {
        NSLog(@"number: %@", object);
    }
    
    // Attempted enumeration by blocks.
    [board enumerateObjectsUsingBlock:
         ^(id obj, NSUInteger idx, BOOL *stop)
         {
             NSLog (@"%@ at %lu", obj, idx);
             
             if (idx == 1)
             {
                 NSLog(@"Found index 1, stopping");
                 *stop = YES;
             }
         }
     ];
    */
}
