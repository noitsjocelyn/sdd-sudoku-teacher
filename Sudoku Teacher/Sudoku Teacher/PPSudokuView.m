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

+ (UIColor *)userValueColor
{
    UIColor *theColor = [UIColor colorWithRed:0.055 green:0.471 blue:0.998 alpha:1.0];
    return theColor;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Get the context and set the color
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    if (self.frame.size.width == 320.0)
    {
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
    else if (self.frame.size.width == 218.0)
    {
        // Cells are 24 pixels wide, roughly
        // Draw the horizontal lines
        CGContextFillRect(context, CGRectMake(1.0, 25.0, 216.0, 0.5));
        CGContextFillRect(context, CGRectMake(1.0, 49.0, 216.0, 0.5));
        CGContextFillRect(context, CGRectMake(1.0, 73.0, 216.0, 1.0));
        CGContextFillRect(context, CGRectMake(1.0, 97.0, 216.0, 0.5));
        // Doesn't divide evenly, so the 1.5 extra pixels goes here
        CGContextFillRect(context, CGRectMake(1.0, 121.5, 216.0, 0.5));
        CGContextFillRect(context, CGRectMake(1.0, 145.5, 216.0, 1.0));
        CGContextFillRect(context, CGRectMake(1.0, 169.5, 216.0, 0.5));
        CGContextFillRect(context, CGRectMake(1.0, 193.5, 216.0, 0.5));
        // Draw the vertical lines
        CGContextFillRect(context, CGRectMake(25.0, 1.0, 0.5, 216.0));
        CGContextFillRect(context, CGRectMake(49.0, 1.0, 0.5, 216.0));
        CGContextFillRect(context, CGRectMake(73.0, 1.0, 1.0, 216.0));
        CGContextFillRect(context, CGRectMake(97.0, 1.0, 0.5, 216.0));
        // 1.5 extra pixels again
        CGContextFillRect(context, CGRectMake(121.5, 1.0, 0.5, 216.0));
        CGContextFillRect(context, CGRectMake(145.5, 1.0, 1.0, 216.0));
        CGContextFillRect(context, CGRectMake(169.5, 1.0, 0.5, 216.0));
        CGContextFillRect(context, CGRectMake(193.5, 1.0, 0.5, 216.0));
    }
}

@end
