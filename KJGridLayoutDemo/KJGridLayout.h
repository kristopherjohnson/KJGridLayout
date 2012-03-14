//
//  KJGridLayout.h
//  KJGridLayoutDemo
//
//  Created by Kristopher Johnson on 3/14/12.
//  Copyright (c) 2012 Kristopher Johnson 
//

#import <UIKit/UIKit.h>

@interface KJGridLayout : NSObject {
@private
    NSMutableArray *constraints;
}

@property (nonatomic) CGRect bounds;

// Add a view at specified row and column
- (void)addView:(UIView *)view row:(NSUInteger)rowIndex column:(NSUInteger)columnIndex;

// Add a view at specified row and column that spans multiple columns
- (void)addView:(UIView *)view row:(NSUInteger)rowIndex column:(NSUInteger)columnIndex columnSpan:(NSUInteger)columnSpan;

// Add a view at specified row and column that spans multiple rows
- (void)addView:(UIView *)view row:(NSUInteger)rowIndex rowSpan:(NSUInteger)rowSpan column:(NSUInteger)columnIndex;

// Add a view at specified rows and columns
- (void)addView:(UIView *)view row:(NSUInteger)rowIndex rowSpan:(NSUInteger)rowSpan column:(NSUInteger)columnIndex columnSpan:(NSUInteger)columnSpan;

// Set the frames of all views according to current layout properties
- (void)layoutViews;

// Return a collection containing all of the views in this layout
- (NSArray *)views;

// Remove specified view from the layout
- (void)removeView:(UIView *)view;

// Remove all views from the layout
- (void)removeAllViews;

@end
