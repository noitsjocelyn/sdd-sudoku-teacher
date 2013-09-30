//
// SudokuBoard.m
// Clean room implementation of Sudoku board generator.
//
// Created by Jason Fuerstenberg on 12/06/03.
// "Sudoku", the product name is owned by NIKOLI Co., Ltd. and this implementation is not endorsed nor supported by NIKOLI.
//
// http://www.jayfuerstenberg.com
// jay@jayfuerstenberg.com
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "SudokuBoard.h"

@implementation SudokuBoard


#pragma mark - Object lifecycle methods

+ (id) sudokuBoard {
	
	id sudokuBoard = [[SudokuBoard alloc] init];
	#if  __has_feature(objc_arc)
		// Using ARC so do nothing
	#else
		[sudokuBoard autorelease];
	#endif
	
	return sudokuBoard;
}

- (id) init {
	
	self = [super init];

	if (self != nil) {
		SudokuBoardSector *s1 = [SudokuBoardSector sudokuBoardSector];
		SudokuBoardSector *s2 = [SudokuBoardSector sudokuBoardSector];
		SudokuBoardSector *s3 = [SudokuBoardSector sudokuBoardSector];
		SudokuBoardSector *s4 = [SudokuBoardSector sudokuBoardSector];
		SudokuBoardSector *s5 = [SudokuBoardSector sudokuBoardSector];
		SudokuBoardSector *s6 = [SudokuBoardSector sudokuBoardSector];
		SudokuBoardSector *s7 = [SudokuBoardSector sudokuBoardSector];
		SudokuBoardSector *s8 = [SudokuBoardSector sudokuBoardSector];
		SudokuBoardSector *s9 = [SudokuBoardSector sudokuBoardSector];
		
		_sectors = [NSArray arrayWithObjects: s1, s2, s3, s4, s5, s6, s7, s8, s9, nil];
		
		[s1 setSectorId: 0];
		[s2 setSectorId: 1];
		[s3 setSectorId: 2];
		[s4 setSectorId: 3];
		[s5 setSectorId: 4];
		[s6 setSectorId: 5];
		[s7 setSectorId: 6];
		[s8 setSectorId: 7];
		[s9 setSectorId: 8];
	}
	
	return self;
}

- (void) dealloc {
	
	#if  __has_feature(objc_arc)
		// Using ARC so do nothing
	#else
		[_sectors release];
		[super dealloc];
	#endif
}


#pragma mark - Sector related methods

- (SudokuBoardSector *) sectorWithSectorId: (NSUInteger) sectorId {
	
	return [_sectors objectAtIndex: sectorId];
}


#pragma mark - Other methods

- (NSString *) description {
	
	SudokuBoardSector *sector1 = [_sectors objectAtIndex: 0];
	SudokuBoardSector *sector2 = [_sectors objectAtIndex: 1];
	SudokuBoardSector *sector3 = [_sectors objectAtIndex: 2];
	SudokuBoardSector *sector4 = [_sectors objectAtIndex: 3];
	SudokuBoardSector *sector5 = [_sectors objectAtIndex: 4];
	SudokuBoardSector *sector6 = [_sectors objectAtIndex: 5];
	SudokuBoardSector *sector7 = [_sectors objectAtIndex: 6];
	SudokuBoardSector *sector8 = [_sectors objectAtIndex: 7];
	SudokuBoardSector *sector9 = [_sectors objectAtIndex: 8];
	
	NSMutableString *desc = [NSMutableString stringWithFormat: @"%@%@%@\n%@%@%@\n%@%@%@\n%@%@%@\n%@%@%@\n%@%@%@\n%@%@%@\n%@%@%@\n%@%@%@\n",
							 [sector1 descriptionOfLineNo: 0],
							 [sector2 descriptionOfLineNo: 0],
							 [sector3 descriptionOfLineNo: 0],
							 [sector1 descriptionOfLineNo: 1],
							 [sector2 descriptionOfLineNo: 1],
							 [sector3 descriptionOfLineNo: 1],
							 [sector1 descriptionOfLineNo: 2],
							 [sector2 descriptionOfLineNo: 2],
							 [sector3 descriptionOfLineNo: 2],
							 
							 [sector4 descriptionOfLineNo: 0],
							 [sector5 descriptionOfLineNo: 0],
							 [sector6 descriptionOfLineNo: 0],
							 [sector4 descriptionOfLineNo: 1],
							 [sector5 descriptionOfLineNo: 1],
							 [sector6 descriptionOfLineNo: 1],
							 [sector4 descriptionOfLineNo: 2],
							 [sector5 descriptionOfLineNo: 2],
							 [sector6 descriptionOfLineNo: 2],
							 
							 [sector7 descriptionOfLineNo: 0],
							 [sector8 descriptionOfLineNo: 0],
							 [sector9 descriptionOfLineNo: 0],
							 [sector7 descriptionOfLineNo: 1],
							 [sector8 descriptionOfLineNo: 1],
							 [sector9 descriptionOfLineNo: 1],
							 [sector7 descriptionOfLineNo: 2],
							 [sector8 descriptionOfLineNo: 2],
							 [sector9 descriptionOfLineNo: 2]
							 ];
	
	return desc;
}

@end
