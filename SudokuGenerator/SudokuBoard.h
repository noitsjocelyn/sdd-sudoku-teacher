//
// SudokuBoard.h
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

#import <Foundation/Foundation.h>

@class SudokuBoardSector;

/*
 * A sudoku board is a collection of 9 sectors in a 3x3 grid, each section itself containing 9 numbers in a 3x3 grid.
 */
@interface SudokuBoard : NSObject {

@private
	NSArray *_sectors; // SudokuBoardSector instances
}

+ (id) sudokuBoard;
- (SudokuBoardSector *) sectorWithSectorId: (NSUInteger) sectorId;
- (short *) boardAsShortArray;

@end
