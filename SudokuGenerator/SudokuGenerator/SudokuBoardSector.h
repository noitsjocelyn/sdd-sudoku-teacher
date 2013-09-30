//
// SudokuBoardSector.h
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

/*
 * A sector is a subset of the sudoku board 3x3 numbers in size.
 * The numbers within a sector are indexed in the below style...
 *
 * 0 1 2
 * 3 4 5
 * 6 7 8
 */
@interface SudokuBoardSector : NSObject {
	
@private
	NSUInteger _sectorId;
	
	NSUInteger *_numbers;
}

@property (nonatomic, assign) NSUInteger sectorId;
@property (nonatomic, readonly) NSUInteger *numbers;

+ (id) sudokuBoardSector;

- (void) setNumber: (NSUInteger) number atX: (NSUInteger) x y: (NSUInteger) y;
- (NSUInteger) numberAtX: (NSUInteger) x y: (NSUInteger) y;

- (NSString *) descriptionOfLineNo: (NSUInteger) lineNo;

@end
