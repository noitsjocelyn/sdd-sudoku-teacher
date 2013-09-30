//
// SudokuBoardGenerator.m
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

#import "SudokuBoardGenerator.h"


@interface SudokuBoardGenerator (PrivateMethods)

+ (BOOL) isValidSudokuBoard: (SudokuBoard *) board;
+ (BOOL) ensureUniqueArray: (NSArray *) array;
+ (NSArray *) lineWithBoard: (SudokuBoard *) board horizontal: (BOOL) horizontal lineNo: (NSInteger) lineNo;
+ (NSArray *) indicesOfUnpopulatedNumbersInBoard: (SudokuBoard *) board sector: (SudokuBoardSector *) sector withRandomNumber: (NSInteger) randomNumber;
+ (void) markApplicableHorizontal: (BOOL) horizontal linesInSector: (SudokuBoardSector *) sector withRandomNumber: (NSUInteger) randomNumber asPopulatedWithPopulatedFlags: (BOOL *) populatedFlags;
+ (void) markHorizontal: (BOOL) horizontal lineOfNumberIndex: (NSInteger) numberIndex asPopulatedWithPopulatedFlags: (BOOL *) populatedFlags;
+ (void) resetBoard: (SudokuBoard *) board forRandomNumber: (NSInteger) randomNumber;

@end


@implementation SudokuBoardGenerator


#pragma mark - Generation method

/*
 * Returns a randomly generated sudoku board or nil if there is a failure.
 */
+ (SudokuBoard *) generate {
	
	SudokuBoard *board = [SudokuBoard sudokuBoard];
	
	NSInteger randomNumbers[9];
	[JFRandom generateNumberSequenceOfLength: 9
										into: randomNumbers
								  betweenLow: 1
									 andHigh: 9
						withOnlyUniqueValues: YES];
	
	// Iterate through all the random numbers...
	for (NSInteger i = 0; i < 9; i++) {
		NSInteger randomNumber = randomNumbers[i];
		
		for (int sectorId = 0; sectorId < 9; sectorId++) {
			SudokuBoardSector *sector = [board sectorWithSectorId: sectorId];
			NSUInteger *numbers = [sector numbers];
			NSArray *indices = [SudokuBoardGenerator indicesOfUnpopulatedNumbersInBoard: board
																				 sector: sector
																	   withRandomNumber: randomNumber];
			
			NSUInteger count = [indices count];
			if (count == 1) {
				NSInteger index = [[indices lastObject] integerValue];
				numbers[index] = randomNumber;
				
				continue;
			}
			
			if (count == 0) {
				[SudokuBoardGenerator resetBoard: board forRandomNumber: randomNumber];
				i--;
				if (i < 0) {
					i = 0;
				}
				continue;
			}
			
			NSInteger randomIndex = 0;
			[JFRandom generateNumberBetweenLow: 0
									   andHigh: count - 1
								  intoReceiver: &randomIndex];
			
			NSInteger index = [[indices objectAtIndex: randomIndex] integerValue];
			numbers[index] = randomNumber;
		}
	}
	
	if (![SudokuBoardGenerator isValidSudokuBoard: board]) {
		// Invalid board!
		return nil;
	}
	
	return board;
}


#pragma mark - Private methods

/*
 * Returns YES if the provided board is valid, NO otherwise.
 */
+ (BOOL) isValidSudokuBoard: (SudokuBoard *) board {
	
	for (NSInteger i = 0; i < 9; i++) {
		
		NSArray *horizontalLine = [SudokuBoardGenerator lineWithBoard: board horizontal: YES lineNo: i];
		NSArray *verticalLine = [SudokuBoardGenerator lineWithBoard: board horizontal: NO lineNo: i];
		SudokuBoardSector *sector = [board sectorWithSectorId: i];
		NSUInteger *b = [sector numbers];
		NSArray *sectorArray = [NSArray arrayWithObjects: [NSNumber numberWithInteger: b[0]],
								[NSNumber numberWithInteger: b[1]],
								[NSNumber numberWithInteger: b[2]],
								[NSNumber numberWithInteger: b[3]],
								[NSNumber numberWithInteger: b[4]],
								[NSNumber numberWithInteger: b[5]],
								[NSNumber numberWithInteger: b[6]],
								[NSNumber numberWithInteger: b[7]],
								[NSNumber numberWithInteger: b[8]], nil];
		
		if (![SudokuBoardGenerator ensureUniqueArray: horizontalLine]) {
			return NO;
		}
		
		if (![SudokuBoardGenerator ensureUniqueArray: verticalLine]) {
			return NO;
		}
		
		if (![SudokuBoardGenerator ensureUniqueArray: sectorArray]) {
			return NO;
		}
	}
	
	return YES;
}

/*
 * Returns YES if the provided array contains only unique numbers, NO otherwise.
 */
+ (BOOL) ensureUniqueArray: (NSArray *) array {
	
	if ([array count] != 9) {
		return NO;
	}
	
	for (NSInteger currentNumber = 1; currentNumber < 10; currentNumber++) {
		NSInteger count = 0;
		
		for (NSInteger index = 0; index < 9; index++) {
			NSInteger number = [[array objectAtIndex: index] integerValue];
			if (number == currentNumber) {
				count++;
			}
		}
		
		if (count != 1) {
			return  NO;
		}
	}
	
	return YES;
}

