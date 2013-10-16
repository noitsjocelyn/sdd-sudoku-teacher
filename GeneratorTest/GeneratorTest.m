//
//generatortest.m so far
//

#import "JFRandom.m"
#import "SudokuBoard.m"
#import "SudokuBoardGenerator.m"
#import "SudokuBoardSector.m"

int main()
{
    SudokuBoard* board = [SudokuBoardGenerator generate];
    
    //Prints normally
    //NSLog(@"\n%@", board);
    
    
    //Attempting to put elements into new array
    NSMutableArray* test = [NSMutableArray array];
    [test addObjectsFromArray:board];
    for (id object in test)
    {
        NSLog(@"number: %@", test);
    }
    
    //Attempted fast enumeration
    for (id object in board)
    {
        NSLog(@"number: %@", board);
    }
    
    //Attempted enumeration by blocks.
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
}

