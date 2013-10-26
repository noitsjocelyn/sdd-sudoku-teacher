//
//  PPSudokuView.m
//  Sudoku Teacher
//
//  Created by Jonathan on 10/25/13.
//  Copyright (c) 2013 Puzzle Professors. All rights reserved.
//

#import "PPSudokuView.h"

@implementation PPSudokuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
		
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
	// Get the context and set the color
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
	// Cells are 35 pixels wide, roughly
	// Draw the horizontal lines
	CGContextFillRect(context, CGRectMake(2.0, 37.0, 316.0, 0.5));
	CGContextFillRect(context, CGRectMake(2.0, 72.0, 316.0, 0.5));
	CGContextFillRect(context, CGRectMake(2.0, 107.0, 316.0, 1.0));
	CGContextFillRect(context, CGRectMake(2.0, 142.0, 316.0, 0.5));
	// Doesn't divide evenly, so the 1.5 extra pixels goes here
	CGContextFillRect(context, CGRectMake(2.0, 178.5, 316.0, 0.5));
	CGContextFillRect(context, CGRectMake(2.0, 213.5, 316.0, 1.0));
	CGContextFillRect(context, CGRectMake(2.0, 248.5, 316.0, 0.5));
	CGContextFillRect(context, CGRectMake(2.0, 283.5, 316.0, 0.5));
	// Draw the vertical lines
	CGContextFillRect(context, CGRectMake(37.0, 2.0, 0.5, 316.0));
	CGContextFillRect(context, CGRectMake(72.0, 2.0, 0.5, 316.0));
	CGContextFillRect(context, CGRectMake(107.0, 2.0, 1.0, 316.0));
	CGContextFillRect(context, CGRectMake(142.0, 2.0, 0.5, 316.0));
	// 1.5 extra pixels again
	CGContextFillRect(context, CGRectMake(178.5, 2.0, 0.5, 316.0));
	CGContextFillRect(context, CGRectMake(213.5, 2.0, 1.0, 316.0));
	CGContextFillRect(context, CGRectMake(248.5, 2.0, 0.5, 316.0));
	CGContextFillRect(context, CGRectMake(283.5, 2.0, 0.5, 316.0));
}

@end