/*
 * Returns an array depicting a list in the board, be it horizontal or vertical.
 */
+ (NSArray *) lineWithBoard: (SudokuBoard *) board horizontal: (BOOL) horizontal lineNo: (NSInteger) lineNo {
	
	SudokuBoardSector *sector1 = nil;
	SudokuBoardSector *sector2 = nil;
	SudokuBoardSector *sector3 = nil;
	NSUInteger *numbers1 = nil;
	NSUInteger *numbers2 = nil;
	NSUInteger *numbers3 = nil;
	NSArray *line = nil;
	
	if (horizontal) {
		// Horizontal line...
		NSInteger b = 3 * (lineNo / 3);
		
		sector1 = [board sectorWithSectorId: b];
		sector2 = [board sectorWithSectorId: b + 1];
		sector3 = [board sectorWithSectorId: b + 2];
		
		numbers1 = [sector1 numbers];
		numbers2 = [sector2 numbers];
		numbers3 = [sector3 numbers];
		
		line = [NSArray arrayWithObjects: [NSNumber numberWithInteger: numbers1[0]],
				[NSNumber numberWithInteger: numbers1[1]],
				[NSNumber numberWithInteger: numbers1[2]],
				[NSNumber numberWithInteger: numbers2[0]],
				[NSNumber numberWithInteger: numbers2[1]],
				[NSNumber numberWithInteger: numbers2[2]],
				[NSNumber numberWithInteger: numbers3[0]],
				[NSNumber numberWithInteger: numbers3[1]],
				[NSNumber numberWithInteger: numbers3[2]], nil];
		
	} else {
		// Vertical line...
		NSInteger b = (lineNo / 3);
		NSInteger a = lineNo - (b * 3);
		
		sector1 = [board sectorWithSectorId: b];
		sector2 = [board sectorWithSectorId: b + 3];
		sector3 = [board sectorWithSectorId: b + 6];
		
		numbers1 = [sector1 numbers];
		numbers2 = [sector2 numbers];
		numbers3 = [sector3 numbers];
		
		
		line = [NSArray arrayWithObjects: [NSNumber numberWithInteger: numbers1[a]],
				[NSNumber numberWithInteger: numbers1[a + 3]],
				[NSNumber numberWithInteger: numbers1[a + 6]],
				[NSNumber numberWithInteger: numbers2[a]],
				[NSNumber numberWithInteger: numbers2[a + 3]],
				[NSNumber numberWithInteger: numbers2[a + 6]],
				[NSNumber numberWithInteger: numbers3[a]],
				[NSNumber numberWithInteger: numbers3[a + 3]],
				[NSNumber numberWithInteger: numbers3[a + 6]], nil];
	}
	
	return line;
}

/*
 * Returns an array of NSNumber instances.
 */
