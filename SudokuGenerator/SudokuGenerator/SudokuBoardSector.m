//
// SudokuBoardSector.m
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

#import "SudokuBoardSector.h"


@implementation SudokuBoardSector

@synthesize sectorId = _sectorId;
@synthesize numbers = _numbers;


#pragma mark - Object lifecycle methods

+ (id) sudokuBoardSector {
	
	id sudokuBoardSector = [[SudokuBoardSector alloc] init];
	#if  __has_feature(objc_arc)
		// Using ARC so do nothing
	#else
		[sudokuBoardSector autorelease];
	#endif
	
	return sudokuBoardSector;
}

- (id) init {
	
	self = [super init];
	if (self != nil) {
		_numbers = calloc(9, sizeof(NSUInteger));
	}
	
	return self;
}

- (void) dealloc {
	
	if (_numbers != nil) {
		free(_numbers);
	}
	
	#if  __has_feature(objc_arc)
		// Using ARC so do nothing
	#else
		[super dealloc];
	#endif
}


#pragma mark - Setter / getter methods

- (void) setNumber: (NSUInteger) number atX: (NSUInteger) x y: (NSUInteger) y {
	
	if (number < 1 || number > 9 || x > 2 || y > 2) {
		return;
	}
	
	_numbers[y * 3 + x] = number;
}

- (NSUInteger) numberAtX: (NSUInteger) x y: (NSUInteger) y {
	
	if (x > 2 || y > 2) {
		return 0;
	}
	
	return _numbers[y * 3 + x];
}


#pragma mark - Other methods

- (NSString *) descriptionOfLineNo: (NSUInteger) lineNo {
	
	NSUInteger number1 = [self numberAtX: 0 y: lineNo];
	NSUInteger number2 = [self numberAtX: 1 y: lineNo];
	NSUInteger number3 = [self numberAtX: 2 y: lineNo];
	NSMutableString *desc = [NSMutableString stringWithFormat: @"%lu %lu %lu ", (unsigned long)number1, (unsigned long)number2, (unsigned long)number3];
	
	return desc;
}

@end
