//
//  KJGridLayout.h
//  KJGridLayoutDemo
//
//  Created by Kristopher Johnson on 3/14/12.
//  Copyright (c) 2012 Kristopher Johnson 
//

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

@property (nonatomic) CGRect bounds;

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
