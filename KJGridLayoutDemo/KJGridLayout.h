//
//  KJGridLayout.h
//  KJGridLayoutDemo
//
// Copyright (C) 2012 Kristopher Johnson
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>

// Options bitmasks for use with KJGridLayout
enum KJGridLayoutOption {
    KJGridLayoutDefaultOptions = 0,
    
    // Do not change width of view during layout
    KJGridLayoutFixedWidth = (1 << 0),
    
    // Do not change height of view during layout
    KJGridLayoutFixedHeight = (1 << 1),
    
    // Do not change width or height of view during layout
    KJGridLayoutFixedSize = KJGridLayoutFixedWidth | KJGridLayoutFixedHeight
};

// Grid layout manager

@interface KJGridLayout : NSObject {
@private
    NSMutableArray *constraints;
}

// Rectangle within which views will be laid out
@property (nonatomic) CGRect bounds;

// Empty space between adjacent columns
@property (nonatomic) CGFloat columnSpacing;

// Empty space between rows
@property (nonatomic) CGFloat rowSpacing;

// Add a view at specified rows and columns with specified layout options
- (void)addView:(UIView *)view
            row:(NSUInteger)rowIndex
        rowSpan:(NSUInteger)rowSpan
         column:(NSUInteger)columnIndex
     columnSpan:(NSUInteger)columnSpan
        options:(NSUInteger)options;

// Add a view at specified row and column
- (void)addView:(UIView *)view
            row:(NSUInteger)rowIndex
         column:(NSUInteger)columnIndex;

// Add a view at specified row and column with specified layout options
- (void)addView:(UIView *)view
            row:(NSUInteger)rowIndex
         column:(NSUInteger)columnIndex
        options:(NSUInteger)options;

// Add a view at specified row and column that spans multiple columns
- (void)addView:(UIView *)view
            row:(NSUInteger)rowIndex
         column:(NSUInteger)columnIndex
     columnSpan:(NSUInteger)columnSpan;

// Add a view at specified row and column that spans multiple rows
- (void)addView:(UIView *)view
            row:(NSUInteger)rowIndex
        rowSpan:(NSUInteger)rowSpan
         column:(NSUInteger)columnIndex;

// Add a view at specified rows and columns
- (void)addView:(UIView *)view
            row:(NSUInteger)rowIndex
        rowSpan:(NSUInteger)rowSpan
         column:(NSUInteger)columnIndex
     columnSpan:(NSUInteger)columnSpan;

// Remove specified view from the layout
- (void)removeView:(UIView *)view;

// Remove all views from the layout
- (void)removeAllViews;

// Set the frames of all views according to current layout properties
- (void)layoutViews;

// Return a collection containing all of the views in this layout
- (NSArray *)views;

@end
