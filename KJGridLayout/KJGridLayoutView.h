//
//  KJGridLayoutView.h
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

#import "KJGridLayout.h"

// UIView subclass that provides grid-based layout of subviews.

@interface KJGridLayoutView : UIView {
@private
    KJGridLayout *_gridLayout;
}

// Empty space between rows. Defaults to 0.
@property (nonatomic) CGFloat rowSpacing;

// Empty space between columns. Defaults to 0.
@property (nonatomic) CGFloat columnSpacing;

// Add a subview at specified rows and columns with specified layout options
- (void)addSubview:(UIView *)view
               row:(NSUInteger)rowIndex
           rowSpan:(NSUInteger)rowSpan
            column:(NSUInteger)columnIndex
        columnSpan:(NSUInteger)columnSpan
           options:(NSUInteger)options;

// Add subview at specified row and column
- (void)addSubview:(UIView *)view row:(NSUInteger)rowIndex column:(NSUInteger)columnIndex;

// Add subview at specified row and column with specified column span
- (void)addSubview:(UIView *)view row:(NSUInteger)rowIndex column:(NSUInteger)columnIndex columnSpan:(NSUInteger)columnSpan;

// Add subview at specified row and column with specified row span
- (void)addSubview:(UIView *)view row:(NSUInteger)rowIndex rowSpan:(NSUInteger)rowSpan column:(NSUInteger)columnIndex;

@end