+ (NSArray *) indicesOfUnpopulatedNumbersInBoard: (SudokuBoard *) board sector: (SudokuBoardSector *) sector withRandomNumber: (NSInteger) randomNumber {
	
	BOOL *populatedFlags = [SudokuBoardGenerator populatedFlagsOfSector: sector];
	
	NSUInteger horzSectorIndex1 = 0;
	NSUInteger horzSectorIndex2 = 0;
	NSUInteger vertSectorIndex1 = 0;
	NSUInteger vertSectorIndex2 = 0;
	
	switch ([sector sectorId]) {
		case 0:
			horzSectorIndex1 = 1;
			horzSectorIndex2 = 2;
			vertSectorIndex1 = 3;
			vertSectorIndex2 = 6;
			break;
		case 1:
			horzSectorIndex1 = 0;
			horzSectorIndex2 = 2;
			vertSectorIndex1 = 4;
			vertSectorIndex2 = 7;
			break;
		case 2:
			horzSectorIndex1 = 0;
			horzSectorIndex2 = 1;
			vertSectorIndex1 = 5;
			vertSectorIndex2 = 8;
			break;
		case 3:
			horzSectorIndex1 = 4;
			horzSectorIndex2 = 5;
			vertSectorIndex1 = 0;
			vertSectorIndex2 = 6;
			break;
		case 4:
			horzSectorIndex1 = 3;
			horzSectorIndex2 = 5;
			vertSectorIndex1 = 1;
			vertSectorIndex2 = 7;
			break;
		case 5:
			horzSectorIndex1 = 3;
			horzSectorIndex2 = 4;
			vertSectorIndex1 = 2;
			vertSectorIndex2 = 8;
			break;
		case 6:
			horzSectorIndex1 = 7;
			horzSectorIndex2 = 8;
			vertSectorIndex1 = 0;
			vertSectorIndex2 = 3;
			break;
		case 7:
			horzSectorIndex1 = 6;
			horzSectorIndex2 = 8;
			vertSectorIndex1 = 1;
			vertSectorIndex2 = 4;
			break;
		case 8:
			horzSectorIndex1 = 6;
			horzSectorIndex2 = 7;
			vertSectorIndex1 = 2;
			vertSectorIndex2 = 5;
			break;
	}
	
	SudokuBoardSector *horzSector1 = [board sectorWithSectorId: horzSectorIndex1];
	SudokuBoardSector *horzSector2 = [board sectorWithSectorId: horzSectorIndex2];
	SudokuBoardSector *vertSector1 = [board sectorWithSectorId: vertSectorIndex1];
	SudokuBoardSector *vertSector2 = [board sectorWithSectorId: vertSectorIndex2];
	
	[SudokuBoardGenerator markApplicableHorizontal: YES linesInSector: horzSector1 withRandomNumber: randomNumber asPopulatedWithPopulatedFlags: populatedFlags];
	[SudokuBoardGenerator markApplicableHorizontal: YES linesInSector: horzSector2 withRandomNumber: randomNumber asPopulatedWithPopulatedFlags: populatedFlags];
	[SudokuBoardGenerator markApplicableHorizontal: NO linesInSector: vertSector1 withRandomNumber: randomNumber asPopulatedWithPopulatedFlags: populatedFlags];
	[SudokuBoardGenerator markApplicableHorizontal: NO linesInSector: vertSector2 withRandomNumber: randomNumber asPopulatedWithPopulatedFlags: populatedFlags];
	
	NSInteger unpopulatedCount = 0;
	for (NSInteger z = 0; z < 9; z++) {
		if (populatedFlags[z] == NO) {
			unpopulatedCount++;
		}
	}
	
	NSMutableArray *indices = [NSMutableArray arrayWithCapacity: unpopulatedCount];
	
	NSInteger *tempNumArray = malloc(unpopulatedCount * sizeof(NSInteger));
	NSInteger index = 0;
	for (NSInteger i = 0; i < 9; i++) {
		if (populatedFlags[i] == NO) {
			tempNumArray[index] = i;
			index++;
		}
	}
	
	for (NSInteger i = 0; i < unpopulatedCount; i++) {
		NSNumber *index = [NSNumber numberWithInteger: tempNumArray[i]];
		[indices addObject: index];
	}
	
	free(tempNumArray);
	free(populatedFlags);
	
	return indices;
}

+ (BOOL *) populatedFlagsOfSector: (SudokuBoardSector *) sector {
	
	BOOL *flags = calloc(9, sizeof(BOOL));
	NSUInteger *numbers = [sector numbers];
	
	for (NSInteger i = 0; i < 9; i++) {
		flags[i] = (numbers[i] != 0);
	}
	
	return flags;
}

+ (void) markApplicableHorizontal: (BOOL) horizontal linesInSector: (SudokuBoardSector *) sector withRandomNumber: (NSUInteger) randomNumber asPopulatedWithPopulatedFlags: (BOOL *) populatedFlags {
	
	NSUInteger *numbers = [sector numbers];
	for (int i = 0; i < 9; i++) {
		if (numbers[i] == randomNumber) {
			[SudokuBoardGenerator markHorizontal: horizontal
							   lineOfNumberIndex: i
				   asPopulatedWithPopulatedFlags: populatedFlags];
			break;
		}
	}
}

+ (void) markHorizontal: (BOOL) horizontal lineOfNumberIndex: (NSInteger) numberIndex asPopulatedWithPopulatedFlags: (BOOL *) populatedFlags {
	
	if (horizontal) {
		if (numberIndex == 0 || numberIndex == 1 || numberIndex == 2) {
			populatedFlags[0] = populatedFlags[1] = populatedFlags[2] = YES;
			return;
		}
		
		if (numberIndex == 3 || numberIndex == 4 || numberIndex == 5) {
			populatedFlags[3] = populatedFlags[4] = populatedFlags[5] = YES;
			return;
		}
		
		if (numberIndex == 6 || numberIndex == 7 || numberIndex == 8) {
			populatedFlags[6] = populatedFlags[7] = populatedFlags[8] = YES;
			return;
		}
	} else {
		if (numberIndex == 0 || numberIndex == 3 || numberIndex == 6) {
			populatedFlags[0] = populatedFlags[3] = populatedFlags[6] = YES;
			return;
		}
		
		if (numberIndex == 1 || numberIndex == 4 || numberIndex == 7) {
			populatedFlags[1] = populatedFlags[4] = populatedFlags[7] = YES;
			return;
		}
		
		if (numberIndex == 2 || numberIndex == 5 || numberIndex == 8) {
			populatedFlags[2] = populatedFlags[5] = populatedFlags[8] = YES;
			return;
		}
	}
}

+ (void) resetBoard: (SudokuBoard *) board forRandomNumber: (NSInteger) randomNumber {
	
	for (NSInteger sectorId = 0; sectorId < 9; sectorId++) {
		SudokuBoardSector *sector = [board sectorWithSectorId: sectorId];
		NSUInteger *numbers = [sector numbers];
		
		for (NSInteger i = 0; i < 9; i++) {
			if (numbers[i] == randomNumber) {
				numbers[i] = 0;
			}
		}
	}
}

@end
