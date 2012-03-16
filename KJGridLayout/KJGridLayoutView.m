//
//  KJGridLayoutView.m
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

#import "KJGridLayoutView.h"

@implementation KJGridLayoutView

- (void)awakeFromNib {
    [super awakeFromNib];
    _gridLayout = [[KJGridLayout alloc] init];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _gridLayout = [[KJGridLayout alloc] init];
    }
    return self;
}

- (void)dealloc {
    // Note: the "_gridLayout = nil;" is necessary here, to prevent dangling
    // reference from being accessed by -willRemoveSubview, which will be
    // called during [super dealloc];
    [_gridLayout release];
    _gridLayout = nil;
    
    [super dealloc];
}

- (CGFloat)rowSpacing {
    return _gridLayout.rowSpacing;
}

- (void)setRowSpacing:(CGFloat)newRowSpacing {
    if (newRowSpacing != _gridLayout.rowSpacing) {
        [_gridLayout setRowSpacing:newRowSpacing];
        [self setNeedsLayout];
    }
}

- (CGFloat)columnSpacing {
    return _gridLayout.columnSpacing;
}

- (void)setColumnSpacing:(CGFloat)newColumnSpacing {
    if (newColumnSpacing != _gridLayout.columnSpacing) {
        [_gridLayout setColumnSpacing:newColumnSpacing];
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews {
    [_gridLayout setBounds:[self bounds]];
    [_gridLayout layoutViews];
}

- (void)willRemoveSubview:(UIView *)subview {
    [_gridLayout removeView:subview];
}

// Add a view at specified rows and columns with specified layout options
- (void)addSubview:(UIView *)view
               row:(NSUInteger)rowIndex
           rowSpan:(NSUInteger)rowSpan
            column:(NSUInteger)columnIndex
        columnSpan:(NSUInteger)columnSpan
           options:(NSUInteger)options
{
    [_gridLayout addView:view
                     row:rowIndex
                 rowSpan:rowSpan
                  column:columnIndex
              columnSpan:columnSpan
                 options:options];
    [self addSubview:view];
    [self setNeedsLayout];    
}

- (void)addSubview:(UIView *)view
               row:(NSUInteger)rowIndex
            column:(NSUInteger)columnIndex
{
    [self addSubview:view
                 row:rowIndex
             rowSpan:1
              column:columnIndex
          columnSpan:1
             options:KJGridLayoutDefaultOptions];
}

- (void)addSubview:(UIView *)view
               row:(NSUInteger)rowIndex
            column:(NSUInteger)columnIndex
        columnSpan:(NSUInteger)columnSpan
{
    [self addSubview:view
                 row:rowIndex
             rowSpan:1
              column:columnIndex
          columnSpan:columnSpan
             options:KJGridLayoutDefaultOptions];
}

- (void)addSubview:(UIView *)view
               row:(NSUInteger)rowIndex
           rowSpan:(NSUInteger)rowSpan
            column:(NSUInteger)columnIndex
{
    [self addSubview:view
                 row:rowIndex
             rowSpan:rowSpan
              column:columnIndex
          columnSpan:1
             options:KJGridLayoutDefaultOptions];
}

@end
